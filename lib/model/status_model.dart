// class StatusModel {
//   String sTATUS;
//   int tOTAL;

//   StatusModel({this.sTATUS, this.tOTAL});

//   StatusModel.fromJson(Map<String, dynamic> json) {
//     sTATUS = json['STATUS'];
//     tOTAL = json['TOTAL'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['STATUS'] = this.sTATUS;
//     data['TOTAL'] = this.tOTAL;
//     return data;
//   }
// }

class StatusModel {
  int id;
  String repairOrderno;
  String repairOpen;
  int repairOpenUnixtime;
  String repairUpdate;
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
  

  StatusModel(
      {this.id,
      this.repairOrderno,
      this.repairOpen,
      this.repairOpenUnixtime,
      this.repairUpdate,
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

  StatusModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    repairOrderno = json['repair_orderno'];
    repairOpen = json['repair_open'];
    repairOpenUnixtime = json['repair_open_unixtime'];
    repairUpdate = json['repair_update'];
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
    data['repair_open_unixtime'] = this.repairOpenUnixtime;
    data['repair_update'] = this.repairUpdate;
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
