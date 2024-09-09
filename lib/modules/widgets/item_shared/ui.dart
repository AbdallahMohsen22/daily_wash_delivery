import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:daily_wash/layout/cubit/app_cubit.dart';
import 'package:daily_wash/modules/widgets/item_shared/default_button.dart';
import 'package:daily_wash/shared/components/constants.dart';
import 'package:daily_wash/shared/styles/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toastification/toastification.dart';

import '../../../layout/cubit/app_states.dart';
import '../../../shared/images/images.dart';

enum MessageType { error, success, warning }

class UIAlert {
  static showCustomDailog(BuildContext context,
      {required String title,
        required VoidCallback onPressed,
        bool barrierDismissible = true,
        bool getLocation = false,
        String? subTitle,
        String? textButton,
      }) {
    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) async{
            if(getLocation){
              if (AppCubit.get(context).position == null) {
                final permission = await Geolocator.requestPermission();
                if(permission == LocationPermission.deniedForever){
                  if(state is! EmitState&&state is! LocationLoadingState)
                    openAppSettings();
                }
                if (permission == LocationPermission.always
                    || permission == LocationPermission.whileInUse) {
                  if(state is! LocationLoadingState)
                    AppCubit.get(context).getCurrentLocation(context);
                }
              }
              if (AppCubit.get(context).position != null) {
                Navigator.pop(context);
              }
            }
            },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    height: 450,
                    margin: EdgeInsets.only(
                        bottom: 20, left: 12, right: 12),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Images.success,
                          height: 150,
                          width: 150,
                          color: defaultColor,
                        ),
                        const Gap(10),
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Gap(5),
                        if (subTitle != null) ...[
                          Text(
                            subTitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ],
                        const Gap(20),
                        DefaultButton(
                          text: textButton ?? "done".tr(),
                          onTap: onPressed,
                        ),
                        if(getLocation)
                          const Gap(20),
                        if(getLocation)
                          ConditionalBuilder(
                            condition: state is! LocationLoadingState,
                            fallback: (context)=>CupertinoActivityIndicator(),
                            builder: (context)=> DefaultButton(
                              text: 'get_location'.tr(),
                              onTap: ()async{
                                final permission = await Geolocator.requestPermission();
                                if (AppCubit.get(context).position == null) {
                                  if(permission == LocationPermission.deniedForever){
                                    openAppSettings();
                                  }
                                  if (permission == LocationPermission.always
                                      || permission == LocationPermission.whileInUse) {
                                    await AppCubit.get(context).getCurrentLocation(context);
                                  }
                                }
                              },
                            ),
                          )
                      ],
                    )),
              ),
            );
          },
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
              .animate(anim1),
          child: child,
        );
      },
    );
  }


  static void showAlert(context, {message, type}) {
    Toastification().show(
      context: context,
      title: Text(message ?? "",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
      style: ToastificationStyle.fillColored,
      autoCloseDuration: const Duration(seconds: 5),
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
          spreadRadius: 0,
        )
      ],
      showProgressBar: true,
      backgroundColor: type == MessageType.error
          ? Colors.redAccent
          : type == MessageType.success
          ? Colors.green[200]
          : type == MessageType.warning
          ? Colors.amber
          : Colors.green[200],
    );
  }

}
