import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:daily_wash/layout/app_layout.dart';
import 'package:daily_wash/layout/cubit/app_cubit.dart';
import 'package:daily_wash/modules/widgets/item_shared/default_button.dart';
import 'package:daily_wash/modules/widgets/item_shared/screenshot_widget.dart';
import 'package:daily_wash/shared/components/components.dart';
import 'package:daily_wash/shared/images/images.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screenshot/screenshot.dart';
import '../../../../layout/cubit/app_states.dart';
import '../../../../shared/styles/colors.dart';

class ReceiptBottomSheet extends StatefulWidget {
  ReceiptBottomSheet(this.id);

  String id;

  @override
  State<ReceiptBottomSheet> createState() => _ReceiptBottomSheetState();
}

class _ReceiptBottomSheetState extends State<ReceiptBottomSheet> {

  int? currentDayIndex;
  int finalCurrentDay = DateTime.now().day;

  int days = DateTime(DateTime.now().year,DateTime.now().month+1).toUtc().day;

  int? currentHourIndex;
  String? currentHourVal;

  List<String> hours= [
    '09:00 AM', '10:00 AM', '11:00 AM', '12:00 PM', '01:00 PM', '02:00 PM',
    '03:00 PM', '04:00 PM', '05:00 PM', '06:00 PM', '07:00 PM', '08:00 PM',
    '09:00 PM', '10:00 PM', '11:00 PM',
  ];


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
  listener: (context, state) {},
  builder: (context, state) {
    return Container(
      padding:const EdgeInsets.all(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40)
        ),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Text(
          //   tr('receipt_number'),
          //   style: TextStyle(fontWeight: FontWeight.w500),
          // ),
          // Text(
          //   '11655216',
          //   style:const TextStyle(fontWeight: FontWeight.w700,fontSize: 17),
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0,bottom: 15),
            child: Text(
              tr('you_must_specify'),
              textAlign: TextAlign.center,
              style:const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 60,
            child: ListView.separated(
                itemBuilder: (c,i)=>dayItem(i+1),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (c,i)=>const SizedBox(width: 15,),
                itemCount:days
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20,bottom: 30),
            child: SizedBox(
              height: 90,
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1/2
                  ),
                scrollDirection: Axis.horizontal,
                itemBuilder: (c,i)=>hoursBuilder(i,hours[i]),
                  itemCount:hours.length
              )
            ),
          ),
          ConditionalBuilder(
            condition: AppCubit.get(context).receiptImage!=null,
              builder: (c)=>Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Image.file(File(AppCubit.get(context).receiptImage!.path),width: 150,height: 140,),
                  IconButton(
                      onPressed: (){
                        AppCubit.get(context).receiptImage= null;
                        AppCubit.get(context).emitState();
                      },
                      icon:const Icon(Icons.delete,color: Colors.red,size: 25,))
                ],
              ),
              fallback:(c)=> InkWell(
                onTap:()=>AppCubit.get(context).pick(),
                child: ScreenShotWidget()
              )
          ),
          const SizedBox(height: 30,),
          ConditionalBuilder(
            condition: state is! ChangeOrderStatusLoadingState,
            fallback: (context)=>const CupertinoActivityIndicator(),
            builder: (context)=> DefaultButton(
                text: tr('done'),
                onTap: (){
                  if(currentDayIndex==null){
                    showToast(msg: tr('choose_day'),toastState: true);
                  }else if(currentHourIndex==null){
                    showToast(msg: tr('choose_hour'),toastState: true);
                  }else if(AppCubit.get(context).receiptImage==null){
                    showToast(msg: tr('please_take_photo'),toastState: true);
                  }else {
                    String date = '${DateFormat('yyyy-MM-dd').format(DateTime(DateTime.now().year,DateTime.now().month,currentDayIndex!))} $currentHourVal';
                    AppCubit.get(context).changeOrderStatus(
                        context,status: 4,orderId: widget.id,time: date
                    );
                  }
                    }
            ),
          )
        ],
      ),
    );
  },
);
  }

  Widget dayItem(int day){
    String dayName = DateFormat('EEE').format(DateTime(DateTime.now().year,DateTime.now().month,day));
    String monthName = DateFormat('MMM').format(DateTime(DateTime.now().year,DateTime.now().month));
    return InkWell(
      onTap:(){
        if(day >= finalCurrentDay){
          setState(() {
            if(currentDayIndex == day){
              currentDayIndex = null;
            }else{
              currentDayIndex = day;
            }
          });
        }
      },
      child: Container(
        height: 59,width: 45,
        decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(10),
            color:currentDayIndex == day?defaultColor:day < finalCurrentDay?Colors.grey.shade300:defaultColor.withOpacity(.3)
        ),
        alignment: AlignmentDirectional.center,
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              dayName,
              style: TextStyle(
                  fontSize: 10,
                  color:currentDayIndex == day?Colors.white:Colors.black,height: 1
              ),
            ),
            Text(
              '$day',
              style: TextStyle(
                  fontSize: 22,
                  color:currentDayIndex == day?Colors.white:defaultColor,height: 1
              ),
            ),
            Text(
              monthName,
              style: TextStyle(
                  fontSize: 10,
                  color:currentDayIndex == day?Colors.white:Colors.black,height: 1
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget hoursBuilder(int index,String hour){
    return InkWell(
      onTap: (){
        setState(() {
          if(currentHourIndex == index){
            currentHourIndex = null;
            currentHourVal = null;
          }else{
            currentHourIndex = index;
            currentHourVal = hour;
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(10),
            color:currentHourIndex == index?defaultColor:defaultColor.withOpacity(.3)
        ),
        //padding: EdgeInsets.symmetric(horizontal: 15),
         alignment: AlignmentDirectional.center,
        height: 35,width: 81,
        child: Text(
          hour,
          style: TextStyle(
              fontSize: 12,
              color:currentHourIndex == index?Colors.white:Colors.black
          ),
        ),
      ),
    );
  }
}
