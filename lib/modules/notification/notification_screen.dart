import 'dart:math';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:daily_wash/layout/cubit/app_cubit.dart';
import 'package:daily_wash/models/notification_model.dart';
import 'package:daily_wash/models/order_model.dart';
import 'package:daily_wash/modules/settings/cubit/settings_cubit.dart';
import 'package:daily_wash/modules/settings/cubit/settings_states.dart';
import 'package:daily_wash/modules/widgets/item_shared/image_net.dart';
import 'package:daily_wash/modules/widgets/item_shared/list_is_empty.dart';
import 'package:daily_wash/shared/components/components.dart';
import 'package:daily_wash/shared/images/images.dart';
import 'package:daily_wash/shared/styles/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../home/order_screens/from_client_screen.dart';
import '../home/order_screens/from_shop_screen.dart';
import '../widgets/home/order_list_shimmer.dart';
import '../widgets/item_shared/default_appbar.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingsCubit.get(context).getNotification(context: context);
    return BlocConsumer<SettingsCubit, SettingsStates>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit = SettingsCubit.get(context);
    return RefreshIndicator(
      onRefresh: ()async{
        cubit.getNotification(context: context);
      },
      child: Column(
        children: [
          DefaultAppBar(
            isNotification: true,
            text: tr('notifications'),
            haveArrow: false,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Divider(),
          ),
          Expanded(
            child: ConditionalBuilder(
              condition: cubit.notificationModel!=null,
              fallback: (c)=>OrderListShimmer(),
              builder: (c)=> ConditionalBuilder(
                condition: cubit.notificationModel!.data!.data!.isNotEmpty,
                fallback: (c)=>ListIsEmpty('no_notifications_yet'),
                builder: (c)=> ListView.builder(
                    itemBuilder: (c,i)=>NotificationItem(i,cubit.notificationModel!.data!.data![i]),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  itemCount: cubit.notificationModel!.data!.data!.length,
                ),
              ),
            ),
          )
        ],
      ),
    );
  },
);
  }
}

class NotificationItem extends StatelessWidget {
   NotificationItem(this.index,this.data);

   int index;

   NotificationData data;
   String getOrderStatus(){
     if(data.orderId?.status == 1)return 'new'.tr();
     else if (data.orderId?.status == 2)return 'assigned_to_delivery'.tr();
     else if (data.orderId?.status == 3)return 'Received'.tr();
     else if (data.orderId?.status == 4)return 'delivered_to_laundry'.tr();
     else if (data.orderId?.status == 5)return 'Finished'.tr();
     else return '';
   }

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    Random.secure().nextInt(2);
    return InkWell(
      onTap: (){
        if(data.orderId?.status == 1){
          cubit.bookOrder(context: context, data:data.orderId??OrderData());
        }else if(data.orderId?.status == 2){
          cubit.getDirection(
              destinationLatlng: LatLng(double.parse(data.orderId?.userLatitude??''), double.parse(data.orderId?.userLatitude??''))
          );
          navigateTo(context, FromClientScreen(data.orderId??OrderData()));
        }else if(data.orderId?.status == 4){
          AppCubit.get(context).getDirection(
              destinationLatlng: LatLng(double.parse(data.orderId?.providerLatitude??''), double.parse(data.orderId?.providerLongitude??''))
          );
          navigateTo(context, FromShopScreenScreen(data.orderId??OrderData()));
        }
      },
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      child: Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: index % 2 == 0 ?Colors.grey.shade200:Colors.white
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //   children: [
            //     Container(
            //       height: 38,width: 38,
            //       decoration: BoxDecoration(shape: BoxShape.circle),
            //       clipBehavior: Clip.antiAliasWithSaveLayer,
            //       child: ImageNet(image: data.orderId?.userPhone??''),
            //     ),
            //     const SizedBox(width: 5,),
            //     Expanded(
            //       child: Text(
            //         data.orderId?.userName??'no_name'.tr(),
            //         style: TextStyle(
            //           fontWeight: FontWeight.w600,
            //             fontSize: 23,
            //             color: Colors.black
            //         ),
            //         maxLines: 1,
            //         overflow: TextOverflow.ellipsis,
            //       ),
            //     ),
            //     if(data.orderId?.paymentMethod == 'cash')
            //     if(data.orderId?.totalPrice!=null)
            //     Image.asset(Images.cash,width: 14,),
            //     const SizedBox(width: 5,),
            //     if(data.orderId?.paymentMethod == 'cash')
            //       if(data.orderId?.totalPrice!=null)
            //       Text(
            //       '${data.orderId?.totalPrice!}AED',
            //       style:const TextStyle(fontWeight: FontWeight.w600,fontSize: 12.5),
            //     ),
            //     const SizedBox(width: 15,),
            //     // Image.asset(Images.disc,width: 14,),
            //     // const SizedBox(width: 5,),
            //     // Text(
            //     //   '2.1 ${tr('km')}',
            //     //   style:const  TextStyle(fontWeight: FontWeight.w600,fontSize: 12.5),
            //     // ),
            //   ],
            // ),
            Text(
              data.title??'',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.black
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
            const SizedBox(height: 15,),
            Text(
              data.body??'',
            style: TextStyle(
                color: Colors.black
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
            const SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text.rich(
                      textAlign: TextAlign.start,
                      TextSpan(
                          text: '${tr('received_order_number')} ',
                          style: TextStyle(fontSize: 12.25,color: signTextColor,height: 1.2),
                          children: [
                            TextSpan(
                                text: '${data.orderId?.itemNumber??'1'}',
                                style: TextStyle(fontSize: 12.25,fontWeight: FontWeight.w800,color: defaultColor)
                            )
                          ]
                      )
                  ),
                ),
                const SizedBox(width: 30,),
                Text(
                  getOrderStatus(),
                  style:TextStyle(fontWeight: FontWeight.w600,fontSize: 12.5,color:defaultColor),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

