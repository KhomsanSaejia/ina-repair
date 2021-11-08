class StationModel {
  int id;
  String branchCode;
  String branchName;
  String branchAddress;
  String branchLatlong;
  String branchTel;
  String branchInstallDate;
  String branchMa;
  String branchCompany;

  StationModel(
      {this.id,
      this.branchCode,
      this.branchName,
      this.branchAddress,
      this.branchLatlong,
      this.branchTel,
      this.branchInstallDate,
      this.branchMa,
      this.branchCompany});

  StationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchCode = json['branch_code'];
    branchName = json['branch_name'];
    branchAddress = json['branch_address'];
    branchLatlong = json['branch_latlong'];
    branchTel = json['branch_tel'];
    branchInstallDate = json['branch_install_date'];
    branchMa = json['branch_ma'];
    branchCompany = json['branch_company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branch_code'] = this.branchCode;
    data['branch_name'] = this.branchName;
    data['branch_address'] = this.branchAddress;
    data['branch_latlong'] = this.branchLatlong;
    data['branch_tel'] = this.branchTel;
    data['branch_install_date'] = this.branchInstallDate;
    data['branch_ma'] = this.branchMa;
    data['branch_company'] = this.branchCompany;
    return data;
  }
}
