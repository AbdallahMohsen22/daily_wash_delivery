import 'package:daily_wash/modules/widgets/item_shared/default_button.dart';
import 'package:daily_wash/shared/images/images.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../shared/styles/colors.dart';

class FalsePhoneDialog extends StatelessWidget {
  FalsePhoneDialog({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(30),
          color: Colors.white
        ),
        padding: EdgeInsets.symmetric(vertical: 40,horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Images.falsePhone,height: 116,width: 116,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                      text: '${tr('false')}  ',
                      style: TextStyle(fontSize: 25.5,fontWeight: FontWeight.w600,color: signTextColor,height: 1.2),
                      children: [
                        TextSpan(
                            text: tr('phone'),
                            style: TextStyle(fontSize: 25.5,fontWeight: FontWeight.w800,color: defaultColor)
                        )
                      ]
                  )
              ),
            ),
            Text(
              tr('false_phone_note'),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30,left: 30,top: 20,bottom: 30),
              child: Row(
                children: [
                  itemBuilder(
                    text: tr('dial_us'),
                    image: Images.dial,
                    onTap: (){}
                  ),
                  const Spacer(),
                  itemBuilder(
                    image: Images.whatsapp,
                    text: tr('whatsapp_us'),
                    onTap: (){}
                  )
                ],
              ),
            ),
            DefaultButton(
                text: tr('try_again'),
                onTap: ()=>Navigator.pop(context)
            )
          ],
        ),
      ),
    );
  }

  Widget itemBuilder({
  required String image,
  required String text,
  required VoidCallback onTap,
}){
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
            child: Image.asset(image,width: 32,height: 32,),
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
