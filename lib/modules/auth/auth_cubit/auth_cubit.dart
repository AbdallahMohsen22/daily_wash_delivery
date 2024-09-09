import 'package:daily_wash/layout/app_layout.dart';
import 'package:daily_wash/modules/auth/auth_cubit/auth_states.dart';
import 'package:daily_wash/modules/auth/verification_screen.dart';
import 'package:daily_wash/modules/settings/cubit/settings_cubit.dart';
import 'package:daily_wash/modules/widgets/item_shared/ui.dart';
import 'package:daily_wash/shared/components/components.dart';
import 'package:daily_wash/shared/network/local/cache_helper.dart';
import 'package:daily_wash/shared/network/remote/dio.dart';
import 'package:daily_wash/shared/network/remote/end_point.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/constants.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitState());

  static AuthCubit get(context) => BlocProvider.of(context);

  TextEditingController phoneController = TextEditingController();


  void login({
    required BuildContext context,
    bool fromLogin = true
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
        url: EndPoints.log,
        data: {
          "phone_number": phoneController.text.trim(),
          "firebase_token":fcmToken??'',
        },
    ).then((value) => {
      print(value.data),
      if (value.data['data']!=null)
      {
        code = value.data['data']['code'],
        userId = value.data['data']['user_id'],
        UIAlert.showAlert(
          context,
          message: '${'code_is'.tr()} $code',
        ),
        emit(LoginSuccessState()),
        if(fromLogin)navigateAndFinish(context, VerificationScreen()),
      }
      else
      {
        // showDialog(
        //     context: context,
        //     builder: (context)=>FalsePhoneDialog()
        // );
        UIAlert.showAlert(context,
            message: value.data['message'] ?? 'wrong'.tr(),
        ),
        emit(LoginWrongState()),

      }
    }).catchError((e) {
      UIAlert.showAlert(context, message: e.toString());
      emit(LoginErrorState());
    });
  }

  void verification(BuildContext context,) {
    emit(VerificationLoadingState());
    DioHelper.postData(
      url: EndPoints.verification,
      data: {"delivery_man_id": userId,"code":code},
    ).then((value) => {
      print(value.data),
      if (value.data['data']!=null)
        {
          token = value.data['data']['token'],
          CacheHelper.saveData(key: 'token', value: token),
          CacheHelper.saveData(key: 'userId', value: userId),
          UIAlert.showAlert(
            context,
            message: value.data['message'],
          ),
          emit(VerificationSuccessState()),
          navigateAndFinish(context, AppLayout()),
        }
      else
        {
          // showDialog(
          //     context: context,
          //     builder: (context)=>FalsePhoneDialog()
          // );
          UIAlert.showAlert(context,
            message: value.data['message'] ?? 'wrong'.tr(),
          ),
          emit(VerificationWrongState()),

        }
    }).catchError((e) {
      UIAlert.showAlert(context, message: e.toString());
      emit(VerificationErrorState());
    });
  }


}
