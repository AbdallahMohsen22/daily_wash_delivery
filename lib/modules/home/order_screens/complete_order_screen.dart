import 'package:daily_wash/layout/app_layout.dart';
import 'package:daily_wash/modules/widgets/item_shared/default_button.dart';
import 'package:daily_wash/shared/components/components.dart';
import 'package:daily_wash/shared/images/images.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../shared/styles/colors.dart';

class CompleteOrderScreen extends StatelessWidget {
  CompleteOrderScreen({Key? key,required this.itemNumber}) : super(key: key);

  String itemNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Images.completeOrder,height: 240,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                        text: '${tr('successful_delivery')}\n',
                        style: TextStyle(fontSize: 35.5,fontWeight: FontWeight.w600,color: signTextColor,height: 1.2),
                        children: [
                          TextSpan(
                              text: tr('completed'),
                              style: TextStyle(fontSize: 35.5,fontWeight: FontWeight.w800,color: defaultColor)
                          )
                        ]
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  '${tr('congrats_order_completed')} ${itemNumber}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 30,),
              DefaultButton(
                  text: tr('go_home'),
                  onTap: ()=>navigateAndFinish(context, AppLayout())
              )
            ],
          ),
        ),
      ),
    );
  }
}
