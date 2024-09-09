import 'package:daily_wash/modules/settings/cubit/settings_states.dart';
import 'package:daily_wash/modules/widgets/item_shared/account_is_locked.dart';
import 'package:daily_wash/shared/network/remote/dio.dart';
import 'package:daily_wash/shared/network/remote/end_point.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../layout/cubit/app_cubit.dart';
import '../../../models/delivery_model.dart';
import '../../../models/notification_model.dart';
import '../../../models/settings_model.dart';
import '../../../models/static_pages_model.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../splash_screen.dart';
import '../../widgets/item_shared/ui.dart';

class SettingsCubit extends Cubit<SettingsStates>{

  SettingsCubit (): super(InitSettingsState());

  static SettingsCubit get(context)=>BlocProvider.of(context);


  ImagePicker picker = ImagePicker();

  XFile? profileImage;

  DeliveryModel? deliveryModel;

  StaticPagesModel? staticPagesModel;

  SettingsModel? settingsModel;

  NotificationModel? notificationModel;

  ScrollController notificationScrollController = ScrollController();


  void emitState()=>emit(EmitState());

  void checkInterNet() async {
    InternetConnectionChecker().onStatusChange.listen((event) {
      final state = event == InternetConnectionStatus.connected;
      isConnect = state;
      emit(EmitState());
    });
  }

  void pick(ImageSource source) async {
    try {
      profileImage =  await picker.pickImage(source: source, imageQuality: 20);
      emit(ImageSuccessState());
    } catch (e) {
      print(e.toString());
      emit(ImageWrongState());
    }
  }

  void init(BuildContext context){
    getDelivery(context);
    getStaticPages();
    getSettings();
    checkInterNet();
    getNotification(context: context);
  }

