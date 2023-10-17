enum EmailType  {
 tipo1   
}

class EmailModel {
  String? email;
  int? studentId;
  String? emailType;
  DateTime? updatedOn;
  DateTime? createdOn;

  EmailModel(
      {this.email,
      this.studentId,
      this.emailType,
      this.updatedOn,
      this.createdOn});

  EmailModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    studentId = json['student_id'];
    emailType = json['email_type'];
    updatedOn = json['updated_on'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['student_id'] = this.studentId;
    data['email_type'] = this.emailType;
    data['updated_on'] = this.updatedOn;
    data['created_on'] = this.createdOn;
    return data;
  }
}
