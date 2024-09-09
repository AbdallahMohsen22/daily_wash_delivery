import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:daily_wash/layout/cubit/app_cubit.dart';
import 'package:daily_wash/layout/cubit/app_states.dart';
import 'package:daily_wash/modules/settings/cubit/settings_cubit.dart';
import 'package:daily_wash/modules/settings/cubit/settings_states.dart';
import 'package:daily_wash/modules/wrong_screens/maintenance.dart';
import 'package:daily_wash/modules/wrong_screens/no_net.dart';
import 'package:daily_wash/shared/components/components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/components/constants.dart';
import '../shared/images/images.dart';
import 'nav_bar.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingsCubit.get(context).init(context);
    AppCubit.get(context).init(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if(isConnect!=null)checkNet(context);
      },
      builder: (context, state) {
        return BlocConsumer<SettingsCubit, SettingsStates>(
          listener: (context, state) {
            if(isConnect!=null)checkNet(context);
            if(SettingsCubit.get(context).settingsModel?.data?.isProjectInFactoryMode == 2){
              navigateAndFinish(context, Maintenance());
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: Padding(
                padding: EdgeInsets.only(top: 20),
                child: AppCubit.get(context).screens[AppCubit.get(context).currentIndex],
              ),
              bottomNavigationBar: NavBar(
                items: [
                  {
                    'icon':
                    Image.asset(Images.notificationNotSelect,width: 20,height: 20),
                    'activeIcon':
                    Image.asset(Images.notificationSelect,width: 20,height: 20),
                  },
                  {
                    'icon':
                    Image.asset(Images.homeNotSelect,width: 20,height: 20,),
                    'activeIcon':
                    Image.asset(Images.homeSelect,width: 20,height: 20,),
                  },
                  {
                    'icon':
                    Image.asset(Images.settingNotSelect,width: 20,height: 20,),
                    'activeIcon':
                    Image.asset(Images.settingSelect,width: 20,height: 20),
                  },
                ],
              ),
            );
            },
        );
      },
    );
  }
}
