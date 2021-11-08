class HistoryModel {
  int id;
  String repairOrderno;
  String repairOpen;
  String repairClose;
  String repairStatus;
  String branchCode;
  String repairDevice;
  String repairSerialDevice;
  String repairWorkess;
  String repairTicketpt;
  String repairWarranty;
  String repairDetail;
  String repairEmp;
  String branchName;
  String branchAddress;
  String branchLatlong;
  String branchTel;
  String branchInstallDate;

  HistoryModel(
      {this.id,
      this.repairOrderno,
      this.repairOpen,
      this.repairClose,
      this.repairStatus,
      this.branchCode,
      this.repairDevice,
      this.repairSerialDevice,
      this.repairWorkess,
      this.repairTicketpt,
      this.repairWarranty,
      this.repairDetail,
      this.repairEmp,
      this.branchName,
      this.branchAddress,
      this.branchLatlong,
      this.branchTel,
      this.branchInstallDate});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    repairOrderno = json['repair_orderno'];
    repairOpen = json['repair_open'];
    repairClose = json['repair_close'];
    repairStatus = json['repair_status'];
    branchCode = json['branch_code'];
    repairDevice = json['repair_device'];
    repairSerialDevice = json['repair_serial_device'];
    repairWorkess = json['repair_workess'];
    repairTicketpt = json['repair_ticketpt'];
    repairWarranty = json['repair_warranty'];
    repairDetail = json['repair_detail'];
    repairEmp = json['repair_emp'];
    branchName = json['branch_name'];
    branchAddress = json['branch_address'];
    branchLatlong = json['branch_latlong'];
    branchTel = json['branch_tel'];
    branchInstallDate = json['branch_install_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['repair_orderno'] = this.repairOrderno;
    data['repair_open'] = this.repairOpen;
    data['repair_close'] = this.repairClose;
    data['repair_status'] = this.repairStatus;
    data['branch_code'] = this.branchCode;
    data['repair_device'] = this.repairDevice;
    data['repair_serial_device'] = this.repairSerialDevice;
    data['repair_workess'] = this.repairWorkess;
    data['repair_ticketpt'] = this.repairTicketpt;
    data['repair_warranty'] = this.repairWarranty;
    data['repair_detail'] = this.repairDetail;
    data['repair_emp'] = this.repairEmp;
    data['branch_name'] = this.branchName;
    data['branch_address'] = this.branchAddress;
    data['branch_latlong'] = this.branchLatlong;
    data['branch_tel'] = this.branchTel;
    data['branch_install_date'] = this.branchInstallDate;
    return data;
  }
}
