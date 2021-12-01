class ReportRepair {
  String branchName;
  String repairOrderno;
  String repairDevice;
  String repairOpen;
  String repairClose;
  String repairSerialDevice;
  String repairWorkess;
  String repairWarranty;
  String branchMa;
  String branchCompany;
  String branchInstallDate;

  ReportRepair(
      {this.branchName,
      this.repairOrderno,
      this.repairDevice,
      this.repairOpen,
      this.repairClose,
      this.repairSerialDevice,
      this.repairWorkess,
      this.repairWarranty,
      this.branchMa,
      this.branchCompany,
      this.branchInstallDate});

  ReportRepair.fromJson(Map<String, dynamic> json) {
    branchName = json['branch_name'];
    repairOrderno = json['repair_orderno'];
    repairDevice = json['repair_device'];
    repairOpen = json['repair_open'];
    repairClose = json['repair_close'];
    repairSerialDevice = json['repair_serial_device'];
    repairWorkess = json['repair_workess'];
    repairWarranty = json['repair_warranty'];
    branchMa = json['branch_ma'];
    branchCompany = json['branch_company'];
    branchInstallDate = json['branch_install_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branch_name'] = this.branchName;
    data['repair_orderno'] = this.repairOrderno;
    data['repair_device'] = this.repairDevice;
    data['repair_open'] = this.repairOpen;
    data['repair_close'] = this.repairClose;
    data['repair_serial_device'] = this.repairSerialDevice;
    data['repair_workess'] = this.repairWorkess;
    data['repair_warranty'] = this.repairWarranty;
    data['branch_ma'] = this.branchMa;
    data['branch_company'] = this.branchCompany;
    data['branch_install_date'] = this.branchInstallDate;
    return data;
  }
}
