import 'package:daily_wash/shared/images/images.dart';
import 'package:daily_wash/shared/styles/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Maintenance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Images.maintenance,width: double.infinity,height: 225,color:defaultColor),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: Column(
                children: [
                  Text(
                    tr('maintenance_title'),
                    style: TextStyle(
                        color: Colors.black87,fontWeight: FontWeight.w500,fontSize: 22
                    ),
                  ),
                  Text(
                    tr('maintenance_desc'),
                    style: TextStyle(
                        color: Colors.grey.shade600,fontWeight: FontWeight.w500,fontSize: 11
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
