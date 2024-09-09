import 'package:daily_wash/shared/components/components.dart';
import 'package:daily_wash/shared/images/images.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../models/order_model.dart';
import 'receipt_image_zoom.dart';

class Receipt{
  String title;
  dynamic value;
  Receipt({required this.title,required this.value});
}

class ReceiptWidget extends StatelessWidget {
  ReceiptWidget(this.data);
  OrderData data;

  List<Receipt> receipt = [];
  @override
  Widget build(BuildContext context) {
    receipt = [
      Receipt(title:'app_fee',value: data.appFees),
      Receipt(title:'sub_total_price',value: data.subTotalPrice),
      Receipt(title:'shipping_charges',value: data.shippingCharges),
    ];
    return InkWell(
      onTap: (){
        navigateTo(context, ReceiptImageZoom(data,receipt));
      },
      child: Center(
        child: SizedBox(
          height: 270,width: 200,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Image.asset(Images.receipt,height: 270,width: 200,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15),
                child: Column(
                  children: [
                    Text(
                      data.providerName!.isNotEmpty?data.providerName!:'no_name'.tr(),
                      style: TextStyle(
                        color: Colors.black,fontWeight: FontWeight.w600
                      ),
                    ),
                    const Gap(30),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 15.0,bottom: 5),
                    //   child: Text(
                    //     'Cash receipt',
                    //     style: TextStyle(
                    //       color: Colors.black,fontSize: 11
                    //     ),
                    //   ),
                    // ),
                    // Text(
                    //   '3256222',
                    //   style: TextStyle(
                    //     color: Colors.black,fontWeight: FontWeight.w600,fontSize: 11
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Image.asset(Images.line,width: 140,),
                    ),
                    Row(
                      children: [
                        Text(
                          'description'.tr(),
                          style: TextStyle(
                              color: Colors.black,fontWeight: FontWeight.w600,fontSize: 10
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'price'.tr(),
                          style: TextStyle(
                              color: Colors.black,fontWeight: FontWeight.w600,fontSize: 11
                          ),
                        ),
                      ],
                    ),
                    ListView.separated(
                        itemBuilder:(c,i)=>itemBuilder(receipt: receipt[i]),
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (c,i)=>const SizedBox(height: 10,),
                        itemCount: receipt.length
                    ),
                    Row(
                      children: [
                        Text(
                          'total'.tr(),
                          style: TextStyle(
                              color: Colors.black,fontWeight: FontWeight.w600,fontSize: 10
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${data.totalPrice} AED',
                          style: TextStyle(
                              color: Colors.black,fontWeight: FontWeight.w600,fontSize: 11
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Image.asset(Images.line,width: 140,),
                    ),
                    Row(
                      children: [
                        Text(
                          'payment_method'.tr(),
                          style: TextStyle(
                              color: Colors.black,fontWeight: FontWeight.w600,fontSize: 10
                          ),
                        ),
                        const Spacer(),
                        Text(
                          data.paymentMethod == 'online'?'Online':'cash'.tr(),
                          style: TextStyle(
                              color: Colors.black,fontWeight: FontWeight.w600,fontSize: 11
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget itemBuilder({
  required Receipt receipt,
}){
    return Row(
      children: [
        Expanded(
          child: Text(
            receipt.title.tr(),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
                color: Colors.black,fontWeight: FontWeight.w300,fontSize: 9
            ),
          ),
        ),
        const Gap(10),
        Text(
          '${receipt.value} AED',
          style: TextStyle(
              color: Colors.black,fontWeight: FontWeight.w300,fontSize: 9
          ),
        ),
      ],
    );
  }
}