  void getDelivery(BuildContext context){
    DioHelper.getData(
      url: EndPoints.getDelivery,
      token: 'Bearer $token'
    ).then((value) {
      if(value.data['data']!=null){
        deliveryModel = DeliveryModel.fromJson(value.data);
        emit(GetDeliverySuccessState());
        print(deliveryModel!.data!.personalPhoto);
        bool? stopExecute = value.data['data']['stop_execute'];
        if(stopExecute!=null){
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context)=>AccountIsBlocked()
          );
        }
      }else{
        UIAlert.showAlert(context,
          message: value.data['message'] ?? 'wrong'.tr(),
        );
        emit(GetDeliveryWrongState());
      }
    }).catchError((e){
      UIAlert.showAlert(context,
        message: e.toString(),
      );
      emit(GetDeliveryErrorState());
    });
  }


  void changeOnlineStatus(BuildContext context,int status){
    emit(ChangeOnlineStatusLoadingState());
    DioHelper.putData(
        url: EndPoints.changeOnlineStatus,
        token: 'Bearer $token',
      data: {'online_status':status}
    ).then((value) {
      if(value.data['status'] == true){
        UIAlert.showAlert(context,
          message: value.data['message'] ?? '',
        );
        getDelivery(context);
      }else{
        UIAlert.showAlert(context,
          message: value.data['message'] ?? 'wrong'.tr(),
        );
        emit(ChangeOnlineStatusWrongState());
      }
    }).catchError((e){
      UIAlert.showAlert(context,
        message: e.toString(),
      );
      emit(ChangeOnlineStatusErrorState());
    });
  }


  void updateProfileImage(BuildContext context)async{
    FormData formData = FormData();
    MultipartFile file = await  MultipartFile.fromFile(
        profileImage!.path,filename: profileImage!.path.split('/').last
    );
    formData.files.add(MapEntry('personal_photo', file));
    emit(UpdatePhotoLoadingState());
    DioHelper.postData2(
      url: EndPoints.updateProfileImage,
      token: 'Bearer $token',
      formData: formData,
    ).then((value) {
      print(value.data);
      if(value.data['status'] == true){
        UIAlert.showAlert(context,
          message: value.data['message'] ?? '',
        );
        profileImage = null;
        getDelivery(context);
        Navigator.pop(context);
      }else{
        UIAlert.showAlert(context,
          message: value.data['message'] ?? 'wrong'.tr(),
        );
        emit(UpdatePhotoWrongState());
      }
    }).catchError((e){
      UIAlert.showAlert(context,
        message: e.toString(),
      );
      emit(UpdatePhotoErrorState());
    });
  }


  void contactUs(BuildContext context,{
    required String subject,required String message}){
    emit(ContactUsLoadingState());
    DioHelper.postData(
        url: EndPoints.contactUs,
        token: 'Bearer $token',
        data:{
          'name':'Ahmed',
          'subject':subject,
          'message':message,
        }
    ).then((value) {
      if(value.data['status'] == true){
        UIAlert.showAlert(context,
          message: 'message_added'.tr(),
        );
        emit(ContactUsSuccessState());
        Navigator.pop(context);
      }else{
        UIAlert.showAlert(context,
          message: value.data['message'] ?? 'wrong'.tr(),
        );
        emit(ContactUsWrongState());
      }
    }).catchError((e){
      UIAlert.showAlert(context,
        message: e.toString(),
      );
      emit(ContactUsErrorState());
    });
  }

  void getStaticPages(){
    DioHelper.getData(
      url: EndPoints.getStaticPages,
    ).then((value) {
      if(value.data['data']!=null){
        staticPagesModel = StaticPagesModel.fromJson(value.data);
        emit(GetStaticPagesSuccessState());
      }
    }).catchError((e){
      emit(GetStaticPagesErrorState());
    });
  }


  void getSettings(){
    DioHelper.getData(
      url: EndPoints.getSettings,
    ).then((value) {
      if(value.data['data']!=null){
        settingsModel = SettingsModel.fromJson(value.data);
        emit(GetSettingsSuccessState());
      }
    }).catchError((e){
      emit(GetSettingsErrorState());
    });
  }


  void deleteAccount(BuildContext context){
    emit(DeleteAccountLoadingState());
    DioHelper.deleteData(
      url: EndPoints.deleteAccount,
      token: 'Bearer $token'
    ).then((value) {
      if(value.data['status']==true){
        token = null;
        userId = null;
        CacheHelper.removeData('userId');
        CacheHelper.removeData('token');
        emit(DeleteAccountSuccessState());
        navigateAndFinish(context, SplashScreen());
        AppCubit.get(context).changeIndex(0);
      }else{
        UIAlert.showAlert(context,
          message: value.data['message'] ?? 'wrong'.tr(),
        );
        emit(DeleteAccountWrongState());
      }
    }).catchError((e){
      UIAlert.showAlert(context,
        message: e.toString(),
      );
      emit(DeleteAccountErrorState());
    });
  }


  void getNotification({int page = 1,required BuildContext context}){
    emit(GetNotificationLoadingState());
    DioHelper.getData(
        url:'${EndPoints.notification}$page',
        token: 'Bearer $token',
    ).then((value) {
      if(value.data['status']==true&&value.data['data']!=null){
        if(page == 1) {
          notificationModel = NotificationModel.fromJson(value.data);
        }
        else{
          notificationModel!.data!.currentPage = value.data['data']['currentPage'];
          notificationModel!.data!.pages = value.data['data']['pages'];
          value.data['data']['data'].forEach((e){
            notificationModel!.data!.data!.add(NotificationData.fromJson(e));
          });
        }
        emit(GetNotificationSuccessState());
      }else{
        bool? stopExecute = value.data['data']['stop_execute'];
        if(stopExecute!=null){
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context)=>AccountIsBlocked()
          );
        }
        emit(GetNotificationWrongState());
      }
    }).catchError((e){
      print(e.toString());
      emit(GetNotificationErrorState());
    });
  }

  void paginationAllNotification(BuildContext context){
    notificationScrollController.addListener(() {
      if (notificationScrollController.offset == notificationScrollController.position.maxScrollExtent){
        if (notificationModel!.data!.currentPage != notificationModel!.data!.pages) {
          if(state is! GetNotificationLoadingState){
            int currentPage = notificationModel!.data!.currentPage! +1;
            getNotification(page: currentPage,context: context);
          }
        }
      }
    });
  }




}