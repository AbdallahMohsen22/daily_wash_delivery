import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:daily_wash/modules/home/order_screens/to_client_screen.dart';
import 'package:daily_wash/modules/home/order_screens/to_shop_screen.dart';
import 'package:daily_wash/modules/widgets/home/order/order_appbar.dart';
import 'package:daily_wash/modules/widgets/home/order/receipt_image_zoom.dart';
import 'package:daily_wash/modules/widgets/item_shared/default_button.dart';
import 'package:daily_wash/modules/widgets/item_shared/image_net.dart';
import 'package:daily_wash/shared/components/components.dart';
import 'package:daily_wash/shared/styles/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../layout/cubit/app_cubit.dart';
import '../../../layout/cubit/app_states.dart';
import '../../../models/order_model.dart';
import '../../../shared/images/images.dart';
import '../../widgets/home/order/contact_order.dart';
import '../../widgets/home/order/google_map.dart';

import '../../widgets/home/order/to_map.dart';
import '../../widgets/image_zoom.dart';

class FromShopScreenScreen extends StatefulWidget {
  FromShopScreenScreen(this.data);
  OrderData data;
  @override
  State<FromShopScreenScreen> createState() => _FromShopScreenScreenState();
}

class _FromShopScreenScreenState extends State<FromShopScreenScreen> {
  ScrollController controller = ScrollController();
  bool closeReceipt = false;

  String providerLocation = 'Dubai Marina P. O. Box 32923, Dubai,UAE';


  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        print(controller.offset);
        closeReceipt = controller.offset>5;

      });
    });
    AppCubit.get(context).getAddress(
        LatLng(double.parse(widget.data.providerLatitude??'25.019083'),double.parse(widget.data.providerLongitude??'55.121239'))
    ).then((value) {
      providerLocation = value;
      AppCubit.get(context).emitState();
    });
    super.initState();
  }
  @override
  void dispose() {
    controller.removeListener(() {
      controller.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit = AppCubit.get(context);
    return Scaffold(
      body: Stack(
        children: [
          GoogleMapCustom(),
          Column(
            children: [
              //const SizedBox(height: 20,),
              //OrderAppbar(tr('from_shop'),widget.data.id??'',status: 4,),
              AnimatedContainer(
                duration: Duration(milliseconds: 1000),
                  curve: Curves.easeInBack,
                //height: closeReceipt?size.height*.27:100,
                height: 27,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(30),
                        topEnd: Radius.circular(30),
                      ),
                      color: Colors.white
                  ),
                  padding: EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    controller: controller,
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ContactOrder(
                                image: Images.dial,
                                text: tr('dial_laundry'),
                                onTap: (){
                                  openUrl("tel://${widget.data.providerPhone??''}");

                                }
                            ),
                            const SizedBox(width: 80,),
                            ContactOrder(
                                image: Images.whatsapp,
                                text: tr('whatsapp_laundry'),
                                onTap: (){
                                  AppCubit.get(context).whatAppContact(phone: widget.data.providerPhone??'');
                                }
                            ),
                          ],
                        ),
                        if(closeReceipt)
                        Center(
                          child: TextButton(
                              onPressed: (){
                                setState(() {
                                  closeReceipt = false;
                                });
                              },
                              child: Text(
                                'show_receipt'.tr(),
                                style: TextStyle(
                                  color: Colors.black
                                ),
                              )
                          ),
                        ),
                        AnimatedOpacity(
                            duration: const Duration(milliseconds: 1000),
                            opacity: closeReceipt?0:1,
                          curve: Curves.easeInBack,
                          child:  Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15.0),
                              child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 1000),
                                  height: closeReceipt?0:270,
                                  width: closeReceipt?0:200,
                                  curve: Curves.easeInBack,
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                      child: InkWell(
                                        onTap:()=> navigateTo(context,ImageZoom(widget.data.orderedReceivingReceipt??'')),
                                          child: ImageNet(image: widget.data.orderedReceivingReceipt??'',
                                            height: closeReceipt?0:270,
                                            width: closeReceipt?0:200,
                                          )))
                              ),
                            ),
                        ),
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
                                  Text(
                                    widget.data.providerName!.isNotEmpty?widget.data.providerName!:'no_name'.tr(),
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
                              child: Image.asset(Images.laundry,fit: BoxFit.cover,),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'delivering_date'.tr(),
                                    style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),
                                  ),
                                  Text(
                                    widget.data.orderedDate??'',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      color: defaultColor
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'receiving_date'.tr(),
                                    style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),
                                  ),
                                  Text(
                                    widget.data.orderedReceivingDate??'',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      color: defaultColor
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
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

                        const SizedBox(height:15 ,),
                        Text(
                          tr('phone'),
                          style: TextStyle(fontWeight: FontWeight.w400,fontSize: 10),
                        ),
                        const SizedBox(height:10 ,),
                        Text(
                          widget.data.providerPhone??'',
                          style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),
                        ),
                        const SizedBox(height:30 ,),
                        Row(
                          children: [
                            Expanded(
                              child: ConditionalBuilder(
                                condition: state is! ChangeOrderStatusLoadingState,
                                fallback: (context)=>const CupertinoActivityIndicator(),
                                builder: (context)=> DefaultButton(
                                    text: tr('received'),
                                    onTap: (){
                                      cubit.changeOrderStatus(
                                          context, data: widget.data,
                                          status: 3,
                                          fromShop: true,
                                         orderId: widget.data.id??""
                                      );
                                    }
                                ),
                              ),
                            ),
                            const SizedBox(width: 20,),
                            ToMap(
                              origin: LatLng(AppCubit.get(context).position!.latitude,AppCubit.get(context).position!.longitude),
                              distance: LatLng(double.parse(widget.data.providerLatitude??'25.019083'),double.parse(widget.data.providerLongitude??'55.121239')),
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
