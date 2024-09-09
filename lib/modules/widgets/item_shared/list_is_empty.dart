import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../shared/images/images.dart';

class ListIsEmpty extends StatelessWidget {
  ListIsEmpty(this.title);
  String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Gap(100),
        Image.asset(Images.splash,width: 200,height: 200,),
        const Gap(10),
        Text(title.tr(),style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
      ],
    );
  }
}
