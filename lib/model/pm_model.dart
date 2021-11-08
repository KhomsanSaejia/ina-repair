class PMmodel {
  int id;
  String pmRef;
  String branchName;
  String teamInstall;
  String datePm;
  String dateSave;
  String totalFcc;
  String totalPower5v;
  String totalPower12v;
  String totalCurlentloop;
  String totalAttenna2m;
  String totalAttenna3m;
  String totalEdc;
  String totalScanner;
  String detail1Pos;
  String detail2Pos;
  String detail1Printer;
  String detail2Printer;
  String detail1Keyboard;
  String detail2Keyboard;
  String detail1UPS;
  String detail2UPS;
  String detail1Surge;
  String detail2Surge;
  String detail1AP;
  String detail2AP;
  String detail1SLAVE;
  String detail2SLAVE;
  String detail1Master;
  String detail2Master;

  PMmodel(
      {this.id,
      this.pmRef,
      this.branchName,
      this.teamInstall,
      this.datePm,
      this.dateSave,
      this.totalFcc,
      this.totalPower5v,
      this.totalPower12v,
      this.totalCurlentloop,
      this.totalAttenna2m,
      this.totalAttenna3m,
      this.totalEdc,
      this.totalScanner,
      this.detail1Pos,
      this.detail2Pos,
      this.detail1Printer,
      this.detail2Printer,
      this.detail1Keyboard,
      this.detail2Keyboard,
      this.detail1UPS,
      this.detail2UPS,
      this.detail1Surge,
      this.detail2Surge,
      this.detail1AP,
      this.detail2AP,
      this.detail1SLAVE,
      this.detail2SLAVE,
      this.detail1Master,
      this.detail2Master});

  PMmodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pmRef = json['pm_ref'];
    branchName = json['branch_name'];
    teamInstall = json['teamInstall'];
    datePm = json['date_pm'];
    dateSave = json['date_save'];
    totalFcc = json['total_fcc'];
    totalPower5v = json['total_power5v'];
    totalPower12v = json['total_power12v'];
    totalCurlentloop = json['total_curlentloop'];
    totalAttenna2m = json['total_attenna2m'];
    totalAttenna3m = json['total_attenna3m'];
    totalEdc = json['total_edc'];
    totalScanner = json['total_scanner'];
    detail1Pos = json['detail1Pos'];
    detail2Pos = json['detail2Pos'];
    detail1Printer = json['detail1Printer'];
    detail2Printer = json['detail2Printer'];
    detail1Keyboard = json['detail1Keyboard'];
    detail2Keyboard = json['detail2Keyboard'];
    detail1UPS = json['detail1UPS'];
    detail2UPS = json['detail2UPS'];
    detail1Surge = json['detail1Surge'];
    detail2Surge = json['detail2Surge'];
    detail1AP = json['detail1AP'];
    detail2AP = json['detail2AP'];
    detail1SLAVE = json['detail1SLAVE'];
    detail2SLAVE = json['detail2SLAVE'];
    detail1Master = json['detail1Master'];
    detail2Master = json['detail2Master'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pm_ref'] = this.pmRef;
    data['branch_name'] = this.branchName;
    data['teamInstall'] = this.teamInstall;
    data['date_pm'] = this.datePm;
    data['date_save'] = this.dateSave;
    data['total_fcc'] = this.totalFcc;
    data['total_power5v'] = this.totalPower5v;
    data['total_power12v'] = this.totalPower12v;
    data['total_curlentloop'] = this.totalCurlentloop;
    data['total_attenna2m'] = this.totalAttenna2m;
    data['total_attenna3m'] = this.totalAttenna3m;
    data['total_edc'] = this.totalEdc;
    data['total_scanner'] = this.totalScanner;
    data['detail1Pos'] = this.detail1Pos;
    data['detail2Pos'] = this.detail2Pos;
    data['detail1Printer'] = this.detail1Printer;
    data['detail2Printer'] = this.detail2Printer;
    data['detail1Keyboard'] = this.detail1Keyboard;
    data['detail2Keyboard'] = this.detail2Keyboard;
    data['detail1UPS'] = this.detail1UPS;
    data['detail2UPS'] = this.detail2UPS;
    data['detail1Surge'] = this.detail1Surge;
    data['detail2Surge'] = this.detail2Surge;
    data['detail1AP'] = this.detail1AP;
    data['detail2AP'] = this.detail2AP;
    data['detail1SLAVE'] = this.detail1SLAVE;
    data['detail2SLAVE'] = this.detail2SLAVE;
    data['detail1Master'] = this.detail1Master;
    data['detail2Master'] = this.detail2Master;
    return data;
  }
}
