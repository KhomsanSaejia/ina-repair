class StockModel {
  int id;
  String stockId;
  String stockMaterial;
  String stockMaterialDetial;
  int stockTotal;
  String stockLastupdate;
  String empCode;

  StockModel(
      {this.id,
      this.stockId,
      this.stockMaterial,
      this.stockMaterialDetial,
      this.stockTotal,
      this.stockLastupdate,
      this.empCode});

  StockModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stockId = json['stock_id'];
    stockMaterial = json['stock_material'];
    stockMaterialDetial = json['stock_material_detial'];
    stockTotal = json['stock_total'];
    stockLastupdate = json['stock_lastupdate'];
    empCode = json['emp_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['stock_id'] = this.stockId;
    data['stock_material'] = this.stockMaterial;
    data['stock_material_detial'] = this.stockMaterialDetial;
    data['stock_total'] = this.stockTotal;
    data['stock_lastupdate'] = this.stockLastupdate;
    data['emp_code'] = this.empCode;
    return data;
  }
}
