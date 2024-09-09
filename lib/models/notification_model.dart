import 'package:daily_wash/models/order_model.dart';

class NotificationModel {
  String? message;
  bool? status;
  Data? data;

  NotificationModel({this.message, this.status, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
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
  List<NotificationData>? data;

  Data({this.currentPage, this.pages, this.count, this.data});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    pages = json['pages'];
    count = json['count'];
    if (json['data'] != null) {
      data = <NotificationData>[];
      json['data'].forEach((v) {
        data!.add(new NotificationData.fromJson(v));
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

class NotificationData {
  String? id;
  String? title;
  String? body;
  OrderData? orderId;
  String? createdAt;

  NotificationData({this.id, this.title, this.body, this.orderId, this.createdAt});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    orderId = json['order_id'] != null
        ? new OrderData.fromJson(json['order_id'])
        : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    if (this.orderId != null) {
      data['order_id'] = this.orderId!.toJson();
    }
    data['created_at'] = this.createdAt;
    return data;
  }
}

class OrderId {
  String? providerPersonalPhoto;
  String? orderedReceivingReceipt;
  String? orderedReceivingDate;
  String? orderedDate;
  String? createdAt;

  OrderId(
      {this.providerPersonalPhoto,
        this.orderedReceivingReceipt,
        this.orderedReceivingDate,
        this.orderedDate,
        this.createdAt});

  OrderId.fromJson(Map<String, dynamic> json) {
    providerPersonalPhoto = json['provider_personal_photo'];
    orderedReceivingReceipt = json['ordered_receiving_receipt'];
    orderedReceivingDate = json['ordered_receiving_date'];
    orderedDate = json['ordered_date'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['provider_personal_photo'] = this.providerPersonalPhoto;
    data['ordered_receiving_receipt'] = this.orderedReceivingReceipt;
    data['ordered_receiving_date'] = this.orderedReceivingDate;
    data['ordered_date'] = this.orderedDate;
    data['created_at'] = this.createdAt;
    return data;
  }
}
