class InOutModel {
  String empId;
  String empName;
  String inDate;
  String inTime;
  String outTime;
  String overTime;
  String referrence;
  String empDepartment;
  String empPosition;

  InOutModel(
      {this.empId,
      this.empName,
      this.inDate,
      this.inTime,
      this.outTime,
      this.overTime,
      this.referrence,
      this.empDepartment,
      this.empPosition});

  InOutModel.fromJson(Map<String, dynamic> json) {
    empId = json['emp_id'];
    empName = json['emp_Name'];
    inDate = json['in_date'];
    inTime = json['in_time'];
    outTime = json['out_time'];
    overTime = json['over_time'];
    referrence = json['referrence'];
    empDepartment = json['emp_Department'];
    empPosition = json['emp_Position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_id'] = this.empId;
    data['emp_Name'] = this.empName;
    data['in_date'] = this.inDate;
    data['in_time'] = this.inTime;
    data['out_time'] = this.outTime;
    data['over_time'] = this.overTime;
    data['referrence'] = this.referrence;
    data['emp_Department'] = this.empDepartment;
    data['emp_Position'] = this.empPosition;
    return data;
  }
}
