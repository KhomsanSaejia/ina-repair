class BranchModel {
  int id;
  String branchCode;
  String branchName;
  String branchInstallDate;

  BranchModel(
      {this.id, this.branchCode, this.branchName, this.branchInstallDate});

  BranchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchCode = json['branch_code'];
    branchName = json['branch_name'];
    branchInstallDate = json['branch_install_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branch_code'] = this.branchCode;
    data['branch_name'] = this.branchName;
    data['branch_install_date'] = this.branchInstallDate;
    return data;
  }
}
