class PhoneModel {
  int? phoneId;
  int? studentId;
  String? phone;
  String? phoneType;
  String? countryCode;
  String? areaCode;
  DateTime? updatedOn;
  DateTime? createdOn;

  PhoneModel(
      {this.phoneId,
      this.studentId,
      this.phone,
      this.phoneType,
      this.countryCode,
      this.areaCode,
      this.updatedOn,
      this.createdOn});

  PhoneModel.fromJson(Map<String, dynamic> json) {
    phoneId = json['phone_id'];
    studentId = json['student_id'];
    phone = json['phone'];
    phoneType = json['phone_type'];
    countryCode = json['country_code'];
    areaCode = json['area_code'];
    // updatedOn = json['updated_on'];
    // createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone_id'] = phoneId;
    data['student_id'] = studentId;
    data['phone'] = phone;
    data['phone_type'] = phoneType;
    data['country_code'] = countryCode;
    data['area_code'] = areaCode;
   if(updatedOn!=null) data['updated_on'] = updatedOn?.toIso8601String();
   if(createdOn!=null)  data['created_on'] =createdOn?.toIso8601String();
    return data;
  }
    get fullNumber => "${countryCode!} ${areaCode!} ${phone!}";
}
