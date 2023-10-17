class AddressModel {
  int? addressId;
  int? studentId;
  String? addressLine;
  String? city;
  String? zipPostcode;
  String? state;
  DateTime? updatedOn;
  DateTime? createdOn;

  AddressModel(
      {this.addressId,
      this.studentId,
      this.addressLine,
      this.city,
      this.zipPostcode,
      this.state,
      this.updatedOn,
      this.createdOn});

  AddressModel.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    studentId = json['student_id'];
    addressLine = json['address_line'];
    city = json['city'];
    zipPostcode = json['zip_postcode'];
    state = json['state'];
    updatedOn = json['updated_on'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_id'] = this.addressId;
    data['student_id'] = this.studentId;
    data['address_line'] = this.addressLine;
    data['city'] = this.city;
    data['zip_postcode'] = this.zipPostcode;
    data['state'] = this.state;
    data['updated_on'] = this.updatedOn;
    data['created_on'] = this.createdOn;
    return data;
  }
}
