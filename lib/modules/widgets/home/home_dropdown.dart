import 'package:daily_wash/layout/cubit/app_cubit.dart';
import 'package:daily_wash/layout/cubit/app_states.dart';
import 'package:daily_wash/shared/styles/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomeDropDown extends StatefulWidget {
  HomeDropDown({Key? key}) : super(key: key);

  @override
  State<HomeDropDown> createState() => _HomeDropDownState();
}

class _HomeDropDownState extends State<HomeDropDown> {
  List<String> dropDownList = ['new_orders','suspended_orders'];


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: defaultColor,
        borderRadius: BorderRadiusDirectional.circular(10)
      ),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
      child: DropdownButton(
          items: dropDownList.map((e) => DropdownMenuItem(
              child: Text(
                tr(e),
                style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w500),
              ),
            value: e,
          )).toList(),
          value: AppCubit.get(context).val,
          dropdownColor: defaultColor,
          iconEnabledColor: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          underline: SizedBox(),
          focusColor: defaultColor,
          isDense: true,
          onChanged: (str){
            setState(() {
              AppCubit.get(context).val = str??'';
              if(AppCubit.get(context).val == 'new_orders'){
                AppCubit.get(context).getOrders(context: context);
              }else{
                AppCubit.get(context).getOrders(context: context);
              }
            });
          }
      ),
    );
  }
}
