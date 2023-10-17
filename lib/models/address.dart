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
    // updatedOn = json['updated_on'];
    // createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_id'] = addressId;
    data['student_id'] = studentId;
    data['address_line'] = addressLine;
    data['city'] = city;
    data['zip_postcode'] = zipPostcode;
    data['state'] = state;
   if(updatedOn!=null) data['updated_on'] = updatedOn?.toIso8601String();
   if(createdOn!=null)  data['created_on'] =createdOn?.toIso8601String();
    return data;
  }
   get desc => "${zipPostcode!}, ${city!}, ${state!}";
}
