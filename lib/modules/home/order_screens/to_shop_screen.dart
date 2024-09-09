import 'package:daily_wash/modules/widgets/home/order/order_appbar.dart';
import 'package:daily_wash/modules/widgets/item_shared/default_button.dart';
import 'package:daily_wash/modules/widgets/item_shared/image_net.dart';
import 'package:daily_wash/shared/components/constants.dart';
import 'package:daily_wash/shared/styles/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../layout/cubit/app_cubit.dart';
import '../../../layout/cubit/app_states.dart';
import '../../../models/order_model.dart';
import '../../../shared/components/components.dart';
import '../../../shared/images/images.dart';
import '../../widgets/home/order/contact_order.dart';
import '../../widgets/home/order/google_map.dart';
import '../../widgets/home/order/receipt_bottom_sheet.dart';
import '../../widgets/home/order/to_map.dart';

class ToShopScreenScreen extends StatelessWidget {
  ToShopScreenScreen(this.data);
  OrderData data;
  String providerLocation = 'Dubai Marina P. O. Box 32923, Dubai,UAE';
  @override
  Widget build(BuildContext context) {
     AppCubit.get(context).getAddress(
        LatLng(double.parse(data.providerLatitude??'25.019083'),double.parse(data.providerLongitude??'55.121239'))
    ).then((value) {
       providerLocation = value;
       AppCubit.get(context).emitState();
    });
    return BlocConsumer<AppCubit, AppStates>(
  listener: (context, state) {},
  builder: (context, state) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMapCustom(),
          Column(
            children: [
              //const SizedBox(height: 20,),
              //OrderAppbar(tr('to_shop'),data.id??'',status: 3,),
              const Spacer(),
              Expanded(flex: 3,
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(30),
                          topEnd: Radius.circular(30),
                        ),
                        color: Colors.white
                    ),
                    padding: EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ContactOrder(
                                image: Images.dial,
                                text: tr('dial_laundry'),
                                onTap: (){
                                  openUrl("tel://${data.providerPhone??''}");
                                }
                            ),
                            const SizedBox(width: 80,),
                            ContactOrder(
                                image: Images.whatsapp,
                                text: tr('whatsapp_laundry'),
                                onTap: (){
                                  AppCubit.get(context).whatAppContact(phone: data.providerPhone??'');
                                }
                            ),
                          ],
                        ),
                        const SizedBox(height:40),

                        ///name_laundry
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text(
                                    tr('name_laundry'),
                                    style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),
                                  ),
                                  if(data.providerName!=null)
                                    Text(
                                    data.providerName!.isNotEmpty?data.providerName!:'no_name'.tr(),
                                    style: TextStyle(fontWeight: FontWeight.w700,fontSize: 19),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 65,width: 65,
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: ImageNet(image: data.providerPersonalPhoto??'',),
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.cyan,
                        ),

                        ///location of laundry
                        Text(
                          tr('location'),
                          style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),
                        ),
                        Text(
                          providerLocation,
                          style: TextStyle(fontWeight: FontWeight.w700,fontSize: 19,height: 1.2),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.cyan,
                        ),

                        ///phone number of laundry shop
                        Text(
                          tr('phone'),
                          style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),
                        ),
                        const SizedBox(height:10 ,),
                        Text(
                          data.providerPhone??'',
                          style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.cyan,
                        ),

                        ///shipping_charges
                        Text(
                          tr('shipping_charges'),
                          style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),
                        ),
                        const SizedBox(height:10 ,),
                        Text(
                          data.shippingCharges.toString()??'',
                          style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.cyan,
                        ),

                        ///vat_value
                        Text(
                          tr('vat_value'),
                          style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),
                        ),
                        const SizedBox(height:10 ,),
                        Text(
                          data.vatValue.toString()??'',
                          style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.cyan,
                        ),

                        ///sub_total_price
                        Text(
                          tr('sub_total_price'),
                          style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),
                        ),
                        const SizedBox(height:10 ,),
                        Text(
                          data.subTotalPrice.toString()??'',
                          style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.cyan,
                        ),

                        ///total
                        Text(
                          tr('total'),
                          style: TextStyle(fontWeight: FontWeight.w800,fontSize: 16,color: Colors.red),
                        ),
                        const SizedBox(height:10 ,),
                        Text(
                          data.totalPrice.toString()??'',
                          style: TextStyle(fontWeight: FontWeight.w900,fontSize: 19,color: Colors.red),
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.cyan,
                        ),


                        Row(
                          children: [
                            Expanded(
                              child: DefaultButton(
                                  text: tr('delivered'),
                                  onTap: (){
                                    showModalBottomSheet(
                                        context: context,
                                        isDismissible: false,
                                      isScrollControlled: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(40.0),
                                      ),
                                        builder: (context)=>ReceiptBottomSheet(data.id??''),
                                    );
                                  }
                              ),
                            ),
                            const SizedBox(width: 20,),
                            ToMap(
                              origin: LatLng(AppCubit.get(context).position!.latitude,AppCubit.get(context).position!.longitude),
                              distance: LatLng(double.parse(data.providerLatitude??'25.019083'),double.parse(data.providerLongitude??'55.121239')),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  },
);
  }
}
