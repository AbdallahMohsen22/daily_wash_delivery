import 'dart:convert';
import 'dart:io';

import 'package:daily_wash/layout/cubit/app_states.dart';
import 'package:daily_wash/shared/images/images.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/directions_model.dart';
import '../../models/order_model.dart';
import '../../modules/home/home_screen.dart';
import '../../modules/home/order_screens/complete_order_screen.dart';
import '../../modules/home/order_screens/from_client_screen.dart';
import '../../modules/home/order_screens/from_shop_screen.dart';
import '../../modules/home/order_screens/to_client_screen.dart';
import '../../modules/home/order_screens/to_shop_screen.dart';
import '../../modules/notification/notification_screen.dart';
import '../../modules/settings/settings_screen.dart';
import '../../modules/widgets/item_shared/account_is_locked.dart';
import '../../modules/widgets/item_shared/ui.dart';
import '../../modules/wrong_screens/update.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/location_helper/directions.dart';
import '../../shared/network/remote/dio.dart';
import '../../shared/network/remote/end_point.dart';
import '../app_layout.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit(): super(AppInitState());

  static AppCubit get(context)=>BlocProvider.of(context);

  int currentIndex = 1;

  bool isNewOrder = true;

  Directions? directions;

  String val = 'new_orders';


  Marker? origin;
  Marker? distance;
  Position? position;
  OrderModel? orderModel;
  OrderModel2? orderModel2;


  List<Widget> screens = [
    NotificationScreen(),
    HomeScreen(),
    SettingsScreen()
  ];

  void changeIndex(int index){
    currentIndex = index;
    emit(ChangeIndexState());
  }

  ImagePicker picker = ImagePicker();
  XFile? receiptImage;

  void emitState()=>emit(EmitState());

  void init(BuildContext context){
    checkInterNet();
    getCurrentLocation(context);
    updateApp(context);
  }

  void updateApp(context) async{
    final newVersion =await NewVersionPlus().getVersionStatus();
    if(await checkUpdates()){
      if(newVersion !=null){
        if(newVersion.appStoreLink.isNotEmpty)navigateAndFinish(context, Update(
            url:newVersion.appStoreLink,
            releaseNote:newVersion.releaseNotes??tr('update_desc')
        ));
      }
    }
  }

  Future<bool> checkUpdates() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    remoteConfig.ensureInitialized();
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: Duration.zero,
    ));
    await remoteConfig.fetchAndActivate();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    bool haveVersion = false;
    final json = remoteConfig.getString('app_version');
    Map<String,dynamic> jsonDecod =  jsonDecode(json);
    final version = jsonDecod['version'];
    final local = packageInfo.version.split('.').map(int.parse).toList();
    final store = version.split('.').map(int.parse).toList();
    for (var i = 0; i < store.length; i++) {
      if (store[i] > local[i])haveVersion = true;
      if (local[i] > store[i]) haveVersion = false;
    }
    return haveVersion;
  }

  void checkInterNet() async {
    InternetConnectionChecker().onStatusChange.listen((event) {
      final state = event == InternetConnectionStatus.connected;
      isConnect = state;
      emit(EmitState());
    });
  }

  void whatAppContact({String phone = '01223364710'}) {
    String url;
    if (Platform.isAndroid) {
      // add the [https]
      url =  "https://wa.me/${phone}/?text=${Uri.parse('Hello')}"; // new line
    } else {
      // add the [https]
      url = "https://wa.me/$phone?text=${Uri.parse('Hello')}"; // new line
    }
    print(url);
    launchUrl(Uri.parse(url));
  }


  void pick() async {
    try {
      receiptImage =  await picker.pickImage(source: ImageSource.camera, imageQuality: 20);
      emit(ImagePicked());
    } catch (e) {
      print(e.toString());
      emit(ImageWrong());
    }
  }

  void getDirection({
  LatLng? destinationLatlng,
})async{
    await  DirectionsRepository()
        .getDirections(
        origin: position!=null?LatLng(position!.latitude, position!.longitude):LatLng(25.1995140, 55.2773970),
        destination: destinationLatlng??LatLng(24.3386270, 54.7674470),
        mode: 'driving'
    ).then((value) {
      print(value);
      print(value!.polylinePoints[0]);
      directions = value;
      late BitmapDescriptor originIcon;
      late BitmapDescriptor distanceIcon;
      BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(12, 12)),
          Images.mapMarker)
          .then((d) {
        originIcon = d;
      });
      BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(12, 12)),
          Images.mapMarker2)
          .then((d) {
        distanceIcon = d;
      });
      origin = Marker(
          position:position!=null?LatLng(position!.latitude, position!.longitude): LatLng(25.1995140, 55.2773970),
          markerId: MarkerId('origin'),
          icon: originIcon
      );
      distance = Marker(
          position: destinationLatlng??LatLng(24.3386270, 54.7674470),
          markerId: MarkerId('destination'),
          icon: distanceIcon
      );
      emit(GetCurrentLocationState());
    }).catchError((e){
      print(e.toString());
     // showToast(msg: e.toString(),toastState: false);
    });
  }

  Future<Position> checkPermissions(BuildContext context) async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();
    if (!isServiceEnabled) {}
    if (permission == LocationPermission.denied) {
      print('permission = denied with request');
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        print('permission = denied');
        UIAlert.showCustomDailog(
            context,
            title: 'location_permission'.tr(),
            getLocation: true,
            onPressed: ()=>openAppSettings(),
            textButton: 'settings'.tr(),
            barrierDismissible: false
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('permission = deniedForever');
      UIAlert.showCustomDailog(
          context,
          title: 'location_permission'.tr(),
          onPressed: ()=>openAppSettings(),
          getLocation: true,
          textButton: 'settings'.tr(),
          barrierDismissible: false
      );
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<String> getAddress(LatLng latLng) async {
    String location;
    List<Placemark> place = await placemarkFromCoordinates(
        latLng.latitude, latLng.longitude,
        localeIdentifier: myLocale);
    Placemark placeMark = place[0];
    location = placeMark.street??'';
    location += ', ${placeMark.country??''}';
    return location;
  }

  Future<void> getCurrentLocation(BuildContext context) async {
    emit(LocationLoadingState());
    await checkPermissions(context);
    await Geolocator.getLastKnownPosition().then((value) {
      if (value != null) {
        position = value;
        getOrders(context: context);
        updateDeliveryLocation();
        emit(LocationSuccessState());
      }
    });
  }

  void openMap(BuildContext context,{
    LatLng? origin,
    LatLng? distance,
}) async {
    await AppCubit.get(context).getCurrentLocation(context);
    if(AppCubit.get(context).position!=null){

      final availableMaps = await MapLauncher.installedMaps;
      if(availableMaps.any((element) => element.mapName.contains('Google'))){
        availableMaps.forEach((element) {
          if(element.mapName.contains('Google')){
            availableMaps[availableMaps.indexOf(element)].showDirections(
              origin: Coords(origin!.latitude,origin.longitude),
              destination: Coords(distance!.latitude,distance.longitude),

            );
          }
        });
      }else if(availableMaps.any((element) => element.mapName.contains('Apple'))){
        availableMaps.forEach((element) {
          if(element.mapName.contains('Apple')){
            availableMaps[availableMaps.indexOf(element)].showDirections(
              origin: Coords(origin!.latitude,origin.longitude),
              destination: Coords(distance!.latitude,distance.longitude),

            );
          }
        });
      }else{
        String googleUrl =
            'https://www.google.com/maps/dir/?api=1&origin=${origin!.latitude},${origin.longitude}&destination=${distance!.latitude},${distance.longitude}';
        print(googleUrl);
        if (await canLaunch(googleUrl)) {
          await launch(googleUrl);
        }
      }
    }
  }


  void getOrders({
    required BuildContext context,
  }){
    emit(OrderLoadingState());
    DioHelper.getData(
        url:EndPoints.getOrders,//val == 'new_orders'?EndPoints.getNearOrders:,
        //token: 'Bearer $token',
        query:
        // val == 'new_orders'?{
        //  "current_latitude":position?.latitude,
        //  "current_longitude":position?.longitude,
        //   "status":1,
        // }:
        {
          "page":1,
          "limit":1000000,
          "status":val == 'new_orders'?1:4,
        }
    ).then((value) {
      print(value.data);
      if(value.data['status']==true&&value.data['data']!=null){
        orderModel2 = OrderModel2.fromJson(value.data);
        // if(val == 'new_orders'){
        //   orderModel = OrderModel.fromJson(value.data);
        // }else{
        // }
        emit(OrderSuccessState());
      }else {
        bool? stopExecute = value.data['data']['stop_execute'];
        if(stopExecute!=null){
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context)=>AccountIsBlocked()
          );
        };
        UIAlert.showAlert(context,message: value.data['message']??'wrong'.tr(),type: MessageType.warning);
        emit(OrderWrongState());
      }
    }).catchError((e){
      print(e.toString());
      UIAlert.showAlert(context,message:'wrong'.tr(),type: MessageType.error);
      emit(OrderErrorState());
    });
  }



  void updateDeliveryLocation (){

    DioHelper.putData(
        url: EndPoints.updateLocation,
        token: 'Bearer $token',
        data: {
          "current_latitude":position!.latitude,
          "current_longitude":position!.longitude,
          "firebase_token":fcmToken,
          "current_language":myLocale,
        }).then((value) => print(value.data));
  }


  void changeOrderStatus(
    BuildContext context,{
    required String orderId,
    required int status,
    OrderData? data,
    String? time,
        bool fromShop = false,
  }) async{
    emit(ChangeOrderStatusLoadingState());
    FormData formData = FormData.fromMap({
      "order_id":orderId,
      "order_status":status,
    });
    if(time!=null)formData.fields.add(MapEntry('ordered_receiving_date', time));
    if(receiptImage!=null){
      MultipartFile file = await  MultipartFile.fromFile(
          receiptImage!.path,filename: receiptImage!.path.split('/').last
      );
      formData.files.add(MapEntry('ordered_receiving_receipt', file));
    }
    DioHelper.postData2(
        url: EndPoints.changeOrderStatus,
        token: 'Bearer $token',
        formData: formData
    ).then((value) {
      if (value.data['data']!=null&&value.data['status'] == true)
        {
          UIAlert.showAlert(
            context,
            message: value.data['message'],
          );
          getOrders(context: context);
          if(status == 1 ){
            navigateAndFinish(context, AppLayout());
          }
          if(status == 2){
            Navigator.pop(context);
          }
          if(status == 3){
            if(fromShop){
              getDirection(
                  destinationLatlng: LatLng(double.parse(data!.userLatitude??''), double.parse(data.userLatitude??''))
              );
              navigateTo(context, ToClientScreen(data));
            }else{
              getDirection(
                  destinationLatlng: LatLng(double.parse(data!.userLatitude??''), double.parse(data.userLatitude??''))
              );
              navigateTo(context, ToShopScreenScreen(data));
            }
          }else if(status == 4){
            if(fromShop){
              Navigator.pop(context);
            }else{
              AppCubit.get(context).receiptImage= null;
              AppCubit.get(context).emitState();
              navigateAndFinish(context, AppLayout());
            }
          }else if (status == 5){
            navigateAndFinish(context, CompleteOrderScreen(itemNumber: '${data?.itemNumber??'0'}',));
          };
        }
      else {
          bool? stopExecute = value.data['data']['stop_execute'];
          if(stopExecute!=null){
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context)=>AccountIsBlocked()
            );
          };
          UIAlert.showAlert(context,
            message: value.data['message'] ?? 'wrong'.tr(),
          );
          emit(ChangeOrderStatusWrongState());

        }
    }).catchError((e) {
      UIAlert.showAlert(context, message: e.toString());
      emit(ChangeOrderStatusErrorState());
    });
  }

  void bookOrder ({
    required BuildContext context,
    required OrderData data,
  }){
    emit(BookOrderLoadingState());
    DioHelper.postData(
        url: '${EndPoints.bookOrder}${data.id??''}',
        token: 'Bearer $token',
    ).then((value) {
      if(value.data['data']!=null&&value.data['status'] == true){
        UIAlert.showAlert(context,
          message: value.data['message'],
        );
        emit(BookOrderSuccessState());
        getDirection(
            destinationLatlng: LatLng(double.parse(data.userLatitude??''), double.parse(data.userLatitude??''))
        );
        navigateTo(context, FromClientScreen(data));
      }else{
        bool? stopExecute = value.data['data']['stop_execute'];
        if(stopExecute!=null){
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context)=>AccountIsBlocked()
          );
        };
        UIAlert.showAlert(context,
          message: value.data['message'] ?? 'wrong'.tr(),type: MessageType.warning
        );
        emit(BookOrderWrongState());
      }
    }).catchError((e){
      emit(BookOrderErrorState());
    });
  }




}