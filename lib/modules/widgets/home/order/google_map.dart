import 'package:daily_wash/layout/cubit/app_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../layout/cubit/app_cubit.dart';
import '../../../../shared/styles/colors.dart';

class GoogleMapCustom extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return SizedBox(
          height: 500,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
                target: AppCubit.get(context).position!=null
                    ?LatLng(AppCubit.get(context).position!.latitude,
                    AppCubit.get(context).position!.longitude)
                    :LatLng(25.019083, 55.121239),
                zoom: 12
            ),
            myLocationButtonEnabled: false,
            zoomGesturesEnabled: false,
            zoomControlsEnabled: false,
            polylines: {
              if(cubit.directions != null)
                Polyline(
                    width: 5,
                    color: defaultColor,
                    polylineId: const PolylineId('polyLine'),
                    points: cubit.directions!.polylinePoints.map((e) =>
                        LatLng(e.latitude, e.longitude)).toList()
                ),
            },
            markers: {
              if(cubit.origin != null)cubit.origin!,
              if(cubit.distance != null)cubit.distance!,
            },
          ),
        );
      },
    );
  }
}
