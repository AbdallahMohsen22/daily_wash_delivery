import 'dart:async';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:daily_wash/layout/cubit/app_cubit.dart';
import 'package:daily_wash/layout/cubit/app_states.dart';
import 'package:daily_wash/models/order_model.dart';
import 'package:daily_wash/modules/widgets/item_shared/default_button.dart';
import 'package:daily_wash/modules/widgets/item_shared/image_net.dart';
import 'package:daily_wash/shared/components/components.dart';
import 'package:daily_wash/shared/images/images.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../shared/styles/colors.dart';
import '../../home/order_screens/from_client_screen.dart';
import '../../home/order_screens/from_shop_screen.dart';

class OrderWidget extends StatefulWidget {

  OrderWidget(this.data,this.state);

  OrderData data;

  AppStates state;


  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {

  bool isSelected = false;
  bool showButton = false;
  // late Timer timer;

  // @override
  // void dispose() {
  //   timer.;
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        setState(() {
          isSelected = !isSelected;
          if(isSelected){
              setState(() {
                if(isSelected){
                  showButton = true;
                }else{
                  showButton = false;
                }
              });
          }else{
            showButton = false;
          }
        });
      },
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        height: isSelected?300:241,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(25),
          color: isSelected?defaultGray:Colors.white,
          boxShadow: isSelected?[
            BoxShadow(
              blurRadius: 15,
              color: Colors.grey.shade300,

            )
          ]:null
        ),
        curve: Curves.fastOutSlowIn,
        padding: EdgeInsets.all(25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  height: 49,width: 49,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: ImageNet(image: widget.data.providerPersonalPhoto??''),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child:Text(
                    widget.data.providerName??'',
                    style: TextStyle(fontWeight:FontWeight.w600,fontSize: 20,color: Colors.red),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Text(
                  '#${widget.data.itemNumber??''}'
                ),
                const Gap(5),
                Image.asset(Images.arrowDown,width: 20,),
              ],
            ),
            const SizedBox(height: 20,),
            // if(widget.data.distance!=null)
            //   if(widget.data.distance!.isNotEmpty)
            Row(
              children: [
                Image.asset(Images.distanation,width: 17,),
                const SizedBox(width: 5,),
                Expanded(
                  child: Text(
                    widget.data.userAddress?[0].title??'',//widget.data.distance!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,fontSize: 16
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Icon(Icons.timelapse,size: 17,),
                const SizedBox(width: 5,),
                Expanded(
                  child: Text(
                    widget.data.createdAt??'',//widget.data.distance!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,fontSize: 16
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Icon(Icons.phone,size: 17,),
                const SizedBox(width: 5,),
                Expanded(
                  child: Text(
                    widget.data.providerPhone??'',//widget.data.distance!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,fontSize: 16
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Icon(Icons.person,size: 17,),
                const SizedBox(width: 5,),
                Expanded(
                  child: Text(
                    widget.data.providerName??'',//widget.data.distance!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,fontSize: 16
                    ),
                  ),
                ),
              ],
            ),
            if(showButton)
            const SizedBox(height: 0,),
            if(showButton)
            Expanded(flex: 1,
              child: ConditionalBuilder(
                condition: widget.state is! BookOrderLoadingState,
                fallback: (context)=>CupertinoActivityIndicator(),
                builder: (context)=> DefaultButton(
                    text:AppCubit.get(context).val == 'new_orders'? tr('accept_order'):tr('to_complete'),
                    onTap: (){
                      if(AppCubit.get(context).val != 'new_orders'){
                        AppCubit.get(context).getDirection(
                            destinationLatlng: LatLng(double.parse(widget.data.providerLatitude??''),
                                double.parse(widget.data.providerLongitude??''))
                        );
                      navigateTo(context, FromShopScreenScreen(widget.data));
                      }else{
                        AppCubit.get(context).bookOrder(context: context,data: widget.data);
                      }
                    }
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
