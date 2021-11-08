class InOutModel {
  int id;
  String empId;
  String inDate;
  String inTime;
  String inUnixtime;
  String outDate;
  String outTime;
  String outUnixtime;
  String overTime;
  String referrence;

  InOutModel(
      {this.id,
      this.empId,
      this.inDate,
      this.inTime,
      this.inUnixtime,
      this.outDate,
      this.outTime,
      this.outUnixtime,
      this.overTime,
      this.referrence});

  InOutModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    empId = json['emp_id'];
    inDate = json['in_date'];
    inTime = json['in_time'];
    inUnixtime = json['in_unixtime'];
    outDate = json['out_date'];
    outTime = json['out_time'];
    outUnixtime = json['out_unixtime'];
    overTime = json['over_time'];
    referrence = json['referrence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['emp_id'] = this.empId;
    data['in_date'] = this.inDate;
    data['in_time'] = this.inTime;
    data['in_unixtime'] = this.inUnixtime;
    data['out_date'] = this.outDate;
    data['out_time'] = this.outTime;
    data['out_unixtime'] = this.outUnixtime;
    data['over_time'] = this.overTime;
    data['referrence'] = this.referrence;
    return data;
  }
}
