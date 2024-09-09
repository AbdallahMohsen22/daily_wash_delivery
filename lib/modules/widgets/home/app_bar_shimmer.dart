import 'package:daily_wash/modules/widgets/item_shared/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../shared/images/images.dart';

class AppBarShimmer extends StatelessWidget {
  const AppBarShimmer({Key? key}) : super(key: key);

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
                CustomShimmer(height: 62,width: 63,radius: 10,),
                const SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomShimmer(height: 10,width: 63,radius: 5,),
                    const Gap(15),
                    CustomShimmer(height: 20,width: 120,radius: 5,),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
