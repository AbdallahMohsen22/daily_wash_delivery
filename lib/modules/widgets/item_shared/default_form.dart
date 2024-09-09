import 'package:daily_wash/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

class DefaultForm extends StatelessWidget {
  DefaultForm({
    required this.controller,
    this.validator,
    required this.hint,
    this.autofocus=false,
    this.suffix,
    this.maxLines,
    this.type,
    this.readOnly = false
  });

  FormFieldValidator? validator;
  TextEditingController controller;
  bool autofocus;
  String hint;
  Widget? suffix;
  int? maxLines;
  TextInputType? type;
  bool readOnly;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: maxLines!=null?null:70,
      decoration: BoxDecoration(
          color: defaultGray,
          borderRadius: BorderRadiusDirectional.circular(10)
      ),
      alignment: AlignmentDirectional.centerStart,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        autofocus: autofocus,
        controller: controller,
        validator: validator,
        maxLines: maxLines,
        textInputAction: TextInputAction.done,
        keyboardType: type,
        readOnly: readOnly,
        inputFormatters: [
          if(type == TextInputType.phone)
          LengthLimitingTextInputFormatter(10),
          if(type == TextInputType.phone)
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            border: InputBorder.none,
          hintText: hint,

          hintStyle: TextStyle(color: HexColor('#969696'),fontWeight: FontWeight.w300),
          suffixIcon: suffix,
        ),
      ),
    );
  }
}
