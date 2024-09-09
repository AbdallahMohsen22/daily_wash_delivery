class OrderModel {
  String? message;
  bool? status;
  List<OrderData>? data;

  OrderModel({this.message, this.status, this.data,});

  OrderModel.fromJson(Map<String, dynamic> json,) {
    message = json['message'];
    status = json['status'];
    if(json['data']!=null){
      data = <OrderData>[];
      json['data'].forEach((v) {
        if(v['provider_name']!=null){
          data!.add(new OrderData.fromJson(v));
        }
        //data!.add(new OrderData.fromJson(v));
      });
    }
  }
}

class OrderModel2  {
  String? message;
  bool? status;
  Data? data;

  OrderModel2({this.message, this.status, this.data});

  OrderModel2.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? currentPage;
  int? pages;
  int? count;
  List<OrderData>? data;

  Data({this.currentPage, this.pages, this.count, this.data});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    pages = json['pages'];
    count = json['count'];
    if (json['data'] != null) {
      data = <OrderData>[];
      json['data'].forEach((v) {
        if(v['provider_name']!=null){
          data!.add(new OrderData.fromJson(v));
        }
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentPage'] = this.currentPage;
    data['pages'] = this.pages;
    data['count'] = this.count;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class OrderData {
  String? id;
  String? userName;
  String? userPhone;
  String? providerLatitude;
  String? providerLongitude;
  String? providerName;
  String? providerPhone;
  int? itemNumber;
  int? status;
  int? serviceType;
  String? userLatitude;
  String? userLongitude;
  dynamic vatValue;
  dynamic appFees;
  dynamic subTotalPrice;
  dynamic shippingCharges;
  dynamic totalPrice;
  String? additionalNotes;
  String? paymentMethod;
  List<UserAddress>? userAddress;
  String? orderedDate;
  String? createdAt;
  String? deliveryManLatitude;
  String? deliveryManLongitude;
  String? deliveryManName;
  String? deliveryManPhone;
  String? providerPersonalPhoto;
  String? orderedReceivingDate;
  String? distance;
  String? orderedReceivingReceipt;

  OrderData(
      {this.id,
        this.userName,
        this.userPhone,
        this.providerLatitude,
        this.providerLongitude,
        this.providerName,
        this.providerPhone,
        this.itemNumber,
        this.status,
        this.serviceType,
        this.userLatitude,
        this.userLongitude,
        this.vatValue,
        this.appFees,
        this.subTotalPrice,
        this.shippingCharges,
        this.totalPrice,
        this.additionalNotes,
        this.paymentMethod,
        this.userAddress,
        this.orderedDate,
        this.createdAt,
        this.deliveryManLatitude,
        this.deliveryManLongitude,
        this.deliveryManName,
        this.deliveryManPhone});

  OrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    userPhone = json['user_phone'];
    providerLatitude = json['provider_latitude'];
    providerLongitude = json['provider_longitude'];
    providerName = json['provider_name'];
    providerPhone = json['provider_phone'];
    providerPersonalPhoto = json['provider_personal_photo'];
    itemNumber = json['item_number'];
    orderedReceivingDate = json['ordered_receiving_date'];
    status = json['status'];
    serviceType = json['service_type'];
    userLatitude = json['user_latitude'];
    userLongitude = json['user_longitude'];
    vatValue = json['vat_value'];
    appFees = json['app_fees'];
    subTotalPrice = json['sub_total_price'];
    shippingCharges = json['shipping_charges'];
    totalPrice = json['total_price'];
    additionalNotes = json['additional_notes'];
    paymentMethod = json['payment_method'];
    if (json['user_address'] != null) {
      userAddress = <UserAddress>[];
      json['user_address'].forEach((v) {
        userAddress!.add(new UserAddress.fromJson(v));
      });
    }
    orderedDate = json['ordered_date'];
    createdAt = json['created_at'];
    deliveryManLatitude = json['delivery_man_latitude'];
    deliveryManLongitude = json['delivery_man_longitude'];
    deliveryManName = json['delivery_man_name'];
    deliveryManPhone = json['delivery_man_phone'];
    distance = json['distance'];
    orderedReceivingReceipt = json['ordered_receiving_receipt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_name'] = this.userName;
    data['user_phone'] = this.userPhone;
    data['provider_latitude'] = this.providerLatitude;
    data['provider_longitude'] = this.providerLongitude;
    data['provider_name'] = this.providerName;
    data['provider_phone'] = this.providerPhone;
    data['item_number'] = this.itemNumber;
    data['status'] = this.status;
    data['service_type'] = this.serviceType;
    data['user_latitude'] = this.userLatitude;
    data['user_longitude'] = this.userLongitude;
    data['vat_value'] = this.vatValue;
    data['app_fees'] = this.appFees;
    data['sub_total_price'] = this.subTotalPrice;
    data['shipping_charges'] = this.shippingCharges;
    data['total_price'] = this.totalPrice;
    data['additional_notes'] = this.additionalNotes;
    data['payment_method'] = this.paymentMethod;
    if (this.userAddress != null) {
      data['user_address'] = this.userAddress!.map((v) => v.toJson()).toList();
    }
    data['ordered_date'] = this.orderedDate;
    data['created_at'] = this.createdAt;
    data['delivery_man_latitude'] = this.deliveryManLatitude;
    data['delivery_man_longitude'] = this.deliveryManLongitude;
    data['delivery_man_name'] = this.deliveryManName;
    data['delivery_man_phone'] = this.deliveryManPhone;
    return data;
  }
}

class UserAddress {
  String? id;
  String? title;

  UserAddress({this.id, this.title});

  UserAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
