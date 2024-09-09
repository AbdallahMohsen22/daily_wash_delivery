import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:daily_wash/modules/settings/cubit/settings_cubit.dart';
import 'package:daily_wash/modules/widgets/item_shared/image_net.dart';
import 'package:daily_wash/modules/widgets/item_shared/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/images/images.dart';
import '../../../../shared/styles/colors.dart';
import '../../../settings/cubit/settings_states.dart';
import 'choose_profile_image.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsStates>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    var cubit = SettingsCubit.get(context);
    return SizedBox(
      height: 170,
      width: 170,
      child: Stack(
        children: [
          Container(
            height: 157,width: 160,
            decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(40),
                color: defaultColor
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            padding: EdgeInsets.all(3),
            child: Container(
              height: 150,width: 155,
              decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(40),
                  color: Colors.white
              ),
              padding: EdgeInsets.all(5),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(40),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: ConditionalBuilder(
                      condition: cubit.deliveryModel!=null,
                      builder: (c)=>ImageNet(
                          image: cubit.deliveryModel!.data!.personalPhoto??''
                      ),
                      fallback: (c)=>CustomShimmer(width: 155, height: 155)
                  )
              ),
            ),
          ),
          InkWell(
            onTap: (){
              showModalBottomSheet(context: context, builder: (context)=>ChoosePhoto());
            },
            child: Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: Image.asset(Images.edit,width:43)),
          )
        ],
      ),
    );
  },
);
  }
}
