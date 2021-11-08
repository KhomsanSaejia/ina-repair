class JobModel {
  int id;
  String repairOrderno;
  String repairOpen;
  String repairClose;
  String repairStatus;
  String branchName;
  String repairDevice;
  String repairSerialDevice;
  String repairWorkess;
  String repairTicketpt;
  String repairWarranty;
  String repairDetail;
  String repairEmp;

  JobModel(
      {this.id,
      this.repairOrderno,
      this.repairOpen,
      this.repairClose,
      this.repairStatus,
      this.branchName,
      this.repairDevice,
      this.repairSerialDevice,
      this.repairWorkess,
      this.repairTicketpt,
      this.repairWarranty,
      this.repairDetail,
      this.repairEmp});

  JobModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    repairOrderno = json['repair_orderno'];
    repairOpen = json['repair_open'];
    repairClose = json['repair_close'];
    repairStatus = json['repair_status'];
    branchName = json['branch_name'];
    repairDevice = json['repair_device'];
    repairSerialDevice = json['repair_serial_device'];
    repairWorkess = json['repair_workess'];
    repairTicketpt = json['repair_ticketpt'];
    repairWarranty = json['repair_warranty'];
    repairDetail = json['repair_detail'];
    repairEmp = json['repair_emp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['repair_orderno'] = this.repairOrderno;
    data['repair_open'] = this.repairOpen;
    data['repair_close'] = this.repairClose;
    data['repair_status'] = this.repairStatus;
    data['branch_name'] = this.branchName;
    data['repair_device'] = this.repairDevice;
    data['repair_serial_device'] = this.repairSerialDevice;
    data['repair_workess'] = this.repairWorkess;
    data['repair_ticketpt'] = this.repairTicketpt;
    data['repair_warranty'] = this.repairWarranty;
    data['repair_detail'] = this.repairDetail;
    data['repair_emp'] = this.repairEmp;
    return data;
  }
}
