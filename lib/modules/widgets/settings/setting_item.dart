import 'package:daily_wash/shared/images/images.dart';
import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  SettingItem({
    required this.text,
    required this.image,
    required this.onTap,
});

  String text;
  String image;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Image.asset(image,width: 58,height: 58,),
            const SizedBox(width: 20,),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w500,fontSize: 23
              ),
            )
          ],
        ),
      ),
    );
  }
}
