import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:daily_wash/layout/cubit/app_cubit.dart';
import 'package:daily_wash/modules/home/order_screens/to_shop_screen.dart';
import 'package:daily_wash/modules/widgets/home/order/order_appbar.dart';
import 'package:daily_wash/modules/widgets/item_shared/default_button.dart';
import 'package:daily_wash/shared/components/components.dart';
import 'package:daily_wash/shared/components/constants.dart';
import 'package:daily_wash/shared/styles/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../layout/cubit/app_states.dart';
import '../../../models/order_model.dart';
import '../../../shared/images/images.dart';
import '../../widgets/home/order/contact_order.dart';
import '../../widgets/home/order/google_map.dart';
import '../../widgets/home/order/to_map.dart';
import '../../widgets/item_shared/image_net.dart';

class FromClientScreen extends StatelessWidget {
  FromClientScreen(this.data);
  OrderData data;

  @override
  Widget build(BuildContext context) {
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
              //OrderAppbar(tr('receive_from_client'),data.id??"",status: 1),
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
                        ConditionalBuilder(
                          condition: data.userPhone!=null,
                          fallback: (c)=>Text(
                            'no_contact_info',
                            style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),
                            overflow: TextOverflow.ellipsis,
                          ),
                          builder: (c)=> Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ContactOrder(
                                  image: Images.dial,
                                  text: tr('dial_client'),
                                  onTap: (){
                                    openUrl("tel://${data.userPhone??''}");
                                  }
                              ),
                              const SizedBox(width: 80,),
                              ContactOrder(
                                  image: Images.whatsapp,
                                  text: tr('whatsapp_client'),
                                  onTap: (){
                                    AppCubit.get(context).whatAppContact(phone: data.userPhone??'');
                                  }
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height:40),
                        ///name of client
                        Divider(
                          thickness: 2,
                          color: Colors.cyan,
                        ),
                        Text(
                          tr('name_client'),
                          style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),
                        ),
                        if(data.userName!=null)
                        Text(
                          data.userName!.isNotEmpty?data.userName!:'no_name'.tr(),
                          style: TextStyle(fontWeight: FontWeight.w700,fontSize: 28),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),

                        ///location of client
                        Divider(
                          thickness: 2,
                          color: Colors.cyan,
                        ),
                        Text(
                          tr('location'),
                          style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),
                        ),
                        Text(
                          data.userAddress?[0].title??'',
                          style: TextStyle(fontWeight: FontWeight.w700,fontSize: 19,height: 1.2),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),

                        ///user phone of client
                        Divider(
                          thickness: 2,
                          color: Colors.cyan,
                        ),
                        Text(
                          tr('user_phone'),
                          style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),
                        ),
                        Text(
                          data.userPhone??'',
                          style: TextStyle(fontWeight: FontWeight.w700,fontSize: 19,height: 1.2),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),

                        ///order receiving date
                        Divider(
                          thickness: 2,
                          color: Colors.cyan,
                        ),
                        Text(
                          tr('order_receiving_date'),
                          style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),
                        ),
                        Text(
                          data.orderedReceivingDate??'',
                          style: TextStyle(fontWeight: FontWeight.w700,fontSize: 19,height: 1.2),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),

                        ///createdAt
                        Divider(
                          thickness: 2,
                          color: Colors.cyan,
                        ),
                        Text(
                          tr('createdAt'),
                          style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),
                        ),
                        Text(
                          data.createdAt??'',
                          style: TextStyle(fontWeight: FontWeight.w700,fontSize: 19,height: 1.2),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),

                        // ///ordered_receiving_receipt
                        // Divider(
                        //   thickness: 2,
                        //   color: Colors.cyan,
                        // ),
                        // Text(
                        //   tr('ordered_receiving_receipt'),
                        //   style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),
                        // ),
                        // Container(
                        //   height: 200,width: 300,
                        //   decoration: BoxDecoration(shape: BoxShape.rectangle),
                        //   clipBehavior: Clip.antiAliasWithSaveLayer,
                        //   child: ImageNet(image: data.orderedReceivingReceipt??'',),
                        // ),



                        const SizedBox(height:30),
                        Text(
                          tr('payment_method'),
                          style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10,bottom: 30),
                          child: Container(
                            decoration: BoxDecoration(
                              color: defaultGray,
                              borderRadius: BorderRadiusDirectional.circular(10)
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 20),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    if(data.paymentMethod == 'online')
                                    Image.asset(Images.visa,width: 70,),
                                    if(data.paymentMethod != 'online')
                                      Text(
                                        'cash'.tr(),
                                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                                      ),
                                    const Spacer(),
                                    CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Colors.grey.shade400,
                                      child: CircleAvatar(
                                        radius: 6,
                                        backgroundColor: defaultColor,
                                      ),
                                    ),
                                  ],
                                ),
                                const Gap(10),
                                if(data.paymentMethod !='online')
                                Text(
                                  tr('The_amount_required'),
                                  style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),
                                ),
                                if(data.paymentMethod !='online')
                                  Text(
                                    '${data.totalPrice} AED',
                                    style: TextStyle(fontWeight: FontWeight.w700,fontSize: 28),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),

                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ConditionalBuilder(
                                condition: state is! ChangeOrderStatusLoadingState,
                                fallback: (context)=>const CupertinoActivityIndicator(),
                                builder: (context)=> DefaultButton(
                                    text: tr('received'),
                                    onTap: (){
                                      AppCubit.get(context).changeOrderStatus(context, data: data,status: 3,orderId: data.id??'');
                                    }
                                ),
                              ),
                            ),
                            const SizedBox(width: 20,),
                            ToMap(
                              origin: LatLng(AppCubit.get(context).position!.latitude,AppCubit.get(context).position!.longitude),
                              distance: LatLng(double.parse(data.userLatitude??'25.019083'),double.parse(data.userLongitude??'55.121239')),
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
