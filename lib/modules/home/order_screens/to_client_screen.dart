import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:daily_wash/layout/cubit/app_states.dart';
import 'package:daily_wash/modules/home/order_screens/to_shop_screen.dart';
import 'package:daily_wash/modules/widgets/home/order/order_appbar.dart';
import 'package:daily_wash/modules/widgets/item_shared/default_button.dart';
import 'package:daily_wash/shared/components/components.dart';
import 'package:daily_wash/shared/components/constants.dart';
import 'package:daily_wash/shared/styles/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../layout/cubit/app_cubit.dart';
import '../../../models/order_model.dart';
import '../../../shared/images/images.dart';
import '../../widgets/home/order/contact_order.dart';
import '../../widgets/home/order/google_map.dart';
import '../../widgets/home/order/to_map.dart';
import 'complete_order_screen.dart';

class ToClientScreen extends StatelessWidget {
  ToClientScreen(this.data);
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
              //OrderAppbar(tr('to_client'),data.id??'',status: 4),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(30),
                      topEnd: Radius.circular(30),
                    ),
                    color: Colors.white
                ),
                padding: EdgeInsets.all(30),
                child: Expanded(flex: 3,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
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
                        const SizedBox(height:40),
                        Text(
                          '#${tr('order_number')}',
                          style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),
                        ),
                        Text(
                          '${data.itemNumber??'0'}',
                          style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(height:15 ,),
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
                        const SizedBox(height:15 ,),
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
                        const SizedBox(height: 30,),
                        Row(
                          children: [
                            Expanded(
                              child: ConditionalBuilder(
                                condition: state is! ChangeOrderStatusLoadingState,
                                fallback: (context)=>const CupertinoActivityIndicator(),
                                builder: (context)=> DefaultButton(
                                    text: tr('delivered'),
                                    onTap: (){
                                      AppCubit.get(context).changeOrderStatus(context,orderId:data.id??'',status: 5,data: data);
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
