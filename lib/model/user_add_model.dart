class UseraddModel {
  int empId;
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

  UseraddModel(
      {this.empId,
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

  UseraddModel.fromJson(Map<String, dynamic> json) {
    empId = json['emp_id'];
    empCode = json['emp_code'];
    empDepartment = json['emp_Department'];
    empSection = json['emp_Section'];
    empPosition = json['emp_Position'];
    empName = json['emp_Name'];
    empTel = json['emp_Tel'];
    empRemark = json['emp_Remark'];
    empEmail = json['emp_Email'];
    empUsername = json['emp_Username'];
    empPassword = json['emp_Password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_id'] = this.empId;
    data['emp_code'] = this.empCode;
    data['emp_Department'] = this.empDepartment;
    data['emp_Section'] = this.empSection;
    data['emp_Position'] = this.empPosition;
    data['emp_Name'] = this.empName;
    data['emp_Tel'] = this.empTel;
    data['emp_Remark'] = this.empRemark;
    data['emp_Email'] = this.empEmail;
    data['emp_Username'] = this.empUsername;
    data['emp_Password'] = this.empPassword;
    return data;
  }
}
