import 'package:flutter/material.dart';

import '../../../shared/components/constants.dart';
import '../../../shared/styles/colors.dart';

class DefaultButton extends StatelessWidget {
  DefaultButton({
    required this.text,
    required this.onTap,
    this.width=double.infinity,
    this.height = 67,
    this.textSize = 19,
    this.radius = 15,
  });

  double? width;
  double radius;
  double height;
  double textSize;
  String text;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,width: width??size.width*.75,
        decoration: BoxDecoration(
            color: defaultColor,
            borderRadius: BorderRadiusDirectional.circular(radius)
        ),
        alignment: AlignmentDirectional.center,
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: textSize
          ),
        ),
      ),
    );
  }
}
