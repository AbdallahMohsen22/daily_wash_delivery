import 'package:daily_wash/layout/cubit/app_cubit.dart';
import 'package:daily_wash/shared/images/images.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ToMap extends StatelessWidget {
  ToMap({
    this.origin,
    this.distance,
});

  LatLng? origin;
  LatLng? distance;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        AppCubit.get(context).openMap(
          context,
          origin: origin,distance: distance
        );
      },
        child: Image.asset(Images.map,width: 110,)
    );
  }
}
