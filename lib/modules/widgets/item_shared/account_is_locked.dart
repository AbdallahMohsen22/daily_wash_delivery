import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:daily_wash/modules/settings/cubit/settings_cubit.dart';
import 'package:daily_wash/modules/settings/cubit/settings_states.dart';
import 'package:daily_wash/modules/widgets/item_shared/default_button.dart';
import 'package:daily_wash/shared/images/images.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/cubit/app_cubit.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../splash_screen.dart';

class AccountIsBlocked extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Dialog(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(30),
                color: Colors.white
            ),
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(Images.inactive, width: 150,),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, bottom: 20),
                  child: Text(
                    'contact_admin'.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                ),
                Center(
                  child: DefaultButton(
                      text: tr('logout'),
                      width: double.infinity,
                      onTap: (){
                        token = null;
                        userId = null;
                        CacheHelper.removeData('userId');
                        CacheHelper.removeData('token');
                        SettingsCubit.get(context).deliveryModel = null;
                        navigateAndFinish(context, SplashScreen());
                        AppCubit.get(context).changeIndex(0);

                      }
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
