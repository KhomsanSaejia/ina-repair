import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:inapos/utility/dialog.dart';
import 'package:inapos/utility/my_constant.dart';
import 'package:inapos/utility/mystyle.dart';
import 'package:toast/toast.dart';

class ScreenStationAdd extends StatefulWidget {
  @override
  _ScreenStationAddState createState() => _ScreenStationAddState();
}

class _ScreenStationAddState extends State<ScreenStationAdd> {
  String branchcode,
      branchname,
      branchaddress,
      branchlatlong,
      branchtel,
      branchinstalldate;
  String branchMa;
  List<Map> myListMa = [
    {"id": '1', "name": "MA"},
    {"id": '2', "name": "เช่า"}
  ];
  String branchCompany;
  List<Map> myListCompany = [
    {"id": '1', "name": "PTC"},
    {"id": '2', "name": "OLP"},
    {"id": '3', "name": "FRANCHISE"},
    {"id": '4', "name": "FFM"}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'เพิ่มข้อมูลสาขาใหม่',
          style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontFamily: 'Sarabun',
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        // padding: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
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
            // Mystyle().mySizeBox(),
            listMa(),
            // Mystyle().mySizeBox(),
            listType(),
            Mystyle().mySizeBox(),
            btAddStation(),
            // backlogin()
          ],
        ),
      ),
    );
  }

  Widget listMa() => Container(
        margin: EdgeInsets.only(top: 10.0),
        height: 75,
        width: 400,
        // padding: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32.0),
          border: Border.all(style: BorderStyle.solid, color: Colors.black),
        ),
        child: Center(
          child: DropdownButton<String>(
            // isDense: true,
            hint: new Text("ประเภท",
                style: TextStyle(fontFamily: 'Sarabun', fontSize: 30)),
            value: branchMa,
            onChanged: (String newValue) {
              setState(() {
                branchMa = newValue;
              });
            },
            items: myListMa.map((Map map) {
              return new DropdownMenuItem<String>(
                value: map["name"].toString(),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 200,
                      // margin: EdgeInsets.only(left: 10),
                      child: Text(
                        map["name"],
                        style: TextStyle(
                            fontFamily: 'Sarabun',
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      );
  Widget listType() => Container(
        margin: EdgeInsets.only(top: 10.0),
        height: 75,
        width: 400,
        // padding: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32.0),
          border: Border.all(style: BorderStyle.solid, color: Colors.black),
        ),
        child: Center(
          child: DropdownButton<String>(
            // isDense: true,
            hint: new Text("ลูกค้า",
                style: TextStyle(fontFamily: 'Sarabun', fontSize: 30)),
            value: branchCompany,
            onChanged: (String newValue) {
              setState(() {
                branchCompany = newValue;
              });
            },
            items: myListCompany.map((Map map) {
              return new DropdownMenuItem<String>(
                value: map["name"].toString(),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 200,
                      // margin: EdgeInsets.only(left: 10),
                      child: Text(
                        map["name"],
                        style: TextStyle(
                            fontFamily: 'Sarabun',
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      );

  Widget branchCode() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top: 16.0),
            width: 400,
            child: TextFormField(
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  fontFamily: 'Sarabun'),
              onChanged: (value) => branchcode = value.trim(),
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
            width: 400,
            child: TextFormField(
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  fontFamily: 'Sarabun'),
              onChanged: (value) => branchname = value.trim(),
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
            width: 400,
            child: TextFormField(
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  fontFamily: 'Sarabun'),
              onChanged: (value) => branchaddress = value.trim(),
              maxLines: 3,
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
            width: 400,
            child: TextFormField(
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  fontFamily: 'Sarabun'),
              onChanged: (value) => branchlatlong = value.trim(),
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
            width: 400,
            child: TextFormField(
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  fontFamily: 'Sarabun'),
              onChanged: (value) => branchtel = value.trim(),
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
            width: 400,
            child: TextFormField(
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  fontFamily: 'Sarabun'),
              onChanged: (value) => branchinstalldate = value.trim(),
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
  Widget btAddStation() => Container(
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
            checkStation();
          }
        },
        child: Text('เพิ่มข้อมูล'),
        style: ElevatedButton.styleFrom(
          primary: Colors.teal,
          onPrimary: Colors.white,
          textStyle: TextStyle(
              color: Colors.black, fontSize: 40, fontFamily: 'Sarabun'),
        ),
      ));
  Future<Null> checkStation() async {
    String url = '${MyConstant().urlBranchCheck}';
    try {
      await Dio().post(url, data: {'branch': branchname}).then((value) {
        print('${MyConstant().urlBranchCheck} ${value.toString()}');
        if (value.toString() == 'ADD STATION SUCCESS') {
          addStation();
          // clearTextInput();
          // normalDialog(context, 'Account successfully added');
          // Navigator.pop(context);
          // Toast.show("เพิ่มสาขาสำเร็จ", context,
          //     duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
          // normalDialog(context, 'เพิ่มผู้ใช้งาน สำเร็จ');
          // Navigator.pop(context);
          // Navigator.pop(context);
        } else {
          normalDialog(context, 'สาขานี้มีในระบบแล้ว กรุณาลองใหม่อีกครั้ง');
        }
      });
    } catch (e) {
      normalDialog(context, e);
    }
  }

  Future<Null> addStation() async {
    String url = '${MyConstant().urlBranchAdd}';
    try {
      Response response = await Dio().post(url, data: {
        "branch_code": branchcode,
        "branch_name": branchname,
        "branch_address": branchaddress,
        "branch_latlong": branchlatlong,
        "branch_tel": branchtel,
        "branch_install_date": branchinstalldate,
        "branch_ma": branchMa,
        "branch_company": branchCompany
      });
      print('${MyConstant().urlBranchAdd} ${response.toString()}');
      if (response.toString() == 'ADD STATION SUCCESS') {
        Navigator.pop(context);
        Toast.show("เพิ่มสาขาสำเร็จ", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      } else {
        normalDialog(context, 'ไม่สามารถเพิ่มสาขาได้ กรุณราลองใหม่อีกครั้ง');
      }
    } catch (e) {
      normalDialog(context, e);
    }
  }
}
