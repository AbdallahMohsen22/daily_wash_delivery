class DeliveryModel {
  String? message;
  bool? status;
  Data? data;

  DeliveryModel({this.message, this.status, this.data});

  DeliveryModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  int? itemNumber;
  String? name;
  String? phoneNumber;
  String? vehicleType;
  String? firebaseToken;
  String? currentLanguage;
  String? personalPhoto;
  int? status;
  int? onlineStatus;
  String? createdAt;

  Data(
      {this.id,
        this.itemNumber,
        this.name,
        this.phoneNumber,
        this.vehicleType,
        this.firebaseToken,
        this.currentLanguage,
        this.personalPhoto,
        this.status,
        this.onlineStatus,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemNumber = json['item_number'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    vehicleType = json['vehicle_type'];
    firebaseToken = json['firebase_token'];
    currentLanguage = json['current_language'];
    personalPhoto = json['personal_photo'];
    status = json['status'];
    onlineStatus = json['online_status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_number'] = this.itemNumber;
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['vehicle_type'] = this.vehicleType;
    data['firebase_token'] = this.firebaseToken;
    data['current_language'] = this.currentLanguage;
    data['personal_photo'] = this.personalPhoto;
    data['status'] = this.status;
    data['online_status'] = this.onlineStatus;
    data['created_at'] = this.createdAt;
    return data;
  }
}
