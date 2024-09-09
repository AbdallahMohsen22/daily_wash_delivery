import 'dart:async';
import 'package:daily_wash/layout/app_layout.dart';
import 'package:daily_wash/shared/components/components.dart';
import 'package:daily_wash/shared/components/constants.dart';
import 'package:daily_wash/shared/images/images.dart';
import 'package:flutter/material.dart';
import 'modules/auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late Timer timer;

  @override
  void initState() {
    timer = Timer(Duration(seconds: 3),(){
      if(token==null){
        navigateAndFinish(context, LoginScreen());
      }else{
        navigateAndFinish(context, AppLayout());
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Images.background),
            fit: BoxFit.cover
          )
        ),
        child: Center(
          child: Image.asset(Images.splash,height: 172,width: 172,),
        ),
      ),
    );
  }
}
