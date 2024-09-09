import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:daily_wash/layout/cubit/app_cubit.dart';
import 'package:daily_wash/modules/settings/cubit/settings_cubit.dart';
import 'package:daily_wash/modules/settings/cubit/settings_states.dart';
import 'package:daily_wash/modules/settings/settings_screens/aboutus_screen.dart';
import 'package:daily_wash/modules/settings/settings_screens/compliments_screen.dart';
import 'package:daily_wash/modules/settings/settings_screens/contactus_screen.dart';
import 'package:daily_wash/modules/settings/settings_screens/terms_screen.dart';
import 'package:daily_wash/modules/widgets/item_shared/default_button.dart';
import 'package:daily_wash/modules/widgets/item_shared/default_form.dart';
import 'package:daily_wash/modules/widgets/item_shared/shimmer.dart';
import 'package:daily_wash/modules/widgets/settings/lang.dart';
import 'package:daily_wash/shared/components/components.dart';
import 'package:daily_wash/shared/images/images.dart';
import 'package:daily_wash/shared/network/local/cache_helper.dart';
import 'package:daily_wash/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../shared/components/constants.dart';
import '../../shared/styles/colors.dart';
import '../widgets/settings/log_dialog.dart';
import '../widgets/settings/profile_info/profile_image.dart';
import '../widgets/settings/setting_item.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SettingsCubit.get(context);
        return Scaffold(
          body: Stack(
            children: [
              Image.asset(Images.appbar),
              SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Column(
                              children: [
                                ProfileImage(),
                                if(cubit.deliveryModel!=null)
                                Text(
                                  tr('welcome'),
                                  style: TextStyle(
                                    color: Colors.grey.shade400
                                  ),
                                ),
                                ConditionalBuilder(
                                  condition: cubit.deliveryModel!=null,
                                  fallback: (context)=>CustomShimmer(width: 200, height: 40),
                                  builder: (context)=> Text(
                                    cubit.deliveryModel!.data!.name??'',
                                    style: TextStyle(
                                      color: Colors.black,fontWeight: FontWeight.w500,fontSize: 30
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0,bottom: 30),
                                  child: ConditionalBuilder(
                                    condition: cubit.deliveryModel!=null&&state is! ChangeOnlineStatusLoadingState,
                                    fallback: (context)=>CustomShimmer(width: 95, height: 36),
                                    builder: (context)=> InkWell(
                                      onTap: ()=>cubit.changeOnlineStatus(
                                          context,
                                        cubit.deliveryModel!.data!.onlineStatus == 1?2:1,
                                      ),
                                      child: Image.asset(
                                        cubit.deliveryModel!.data!.onlineStatus == 1 ?Images.active:Images.inactive,
                                        height: 36,width: 95,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Text(
                          //   tr('id_number'),
                          //   style: TextStyle(fontSize: 12,color: Colors.grey.shade500),
                          // ),
                          // DefaultForm(
                          //     controller: TextEditingController(text:'${cubit.deliveryModel?.data?.itemNumber??""}'),
                          //     readOnly:true,
                          //     hint: tr('id_number')
                          // ),
                          // const SizedBox(height: 30,),
                          Text(
                            tr('phone'),
                            style: TextStyle(fontSize: 12,color: Colors.grey.shade500),
                          ),
                          DefaultForm(
                              controller: TextEditingController(text: cubit.deliveryModel?.data?.phoneNumber??''),
                              readOnly:true,
                              hint: '+971 xxxxxxxx'
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Divider(),
                          ),
                          SettingItem(
                            text: tr('compliments'),
                            image: Images.compliments,
                            onTap: (){
                              navigateTo(context, ComplimentsScreen());
                            },
                          ),
                          SettingItem(
                            text: tr('notifications'),
                            image: Images.notificationSettings,
                            onTap: (){
                              AppCubit.get(context).changeIndex(0);
                            },
                          ),
                          SettingItem(
                            text: tr('contact_us'),
                            image: Images.contactus,
                            onTap: (){
                              navigateTo(context, ContactUsScreen());
                            },
                          ),
                          SettingItem(
                            text: tr('about_us'),
                            image: Images.abuotus,
                            onTap: (){
                              navigateTo(context, AboutUsScreen());
                            },
                          ),
                          SettingItem(
                            text: tr('terms'),
                            image: Images.terms,
                            onTap: (){
                              navigateTo(context, TermsScreen());
                            },
                          ),
                          SettingItem(
                            text: tr('lang'),
                            image: Images.lang,
                            onTap: (){
                              showDialog(context: context, builder:(context)=> LangDialog());
                            },
                          ),
                          // GestureDetector(
                          //   onTap: () {
                          //     openUrl('https://pavilion-teck.com');
                          //   },
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Row(
                          //         children: [
                          //           Text(
                          //             "powered_by".tr(),
                          //           ),
                          //           const Gap(4),
                          //           Image.asset(
                          //             Images.pavilion,
                          //             height: 20,
                          //             width: 20,
                          //           )
                          //         ],
                          //       ),
                          //       Text(
                          //         "${"version".tr()} $version",
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0,bottom: 15),
                            child: DefaultButton(
                                text: tr('logout'),
                                width: double.infinity,
                                onTap: (){
                                  showDialog(
                                      context: context,
                                      builder: (context)=>LogDialog(
                                        onTap: (){
                                          token = null;
                                          userId = null;
                                          CacheHelper.removeData('userId');
                                          CacheHelper.removeData('token');
                                          cubit.deliveryModel = null;
                                          navigateAndFinish(context, SplashScreen());
                                          AppCubit.get(context).changeIndex(0);
                                        },
                                        image: Images.logout,
                                        hint: tr('logout_sure'),
                                        buttonText: tr('logout'),
                                      )
                                  );
                                }
                            ),
                          ),
                          Center(
                            child: TextButton(
                                onPressed: (){
                                  showDialog(
                                      context: context,
                                      builder: (context)=>LogDialog(
                                        onTap: (){
                                          cubit.deleteAccount(context);
                                        },
                                        image: Images.delete,
                                        hint: tr('delete_account_sure'),
                                        buttonText: tr('delete_account'),
                                      )
                                  );
                                },
                                child: Text(
                                  tr('delete_account'),
                                  style: TextStyle(fontWeight: FontWeight.w700,fontSize: 19,color: Colors.grey.shade800),
                                )
                            ),
                          )
                        ],
                      ),
                    ),
                  )
              ),
            ],
          ),
        );
      },
    );
  }
}
