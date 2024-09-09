import 'package:flutter/material.dart';

import '../../../../shared/styles/colors.dart';

class ContactOrder extends StatelessWidget {
  ContactOrder({
    required this.text,
    required this.onTap,
    required this.image,
});
  VoidCallback onTap;
  String image;
  String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 65,width: 65,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: defaultGray
            ),
            alignment: AlignmentDirectional.center,
            child: Image.asset(image,width: 32,height: 32,color: Colors.grey,),
          ),
          const SizedBox(height: 5,),
          Text(
            text,
            style:const TextStyle(fontSize: 11.5),
          )
        ],
      ),
    );
  }
}
