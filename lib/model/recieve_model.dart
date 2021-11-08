class RecieveModel {
  int id;
  String recId;
  String recDate;
  String recInv;
  String stockMaterial;
  int recTotal;
  String empName;

  RecieveModel(
      {this.id,
      this.recId,
      this.recDate,
      this.recInv,
      this.stockMaterial,
      this.recTotal,
      this.empName});

  RecieveModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    recId = json['rec_id'];
    recDate = json['rec_date'];
    recInv = json['rec_inv'];
    stockMaterial = json['stock_material'];
    recTotal = json['rec_total'];
    empName = json['emp_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rec_id'] = this.recId;
    data['rec_date'] = this.recDate;
    data['rec_inv'] = this.recInv;
    data['stock_material'] = this.stockMaterial;
    data['rec_total'] = this.recTotal;
    data['emp_Name'] = this.empName;
    return data;
  }
}
