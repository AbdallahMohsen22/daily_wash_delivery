import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:daily_wash/layout/app_layout.dart';
import 'package:daily_wash/layout/cubit/app_cubit.dart';
import 'package:daily_wash/shared/components/components.dart';
import 'package:flutter/material.dart';

import '../../../shared/images/images.dart';

class DefaultAppBar extends StatelessWidget {
  DefaultAppBar({
    required this.text,
    this.isNotification = false,
    this.haveArrow = true,
});

  String text;
  bool isNotification;
  bool haveArrow;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Image.asset(Images.appbar),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              children: [
                ConditionalBuilder(
                  condition: haveArrow,
                  builder:(c)=> InkWell(
                    onTap: ()=>Navigator.pop(context),
                      child: Icon(Icons.arrow_back_ios_outlined,)),
                  fallback:(c)=> SizedBox(),
                ),
                Expanded(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500,fontSize: 19),
                  ),
                ),
                ConditionalBuilder(
                  condition: !isNotification,
                  builder:(c)=> InkWell(
                      onTap: (){
                        AppCubit.get(context).changeIndex(0);
                        navigateAndFinish(context, AppLayout());
                      },
                      child: Image.asset(Images.notification2,width: 30,)
                  ),
                  fallback:(c)=> SizedBox(),
                ),

              ],
            ),
          ),
        )
      ],
    );
  }
}
