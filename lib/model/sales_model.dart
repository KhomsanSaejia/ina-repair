class SaleModel {
  int salesId;
  int salesTransId;
  String salesTransChannal;
  String salesTransDateStart;
  String salesTransDateFinish;
  String salesTimeStampInsert;
  String salesTransNozzle;
  String salesTransAmount;
  String salesTransLite;
  String salesTransBath;
  String salesTransBfMeterLite;
  String salesTransBfMeterBath;
  String salesTransAfMeterLite;
  String salesTransAfMeterBath;
  String salesFlagType;
  String pumpProduct;

  SaleModel(
      {this.salesId,
      this.salesTransId,
      this.salesTransChannal,
      this.salesTransDateStart,
      this.salesTransDateFinish,
      this.salesTimeStampInsert,
      this.salesTransNozzle,
      this.salesTransAmount,
      this.salesTransLite,
      this.salesTransBath,
      this.salesTransBfMeterLite,
      this.salesTransBfMeterBath,
      this.salesTransAfMeterLite,
      this.salesTransAfMeterBath,
      this.salesFlagType,
      this.pumpProduct});

  SaleModel.fromJson(Map<String, dynamic> json) {
    salesId = json['sales_id'];
    salesTransId = json['sales_trans_id'];
    salesTransChannal = json['sales_trans_channal'];
    salesTransDateStart = json['sales_trans_date_start'];
    salesTransDateFinish = json['sales_trans_date_finish'];
    salesTimeStampInsert = json['sales_time_stamp_insert'];
    salesTransNozzle = json['sales_trans_nozzle'];
    salesTransAmount = json['sales_trans_amount'];
    salesTransLite = json['sales_trans_lite'];
    salesTransBath = json['sales_trans_bath'];
    salesTransBfMeterLite = json['sales_trans_bf_meter_lite'];
    salesTransBfMeterBath = json['sales_trans_bf_meter_bath'];
    salesTransAfMeterLite = json['sales_trans_af_meter_lite'];
    salesTransAfMeterBath = json['sales_trans_af_meter_bath'];
    salesFlagType = json['sales_flag_type'];
    pumpProduct = json['pump_product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sales_id'] = this.salesId;
    data['sales_trans_id'] = this.salesTransId;
    data['sales_trans_channal'] = this.salesTransChannal;
    data['sales_trans_date_start'] = this.salesTransDateStart;
    data['sales_trans_date_finish'] = this.salesTransDateFinish;
    data['sales_time_stamp_insert'] = this.salesTimeStampInsert;
    data['sales_trans_nozzle'] = this.salesTransNozzle;
    data['sales_trans_amount'] = this.salesTransAmount;
    data['sales_trans_lite'] = this.salesTransLite;
    data['sales_trans_bath'] = this.salesTransBath;
    data['sales_trans_bf_meter_lite'] = this.salesTransBfMeterLite;
    data['sales_trans_bf_meter_bath'] = this.salesTransBfMeterBath;
    data['sales_trans_af_meter_lite'] = this.salesTransAfMeterLite;
    data['sales_trans_af_meter_bath'] = this.salesTransAfMeterBath;
    data['sales_flag_type'] = this.salesFlagType;
    data['pump_product'] = this.pumpProduct;
    return data;
  }
}
