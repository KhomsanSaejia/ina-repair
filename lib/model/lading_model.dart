class LadingModel {
  int id;
  String repairInawork;
  String repairDateopen;
  String repairBranchname;
  String repairDevice;
  String repairStockcutDevice;
  String repairStockcutSerail;
  String repairStockcutStatus;
  String repairStockcutDate;
  String repairEmpname;
  String empname;

  LadingModel(
      {this.id,
      this.repairInawork,
      this.repairDateopen,
      this.repairBranchname,
      this.repairDevice,
      this.repairStockcutDevice,
      this.repairStockcutSerail,
      this.repairStockcutStatus,
      this.repairStockcutDate,
      this.repairEmpname,
      this.empname});

  LadingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    repairInawork = json['repair_inawork'];
    repairDateopen = json['repair_dateopen'];
    repairBranchname = json['repair_branchname'];
    repairDevice = json['repair_device'];
    repairStockcutDevice = json['repair_stockcut_device'];
    repairStockcutSerail = json['repair_stockcut_serail'];
    repairStockcutStatus = json['repair_stockcut_status'];
    repairStockcutDate = json['repair_stockcut_date'];
    repairEmpname = json['repair_empname'];
    empname = json['empname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['repair_inawork'] = this.repairInawork;
    data['repair_dateopen'] = this.repairDateopen;
    data['repair_branchname'] = this.repairBranchname;
    data['repair_device'] = this.repairDevice;
    data['repair_stockcut_device'] = this.repairStockcutDevice;
    data['repair_stockcut_serail'] = this.repairStockcutSerail;
    data['repair_stockcut_status'] = this.repairStockcutStatus;
    data['repair_stockcut_date'] = this.repairStockcutDate;
    data['repair_empname'] = this.repairEmpname;
    data['empname'] = this.empname;
    return data;
  }
}
