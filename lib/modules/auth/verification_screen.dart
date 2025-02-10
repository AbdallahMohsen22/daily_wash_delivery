import 'dart:async';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:daily_wash/modules/auth/auth_cubit/auth_cubit.dart';
import 'package:daily_wash/modules/auth/auth_cubit/auth_states.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';

import '../../layout/app_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/images/images.dart';
import '../../shared/styles/colors.dart';
import '../widgets/item_shared/default_button.dart';
import '../widgets/item_shared/otp_widget.dart';
import '../widgets/item_shared/ui.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {

  TextEditingController c1 = TextEditingController();

  TextEditingController c2 = TextEditingController();

  TextEditingController c3 = TextEditingController();

  TextEditingController c4 = TextEditingController();

  int _start = 60;

  bool timerFinished = false;

  late Timer timer;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            timerFinished = true;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  bool checkCode() {
    String codeFromOtp = c1.text +
        c2.text +
        c3.text +
        c4.text;
    return int.parse(myLocale == 'en'
        ? codeFromOtp
        : String.fromCharCodes(codeFromOtp.runes.toList().reversed)) ==
        code;
  }

  bool checkOTP() {
    if (c1.text.isEmpty ||
        c2.text.isEmpty ||
        c3.text.isEmpty ||
        c4.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void submit(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (checkOTP()) {
      if (checkCode()) {
        AuthCubit.get(context).verification(context);
      } else {
        UIAlert.showAlert(context,message: tr('code_invalid'),type: MessageType.warning);
      }
    } else {
      UIAlert.showAlert(context,message: tr('code_empty'),type: MessageType.warning);
    }
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
  listener: (context, state) {},
  builder: (context, state) {
    return Scaffold(
      body: SingleChildScrollView(
        child: InkWell(
          onTap: ()=>FocusManager.instance.primaryFocus?.unfocus(),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(Images.splash,height: 116,width: 116,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 35.0),
                  child: Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                          text: '${tr('continue_with')} \n',
                          style: TextStyle(fontSize: 35.5,fontWeight: FontWeight.w600,color: signTextColor,height: 1.2),
                          children: [
                            TextSpan(
                                text: '${tr('verifying')}  ',
                                style: TextStyle(fontSize: 35.5,fontWeight: FontWeight.w800,color: defaultColor),
                              children: [
                                TextSpan(
                                  text: tr('account'),
                                  style: TextStyle(fontSize: 35.5,fontWeight: FontWeight.w600,color: signTextColor,height: 1.2),
                                )
                              ]
                            )
                          ]
                      )
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 50,
                      child: OTPWidget(
                        controller: c1,
                        autoFocus: myLocale == 'en'|| myLocale == 'ur'?true:false,
                        onFinished: () {
                          if (checkOTP() && myLocale != 'en'&& myLocale != 'ur') {
                            submit(context);
                          }
                        },
                      ),
                    ),
                    Container(
                      width: 50,
                      child: OTPWidget(
                        controller: c2,
                      ),
                    ),
                    Container(
                      width: 50,
                      child: OTPWidget(
                        controller: c3,
                      ),
                    ),
                    Container(
                      width: 50,
                      child: OTPWidget(
                        controller: c4,
                        autoFocus: myLocale == 'ar'?true:false,
                        onFinished: () {
                          if (checkOTP() && myLocale != 'ar' && myLocale == 'ur'||myLocale == 'en') {
                            submit(context);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0,bottom: 15),
                  child: ConditionalBuilder(
                    condition: state is! VerificationLoadingState,
                    fallback: (context)=>CupertinoActivityIndicator(),
                    builder: (context)=> DefaultButton(
                      text: tr('verification'),
                      onTap: (){
                        submit(context);
                      },
                    ),
                  ),
                ),
                ConditionalBuilder(
                  condition:timerFinished,
                  builder:(c)=> InkWell(
                    onTap: () {
                      timer;
                      _start = 60;
                      timerFinished = false;
                      startTimer();
                      AuthCubit.get(context).login(context: context,fromLogin: false);
                    },
                    child:Text(
                      tr('try_again'),
                    ),
                  ),
                  fallback:(c)=>Text(
                    '00:$_start',
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  },
);
  }
}
