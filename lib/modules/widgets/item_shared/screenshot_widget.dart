import 'package:daily_wash/shared/images/images.dart';
import 'package:daily_wash/shared/styles/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ScreenShotWidget extends StatelessWidget {
  const ScreenShotWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 142,width: 156,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(16),
        border: Border.all(color: defaultColor),
      ),
      padding: EdgeInsets.symmetric(vertical: 15,horizontal: 25),
      child: Column(
        children: [
          Text(
            'take_photo'.tr(),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const Gap(7),
          Image.asset(Images.mobile,width: 40,height: 63,)
        ],
      ),
    );
  }
}
