class AlertModel {
  String sTATUS;
  int tOTAL;

  AlertModel({this.sTATUS, this.tOTAL});

  AlertModel.fromJson(Map<String, dynamic> json) {
    sTATUS = json['STATUS'];
    tOTAL = json['TOTAL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STATUS'] = this.sTATUS;
    data['TOTAL'] = this.tOTAL;
    return data;
  }
}
