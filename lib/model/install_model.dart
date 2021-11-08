class InstallModel {
  int id;
  String installRef;
  String branchName;
  String teamInstall;
  String dateInstall;
  String dateSave;
  String pumpModel;
  String pumpConnection;
  String totalFcc;
  String totalEys;
  String totalEyk;
  String totalUnion;
  String totalPg11;
  String totalRubberblock;
  String totalLl;
  String totalLr;
  String totalClamp;
  String totalC;
  String totalCompound;
  String totalFiber;
  String totalBrass;
  String detail1Pos;
  String detail2Pos;
  String detail1Printer;
  String detail2Printer;
  String detail1Keyboard;
  String detail2Keyboard;
  String detail1UPS;
  String detail2UPS;
  String detail1Scanner;
  String detail2Scanner;
  String detail1Surge;
  String detail2Surge;
  String detail1AP;
  String detail2AP;
  String detail1SLAVE;
  String detail2SLAVE;
  String detail1Master;
  String detail2Master;

  InstallModel(
      {this.id,
      this.installRef,
      this.branchName,
      this.teamInstall,
      this.dateInstall,
      this.dateSave,
      this.pumpModel,
      this.pumpConnection,
      this.totalFcc,
      this.totalEys,
      this.totalEyk,
      this.totalUnion,
      this.totalPg11,
      this.totalRubberblock,
      this.totalLl,
      this.totalLr,
      this.totalClamp,
      this.totalC,
      this.totalCompound,
      this.totalFiber,
      this.totalBrass,
      this.detail1Pos,
      this.detail2Pos,
      this.detail1Printer,
      this.detail2Printer,
      this.detail1Keyboard,
      this.detail2Keyboard,
      this.detail1UPS,
      this.detail2UPS,
      this.detail1Scanner,
      this.detail2Scanner,
      this.detail1Surge,
      this.detail2Surge,
      this.detail1AP,
      this.detail2AP,
      this.detail1SLAVE,
      this.detail2SLAVE,
      this.detail1Master,
      this.detail2Master});

  InstallModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    installRef = json['install_ref'];
    branchName = json['branch_name'];
    teamInstall = json['teamInstall'];
    dateInstall = json['date_install'];
    dateSave = json['date_save'];
    pumpModel = json['pump_model'];
    pumpConnection = json['pump_connection'];
    totalFcc = json['total_fcc'];
    totalEys = json['total_eys'];
    totalEyk = json['total_eyk'];
    totalUnion = json['total_union'];
    totalPg11 = json['total_pg11'];
    totalRubberblock = json['total_rubberblock'];
    totalLl = json['total_ll'];
    totalLr = json['total_lr'];
    totalClamp = json['total_clamp'];
    totalC = json['total_C'];
    totalCompound = json['total_compound'];
    totalFiber = json['total_fiber'];
    totalBrass = json['total_brass'];
    detail1Pos = json['detail1Pos'];
    detail2Pos = json['detail2Pos'];
    detail1Printer = json['detail1Printer'];
    detail2Printer = json['detail2Printer'];
    detail1Keyboard = json['detail1Keyboard'];
    detail2Keyboard = json['detail2Keyboard'];
    detail1UPS = json['detail1UPS'];
    detail2UPS = json['detail2UPS'];
    detail1Scanner = json['detail1Scanner'];
    detail2Scanner = json['detail2Scanner'];
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
    data['install_ref'] = this.installRef;
    data['branch_name'] = this.branchName;
    data['teamInstall'] = this.teamInstall;
    data['date_install'] = this.dateInstall;
    data['date_save'] = this.dateSave;
    data['pump_model'] = this.pumpModel;
    data['pump_connection'] = this.pumpConnection;
    data['total_fcc'] = this.totalFcc;
    data['total_eys'] = this.totalEys;
    data['total_eyk'] = this.totalEyk;
    data['total_union'] = this.totalUnion;
    data['total_pg11'] = this.totalPg11;
    data['total_rubberblock'] = this.totalRubberblock;
    data['total_ll'] = this.totalLl;
    data['total_lr'] = this.totalLr;
    data['total_clamp'] = this.totalClamp;
    data['total_C'] = this.totalC;
    data['total_compound'] = this.totalCompound;
    data['total_fiber'] = this.totalFiber;
    data['total_brass'] = this.totalBrass;
    data['detail1Pos'] = this.detail1Pos;
    data['detail2Pos'] = this.detail2Pos;
    data['detail1Printer'] = this.detail1Printer;
    data['detail2Printer'] = this.detail2Printer;
    data['detail1Keyboard'] = this.detail1Keyboard;
    data['detail2Keyboard'] = this.detail2Keyboard;
    data['detail1UPS'] = this.detail1UPS;
    data['detail2UPS'] = this.detail2UPS;
    data['detail1Scanner'] = this.detail1Scanner;
    data['detail2Scanner'] = this.detail2Scanner;
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
