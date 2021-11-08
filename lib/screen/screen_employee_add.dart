import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inapos/utility/dialog.dart';
import 'package:inapos/utility/my_constant.dart';
import 'package:inapos/utility/mystyle.dart';
import 'package:toast/toast.dart';

class ScreenEmpoyeeAdd extends StatefulWidget {
  @override
  _ScreenEmpoyeeAddState createState() => _ScreenEmpoyeeAddState();
}

class _ScreenEmpoyeeAddState extends State<ScreenEmpoyeeAdd> {
  String empcode,
      empdepartment,
      empsection,
      empposition,
      empname,
      emptel,
      empremark,
      empemail,
      empusername,
      emppassword;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'เพิ่มข้อมูลผู้ใช้งาน',
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
            empCode(),
            Mystyle().mySizeBox(),
            empDepartment(),
            Mystyle().mySizeBox(),
            empSection(),
            Mystyle().mySizeBox(),
            empPosition(),
            Mystyle().mySizeBox(),
            empName(),
            Mystyle().mySizeBox(),
            empTel(),
            Mystyle().mySizeBox(),
            empRemark(),
            Mystyle().mySizeBox(),
            empEmail(),
            Mystyle().mySizeBox(),
            empUsername(),
            Mystyle().mySizeBox(),
            empPassword(),
            Mystyle().mySizeBox(),
            btAdduser(),
            // backlogin()
          ],
        ),
      ),
    );
  }

  Widget btAdduser() => Container(
      height: 70,
      width: 400,
      child: ElevatedButton(
        onPressed: () {
          if (empcode == null ||
              empcode.isEmpty ||
              empdepartment == null ||
              empdepartment.isEmpty ||
              empsection == null ||
              empsection.isEmpty ||
              empname == null ||
              empname.isEmpty ||
              emptel == null ||
              emptel.isEmpty ||
              empremark == null ||
              empremark.isEmpty ||
              empemail == null ||
              empemail.isEmpty ||
              empusername == null ||
              empusername.isEmpty ||
              emppassword == null ||
              emppassword.isEmpty) {
            normalDialog(context, 'ข้อมูลไม่ครบ กรุณาลองใหม่อีกครั้ง');
          } else {
            checkUser();
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
  Future<Null> checkUser() async {
    String url = '${MyConstant().urlUserCheck}';
    try {
      await Dio().post(url, data: {'user': empusername}).then((value) {
        if (value.toString() == 'USE THIS USERNAME') {
          addUser();
          // clearTextInput();
          // normalDialog(context, 'Account successfully added');
          Navigator.pop(context);
          Toast.show("เพิ่มผู้ใช้งานสำเร็จ", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
          // normalDialog(context, 'เพิ่มผู้ใช้งาน สำเร็จ');
        } else {
          normalDialog(
              context, 'ชื่อผู้ใช้งานนี้มีในระบบแล้ว กรุณาลองใหม่อีกครั้ง');
        }
      });
    } catch (e) {
      normalDialog(context, e);
    }
  }

  Future<Null> addUser() async {
    String url = '${MyConstant().urlUserAdd}';
    try {
      Response response = await Dio().post(url, data: {
        "emp_code": empcode,
        "emp_Department": empdepartment,
        "emp_Section": empsection,
        "emp_Position": empposition,
        "emp_Name": empname,
        "emp_Tel": emptel,
        "emp_Remark": empremark,
        "emp_Email": empemail,
        "emp_Username": empusername,
        "emp_Password": emppassword
      });
      print('response = $response');
      if (response.toString() == 'ADD USER SUCCESS') {
        // normalDialog(context, 'Account successfully added');
      } else {
        normalDialog(
            context, 'ไม่สามารถเพิ่มผู้ใช้งานได้ กรุณราลองใหม่อีกครั้ง');
      }
    } catch (e) {
      normalDialog(context, e);
    }
  }

  Widget empCode() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top: 16.0),
            width: 400,
            child: TextFormField(
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  fontFamily: 'Sarabun'),
              onChanged: (value) => empcode = value.trim(),
              decoration: InputDecoration(
                labelText: 'รหัสพนักงาน :',
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
  Widget empDepartment() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top: 16.0),
            width: 400,
            child: TextFormField(
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  fontFamily: 'Sarabun'),
              onChanged: (value) => empdepartment = value.trim(),
              decoration: InputDecoration(
                labelText: 'แผนก :',
                prefixIcon: Icon(Icons.account_box),
                contentPadding:
                    new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ),
        ],
      );
  Widget empSection() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top: 16.0),
            width: 400,
            child: TextFormField(
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  fontFamily: 'Sarabun'),
              onChanged: (value) => empsection = value.trim(),
              decoration: InputDecoration(
                labelText: 'ประเภท :',
                prefixIcon: Icon(Icons.account_box),
                contentPadding:
                    new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ),
        ],
      );
  Widget empPosition() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top: 16.0),
            width: 400,
            child: TextFormField(
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  fontFamily: 'Sarabun'),
              onChanged: (value) => empposition = value.trim(),
              decoration: InputDecoration(
                labelText: 'สถานะ :',
                prefixIcon: Icon(Icons.add_moderator),
                contentPadding:
                    new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ),
        ],
      );
  Widget empName() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top: 16.0),
            width: 400,
            child: TextFormField(
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  fontFamily: 'Sarabun'),
              onChanged: (value) => empname = value.trim(),
              decoration: InputDecoration(
                labelText: 'ชื่อนามสกุล :',
                prefixIcon: Icon(Icons.account_box),
                contentPadding:
                    new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ),
        ],
      );
  Widget empTel() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top: 16.0),
            width: 400,
            child: TextFormField(
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  fontFamily: 'Sarabun'),
              onChanged: (value) => emptel = value.trim(),
              decoration: InputDecoration(
                labelText: 'เบอร์โทรศัพท์ :',
                prefixIcon: Icon(Icons.phone),
                contentPadding:
                    new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ),
        ],
      );
  Widget empRemark() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top: 16.0),
            width: 400,
            child: TextFormField(
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  fontFamily: 'Sarabun'),
              onChanged: (value) => empremark = value.trim(),
              decoration: InputDecoration(
                labelText: 'เบอร์โทรศัพท์ :',
                prefixIcon: Icon(Icons.phone),
                contentPadding:
                    new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ),
        ],
      );
  Widget empEmail() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top: 16.0),
            width: 400,
            child: TextFormField(
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  fontFamily: 'Sarabun'),
              onChanged: (value) => empemail = value.trim(),
              decoration: InputDecoration(
                labelText: 'อีเมล์ :',
                prefixIcon: Icon(Icons.email_outlined),
                contentPadding:
                    new EdgeInsets.symmetric(vertical: 25.0, horizontal: 40.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ),
        ],
      );
  Widget empUsername() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top: 16.0),
            width: 400,
            child: TextFormField(
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  fontFamily: 'Sarabun'),
              onChanged: (value) => empusername = value.trim(),
              decoration: InputDecoration(
                labelText: 'ชื่อผู้ใช้งาน :',
                prefixIcon: Icon(Icons.lock),
                contentPadding:
                    new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ),
        ],
      );
  Widget empPassword() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top: 16.0),
            width: 400,
            child: TextFormField(
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  fontFamily: 'Sarabun'),
              onChanged: (value) => emppassword = value.trim(),
              decoration: InputDecoration(
                labelText: 'รหัสผ่าน :',
                prefixIcon: Icon(Icons.lock),
                contentPadding:
                    new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ),
        ],
      );
}
