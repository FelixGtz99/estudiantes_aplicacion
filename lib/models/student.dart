class StudentModel {
  int? studentId;
  String? lastName;
  String? middleName;
  String? firstName;
  String? gender;
   int? status;
  DateTime? updatedOn;
  DateTime? createdOn;

  StudentModel(
      {this.studentId,
      this.lastName,
      this.middleName,
      this.firstName,
      this.gender,
      this.updatedOn,
      this.createdOn,
      this.status = 1,
      });

  StudentModel.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    lastName = json['last_name'];
    middleName = json['middle_name'];
    firstName = json['first_name'];
    gender = json['gender'];
    status = json['status'] ?? 1 ;
   // updatedOn =DateTime.parse( json['updated_on'] );

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['student_id'] = this.studentId;
    data['last_name'] = this.lastName;
    data['middle_name'] = this.middleName;
    data['first_name'] = this.firstName;
    data['gender'] = this.gender;
    data['updated_on'] = updatedOn?.toIso8601String();
    data['created_on'] = createdOn?.toIso8601String();
    data['status'] = this.status;
    
    return data;
  }

  get fullName => "${firstName!} ${middleName!} ${lastName!}";
}
