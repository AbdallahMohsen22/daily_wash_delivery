class StaticPagesModel {
  String? message;
  bool? status;
  Data? data;

  StaticPagesModel({this.message, this.status, this.data});

  StaticPagesModel.fromJson(Map<String, dynamic> json) {
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
  String? termsAndConditiondsEn;
  String? termsAndConditiondsAr;
  String? termsAndConditiondsUr;
  String? aboutUsEn;
  String? aboutUsAr;
  String? aboutUsUr;

  Data(
      {this.termsAndConditiondsEn,
        this.termsAndConditiondsAr,
        this.termsAndConditiondsUr,
        this.aboutUsEn,
        this.aboutUsAr,
        this.aboutUsUr});

  Data.fromJson(Map<String, dynamic> json) {
    termsAndConditiondsEn = json['terms_and_conditionds_en'];
    termsAndConditiondsAr = json['terms_and_conditionds_ar'];
    termsAndConditiondsUr = json['terms_and_conditionds_ur'];
    aboutUsEn = json['about_us_en'];
    aboutUsAr = json['about_us_ar'];
    aboutUsUr = json['about_us_ur'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['terms_and_conditionds_en'] = this.termsAndConditiondsEn;
    data['terms_and_conditionds_ar'] = this.termsAndConditiondsAr;
    data['terms_and_conditionds_ur'] = this.termsAndConditiondsUr;
    data['about_us_en'] = this.aboutUsEn;
    data['about_us_ar'] = this.aboutUsAr;
    data['about_us_ur'] = this.aboutUsUr;
    return data;
  }
}
