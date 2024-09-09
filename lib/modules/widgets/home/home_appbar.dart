import 'package:daily_wash/layout/cubit/app_cubit.dart';
import 'package:daily_wash/modules/settings/cubit/settings_cubit.dart';
import 'package:daily_wash/modules/widgets/item_shared/image_net.dart';
import 'package:daily_wash/shared/images/images.dart';
import 'package:daily_wash/shared/styles/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Image.asset(Images.appbar),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              children: [
                Container(
                  height: 62,width: 63,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(10),
                    color: defaultColor
                  ),
                  padding: EdgeInsets.all(2),
                  child: Container(
                    height: 55,width: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(10),
                        color: Colors.white
                    ),
                   // padding: EdgeInsets.all(2),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: ImageNet(
                      image:SettingsCubit.get(context).deliveryModel!.data!.personalPhoto??'',
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr('welcome'),
                        style: TextStyle(color: Colors.grey.shade400,fontSize: 11),
                      ),
                      Text(
                        SettingsCubit.get(context).deliveryModel!.data!.name??'',
                        style: TextStyle(fontWeight:FontWeight.w500,fontSize: 23,color: Colors.black),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    AppCubit.get(context).changeIndex(0);
                  }, child: Image.asset(Images.notification,width: 30,)
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
