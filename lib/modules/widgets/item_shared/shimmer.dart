import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  CustomShimmer({
    required this.width,
    required this.height,
    this.radius = 15.0,
});

  double radius;
  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white60,
      child: Container(
        height: height,width: width,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadiusDirectional.circular(radius)
        ),
      ),
    );
  }
}
