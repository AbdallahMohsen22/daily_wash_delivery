import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:daily_wash/layout/cubit/app_cubit.dart';
import 'package:daily_wash/layout/cubit/app_states.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';

class OrderAppbar extends StatelessWidget {
  OrderAppbar(this.text,this.id,{this.status = 1});
  String text;
  String id;
  int status;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ConditionalBuilder(
              condition: state is! ChangeOrderStatusLoadingState,
              fallback: (c)=>CupertinoActivityIndicator(),
              builder: (c)=> InkWell(
                onTap: (){
                  if(status == 1){
                    showDialog(
                      context: context,
                      builder: (context) {
                        return BlocConsumer<AppCubit, AppStates>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            return AlertDialog(
                              title: Text(
                                'cancel_order'.tr(),
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              actionsAlignment: MainAxisAlignment.center,
                              buttonPadding: EdgeInsets.symmetric(horizontal: 40),
                              actions: <Widget>[
                                ConditionalBuilder(
                                  condition: state is! ChangeOrderStatusSuccessState,
                                  fallback: (context)=>CupertinoActivityIndicator(),
                                  builder: (context)=> TextButton(
                                   // isDestructiveAction: true,
                                    onPressed: (){
                                      AppCubit.get(context).changeOrderStatus(context, orderId: id, status: status);
                                    },
                                    child: Text(
                                      "yes".tr(),
                                      style: TextStyle(
                                        color: Colors.red
                                      ),
                                    ),
                                  ),
                                ),
                               // const Gap(30),
                                TextButton(
                                  child: Text(
                                    "cancel".tr(),
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  onPressed: () {
                                    if(state is! ChangeOrderStatusLoadingState){
                                      Navigator.pop(context);
                                    }
                                  },
                                )
                              ],
                            );
                          },
                        );
                      }
                    );
                  }
                  else if (status == 3){
                    AppCubit.get(context).changeOrderStatus(context, orderId: id, status: 2);
                  }else if(status == 4){
                    AppCubit.get(context).changeOrderStatus(context, orderId: id, status: 4,fromShop: true);
                  }else{
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  height: 50,width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(8),
                    color: Colors.grey.shade400
                  ),
                  alignment: AlignmentDirectional.center,
                  child: Icon(status == 1?Icons.cancel_outlined:Icons.arrow_back_ios,color: Colors.white,),
                ),
              ),
            ),
          );
  },
),
          Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadiusDirectional.circular(15)
              ),
              width: size.width*.75,
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),
                  ),
                  const SizedBox(width: 15,),
                  Icon(Icons.arrow_downward,size: 25,color: defaultColor,)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
