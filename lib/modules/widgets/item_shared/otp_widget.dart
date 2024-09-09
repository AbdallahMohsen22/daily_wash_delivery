import 'package:daily_wash/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../shared/components/constants.dart';

class OTPWidget extends StatelessWidget {
  OTPWidget({
    required this.controller,
    this.onFinished,
    this.autoFocus = false
});

  bool autoFocus;
  VoidCallback? onFinished;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 76,width: 76,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            height: 76,width: 76,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(10),
              color: defaultGray
            ),
            alignment: AlignmentDirectional.center,
          ),
          TextFormField(
            textAlign: TextAlign.center,
            controller: controller,
            autofocus: autoFocus,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (value) {
              if(value.isNotEmpty){
                myLocale =='ar'
                    ? FocusManager.instance.primaryFocus!.previousFocus()
                    :FocusManager.instance.primaryFocus!.nextFocus();
                if(onFinished!=null)onFinished!();
              }else{
                myLocale =='ar'
                    ? FocusManager.instance.primaryFocus!.nextFocus()
                    :FocusManager.instance.primaryFocus!.previousFocus();
              }
            },
          )
        ],
      ),
    );
  }
}
