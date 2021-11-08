import 'package:flutter/material.dart';
import 'package:inapos/model/station_model.dart';
import 'package:inapos/utility/dialog.dart';
import 'package:inapos/utility/my_constant.dart';
import 'package:inapos/utility/mystyle.dart';
import 'package:dio/dio.dart';

class ScreenStationEdit extends StatefulWidget {
  final StationModel stationaddModel;
  ScreenStationEdit({Key key, this.stationaddModel}) : super(key: key);
  @override
  _ScreenStationEditState createState() => _ScreenStationEditState();
}

class _ScreenStationEditState extends State<ScreenStationEdit> {
  StationModel stationaddModel;

  String branchcode,
      branchname,
      branchaddress,
      branchlatlong,
      branchtel,
      branchinstalldate,
      branchma,
      branchcompany;
  void initState() {
    super.initState();
    stationaddModel = widget.stationaddModel;
    branchcode = stationaddModel.branchCode;
    branchname = stationaddModel.branchName;
    branchaddress = stationaddModel.branchAddress;
    branchlatlong = stationaddModel.branchLatlong;
    branchtel = stationaddModel.branchTel;
    branchinstalldate = stationaddModel.branchInstallDate;
    branchma = stationaddModel.branchMa;
    branchcompany = stationaddModel.branchCompany;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขข้อมูล ${stationaddModel.branchName}'),
      ),
      body: SingleChildScrollView(
        // padding: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Column(
          children: [
            Mystyle().mySizeBox(),
            branchCode(),
            Mystyle().mySizeBox(),
            branchName(),
            Mystyle().mySizeBox(),
            branchAddress(),
            Mystyle().mySizeBox(),
            branchLatlong(),
            Mystyle().mySizeBox(),
            branchTel(),
            Mystyle().mySizeBox(),
            branchInstalldate(),
            Mystyle().mySizeBox(),
            branchMA(),
            Mystyle().mySizeBox(),
            branchCompany(),
            Mystyle().mySizeBox(),
            btEditStation(),
          ],
        ),
      ),
    );
  }

  Widget branchCode() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top: 16.0),
            // width: 400,
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextFormField(
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                fontFamily: 'Sarabun',
                color: Colors.red.shade400,
              ),
              onChanged: (value) => branchcode = value.trim(),
              readOnly: true,
              initialValue: branchcode,
              decoration: InputDecoration(
                labelText: 'รหัสสาขา :',
                prefixIcon: Icon(Icons.pending_outlined),
                contentPadding:
                    new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ),
        ],
      );
  Widget branchName() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top: 16.0),
            // width: 400,
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextFormField(
              style: TextStyle(
                  color: Colors.green.shade400,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  fontFamily: 'Sarabun'),
              onChanged: (value) => branchname = value.trim(),
              initialValue: branchname,
              decoration: InputDecoration(
                labelText: 'ชื่อสาขา :',
                prefixIcon: Icon(Icons.pending_outlined),
                contentPadding:
                    new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ),
        ],
      );
  Widget branchAddress() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top: 16.0),
            // width: 400,
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextFormField(
              style: TextStyle(
                  color: Colors.green.shade400,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  fontFamily: 'Sarabun'),
              onChanged: (value) => branchaddress = value.trim(),
              initialValue: branchaddress,
              decoration: InputDecoration(
                labelText: 'ที่อยู่ :',
                prefixIcon: Icon(Icons.pending_outlined),
                contentPadding:
                    new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ),
        ],
      );
  Widget branchLatlong() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top: 16.0),
            // width: 400,
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextFormField(
              style: TextStyle(
                  color: Colors.green.shade400,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  fontFamily: 'Sarabun'),
              onChanged: (value) => branchlatlong = value.trim(),
              initialValue: branchlatlong,
              decoration: InputDecoration(
                labelText: 'ละติจูด ลองติจูด :',
                prefixIcon: Icon(Icons.pending_outlined),
                contentPadding:
                    new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ),
        ],
      );
  Widget branchTel() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top: 16.0),
            // width: 400,
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextFormField(
              style: TextStyle(
                  color: Colors.green.shade400,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  fontFamily: 'Sarabun'),
              onChanged: (value) => branchtel = value.trim(),
              initialValue: branchtel,
              decoration: InputDecoration(
                labelText: 'เบอร์โทร :',
                prefixIcon: Icon(Icons.pending_outlined),
                contentPadding:
                    new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ),
        ],
      );
  Widget branchInstalldate() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top: 16.0),
            // width: 400,
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextFormField(
              style: TextStyle(
                  color: Colors.green.shade400,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  fontFamily: 'Sarabun'),
              onChanged: (value) => branchinstalldate = value.trim(),
              initialValue: branchinstalldate,
              decoration: InputDecoration(
                labelText: 'วันติดตั้ง :',
                prefixIcon: Icon(Icons.pending_outlined),
                contentPadding:
                    new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ),
        ],
      );
  Widget branchMA() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top: 16.0),
            // width: 400,
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextFormField(
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                fontFamily: 'Sarabun',
                color: Colors.red.shade400,
              ),
              onChanged: (value) => branchma = value.trim(),
              readOnly: true,
              initialValue: branchma,
              decoration: InputDecoration(
                labelText: 'ประเภท :',
                prefixIcon: Icon(Icons.pending_outlined),
                contentPadding:
                    new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ),
        ],
      );
  Widget branchCompany() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top: 16.0),
            // width: 400,
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextFormField(
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                fontFamily: 'Sarabun',
                color: Colors.red.shade400,
              ),
              onChanged: (value) => branchcompany = value.trim(),
              readOnly: true,
              initialValue: branchcompany,
              decoration: InputDecoration(
                labelText: 'ลูกค้า :',
                prefixIcon: Icon(Icons.pending_outlined),
                contentPadding:
                    new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ),
        ],
      );

  Widget btEditStation() => Container(
      height: 70,
      width: 400,
      child: ElevatedButton(
        onPressed: () {
          if (branchcode == null ||
              branchcode.isEmpty ||
              branchname == null ||
              branchname.isEmpty ||
              branchaddress == null ||
              branchaddress.isEmpty ||
              branchlatlong == null ||
              branchlatlong.isEmpty ||
              branchtel == null ||
              branchtel.isEmpty ||
              branchinstalldate == null ||
              branchinstalldate.isEmpty) {
            normalDialog(context, 'ข้อมูลไม่ครบ กรุณาลองใหม่อีกครั้ง');
          } else {
            editStation();
          }
        },
        child: Text('บันทึกข้อมูล'),
        style: ElevatedButton.styleFrom(
          primary: Colors.teal,
          onPrimary: Colors.white,
          textStyle: TextStyle(
              color: Colors.black, fontSize: 40, fontFamily: 'Sarabun'),
        ),
      ));
  Future<Null> editStation() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Mystyle().showTitleH2('คุณต้องการแก้ไขข้อมูลใช่หรือไม่'),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextButton.icon(
                icon: Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                onPressed: () async {
                  String url = '${MyConstant().urlBranchEdit}';
                  await Dio().post(url, data: {
                    "id": stationaddModel.id,
                    "branch_code": stationaddModel.branchCode,
                    "branch_name": branchname,
                    "branch_address": branchaddress,
                    "branch_latlong": branchlatlong,
                    "branch_tel": branchtel,
                    "branch_install_date": branchinstalldate,
                    "branch_ma": branchma,
                    "branch_company": branchcompany
                  }).then(
                    (value) {
                      if (value.toString() == 'EDIT STATION SUCCESS') {
                        print('EDIT STATION SUCCESS');
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }

                      // readalluser();
                    },
                  );
                },
                label: Text('ตกลง',
                    style: TextStyle(fontSize: 30, fontFamily: 'Sarabun')),
              ),
              TextButton.icon(
                icon: Icon(
                  Icons.clear,
                  color: Colors.red,
                ),
                onPressed: () => Navigator.pop(context),
                label: Text('ยกเลิก',
                    style: TextStyle(fontSize: 30, fontFamily: 'Sarabun')),
              ),
            ],
          )
        ],
      ),
    );
  }
}
