class PumpStatus {
  String pumpId;
  String pumpChannal;
  String pumpNozzle;
  String pumpProduct;
  String pumpProductCode;
  String pumpStatus;
  String pumpAmount;
  String pumpLite;
  String pumpBath;

  PumpStatus(
      {this.pumpId,
      this.pumpChannal,
      this.pumpNozzle,
      this.pumpProduct,
      this.pumpProductCode,
      this.pumpStatus,
      this.pumpAmount,
      this.pumpLite,
      this.pumpBath});

  PumpStatus.fromJson(Map<String, dynamic> json) {
    pumpId = json['pump_id'];
    pumpChannal = json['pump_channal'];
    pumpNozzle = json['pump_nozzle'];
    pumpProduct = json['pump_product'];
    pumpProductCode = json['pump_product_code'];
    pumpStatus = json['pump_status'];
    pumpAmount = json['pump_amount'];
    pumpLite = json['pump_lite'];
    pumpBath = json['pump_bath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pump_id'] = this.pumpId;
    data['pump_channal'] = this.pumpChannal;
    data['pump_nozzle'] = this.pumpNozzle;
    data['pump_product'] = this.pumpProduct;
    data['pump_product_code'] = this.pumpProductCode;
    data['pump_status'] = this.pumpStatus;
    data['pump_amount'] = this.pumpAmount;
    data['pump_lite'] = this.pumpLite;
    data['pump_bath'] = this.pumpBath;
    return data;
  }
}
