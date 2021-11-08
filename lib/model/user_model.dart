class UserModel {
  String empID;
  String empCode;
  String empDepartment;
  String empSection;
  String empPosition;
  String empName;
  String empTel;
  String empRemark;
  String empEmail;
  String empUsername;
  String empPassword;

  UserModel(
      {this.empID,
      this.empCode,
      this.empDepartment,
      this.empSection,
      this.empPosition,
      this.empName,
      this.empTel,
      this.empRemark,
      this.empEmail,
      this.empUsername,
      this.empPassword});

  UserModel.fromJson(Map<String, dynamic> json) {
    empID = json['empID'];
    empCode = json['empCode'];
    empDepartment = json['empDepartment'];
    empSection = json['empSection'];
    empPosition = json['empPosition'];
    empName = json['empName'];
    empTel = json['empTel'];
    empRemark = json['empRemark'];
    empEmail = json['empEmail'];
    empUsername = json['empUsername'];
    empPassword = json['empPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['empID'] = this.empID;
    data['empCode'] = this.empCode;
    data['empDepartment'] = this.empDepartment;
    data['empSection'] = this.empSection;
    data['empPosition'] = this.empPosition;
    data['empName'] = this.empName;
    data['empTel'] = this.empTel;
    data['empRemark'] = this.empRemark;
    data['empEmail'] = this.empEmail;
    data['empUsername'] = this.empUsername;
    data['empPassword'] = this.empPassword;
    return data;
  }
}
