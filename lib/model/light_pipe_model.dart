class LightpipeModel {
  int id;
  String installRef;
  String branchName;
  String teamInstall;
  String dateInstall;
  String dateSave;
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

  LightpipeModel(
      {this.id,
      this.installRef,
      this.branchName,
      this.teamInstall,
      this.dateInstall,
      this.dateSave,
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
      this.totalBrass});

  LightpipeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    installRef = json['install_ref'];
    branchName = json['branch_name'];
    teamInstall = json['teamInstall'];
    dateInstall = json['date_install'];
    dateSave = json['date_save'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['install_ref'] = this.installRef;
    data['branch_name'] = this.branchName;
    data['teamInstall'] = this.teamInstall;
    data['date_install'] = this.dateInstall;
    data['date_save'] = this.dateSave;
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
    return data;
  }
}
