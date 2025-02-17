import 'dart:io';

import 'package:daily_wash/layout/cubit/app_cubit.dart';
import 'package:daily_wash/modules/auth/auth_cubit/auth_cubit.dart';
import 'package:daily_wash/modules/auth/login_screen.dart';
import 'package:daily_wash/modules/home/home_screen.dart';
import 'package:daily_wash/modules/settings/cubit/settings_cubit.dart';
import 'package:daily_wash/modules/settings/settings_screen.dart';
import 'package:daily_wash/shared/bloc_observer/bloc_observer.dart';
import 'package:daily_wash/shared/components/constants.dart';
import 'package:daily_wash/shared/firebase_helper/firebase_options.dart';
import 'package:daily_wash/shared/firebase_helper/notification_helper.dart';
import 'package:daily_wash/shared/network/local/cache_helper.dart';
import 'package:daily_wash/shared/network/remote/dio.dart';
import 'package:daily_wash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'layout/app_layout.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  try{
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform
    );

    NotificationHelper();
    fcmToken = await FirebaseMessaging.instance.getToken();
  }catch(e){
    print(e.toString());
  }
  await CacheHelper.init();

  DioHelper.init();

  String? loca = CacheHelper.getData(key: 'locale');
  token = CacheHelper.getData(key: 'token');
  print('Token=====<<>> $token');
  userId = CacheHelper.getData(key: 'userId');
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  version = packageInfo.version;


  if(loca !=null){
    myLocale = loca;
  }else{
    Platform.localeName.contains('ar')
        ?myLocale = 'ar'
        :Platform.localeName.contains('ur')
        ?myLocale = 'ur'
        :myLocale = 'en';
  }

  BlocOverrides.runZoned(
        () {
      runApp(
        EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('ar'),Locale('ur')],
          useOnlyLangCode: true,
          path: 'assets/langs',
          fallbackLocale: const Locale('en'),
          startLocale: Locale(myLocale),
          child: const MyApp(),
        ),
      );
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>AppCubit()),
        BlocProvider(create: (context)=>SettingsCubit()),
        BlocProvider(create: (context)=>AuthCubit())
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Cairo',
        ),
        builder: (context, child) {
          return MediaQuery(
            child: child!,
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          );
        },
        home: LoginScreen(),
        // home: HomeScreen(),
      ),
    );
  }
}
/// 0562442134