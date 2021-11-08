class NameBranchModel {
  String branchName;

  NameBranchModel({this.branchName});

  NameBranchModel.fromJson(Map<String, dynamic> json) {
    branchName = json['branch_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branch_name'] = this.branchName;
    return data;
  }
}