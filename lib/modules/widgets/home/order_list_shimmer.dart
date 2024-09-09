import 'package:flutter/material.dart';

import '../item_shared/shimmer.dart';

class OrderListShimmer extends StatelessWidget {
  const OrderListShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (c, i) => CustomShimmer(width: double.infinity, height: 142),
      separatorBuilder: (c, i) => const SizedBox(height: 30,),
      itemCount: 5,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
    );
  }
}
