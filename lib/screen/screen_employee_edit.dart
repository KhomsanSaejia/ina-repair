import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inapos/model/user_add_model.dart';
import 'package:inapos/utility/dialog.dart';
import 'package:inapos/utility/my_constant.dart';
import 'package:inapos/utility/mystyle.dart';

class ScreenEmployeeEdit extends StatefulWidget {
  final UseraddModel useraddModel;
  ScreenEmployeeEdit({Key key, this.useraddModel}) : super(key: key);
  @override
  _ScreenEmployeeEditState createState() => _ScreenEmployeeEditState();
}

class _ScreenEmployeeEditState extends State<ScreenEmployeeEdit> {
  UseraddModel useraddModel;
  String empcode,
      empdepartment,
      empsection,
      empposition,
      empname,
      emptel,
      empremark,
      empemail,
      emppassword;
  void initState() {
    super.initState();
    useraddModel = widget.useraddModel;
    empcode = useraddModel.empCode;
    empdepartment = useraddModel.empDepartment;
    empsection = useraddModel.empSection;
    empposition = useraddModel.empPosition;
    empname = useraddModel.empName;
    emptel = useraddModel.empTel;
    empremark = useraddModel.empRemark;
    empemail = useraddModel.empEmail;
    emppassword = useraddModel.empPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขข้อมูล ${useraddModel.empName}'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Column(
          children: [
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
            empPassword(),
            Mystyle().mySizeBox(),
            btEditUser(),
          ],
        ),
      ),
    );
  }

  Widget empCode() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top: 16.0),
            // width: 350,
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextFormField(
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.grey.shade600),
              onChanged: (value) => empcode = value.trim(),
              initialValue: empcode,
              readOnly: true,
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
            // width: 350,
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextFormField(
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'Sarabun',
                  color: Colors.green.shade600),
              onChanged: (value) => empdepartment = value.trim(),
              initialValue: empdepartment,
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
            // width: 350,
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextFormField(
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'Sarabun',
                  color: Colors.green.shade600),
              onChanged: (value) => empsection = value.trim(),
              initialValue: empsection,
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
            // width: 350,
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextFormField(
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'Sarabun',
                  color: Colors.green.shade600),
              onChanged: (value) => empposition = value.trim(),
              initialValue: empposition,
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
            // width: 350,
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextFormField(
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'Sarabun',
                  color: Colors.green.shade600),
              onChanged: (value) => empname = value.trim(),
              initialValue: empname,
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
            // width: 350,
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextFormField(
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'Sarabun',
                  color: Colors.green.shade600),
              onChanged: (value) => emptel = value.trim(),
              initialValue: emptel,
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
            // width: 350,
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextFormField(
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'Sarabun',
                  color: Colors.green.shade600),
              onChanged: (value) => empremark = value.trim(),
              initialValue: empremark,
              decoration: InputDecoration(
                labelText: 'เบอร์โทรศัพท์ออฟฟิศ :',
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
            // width: 350,
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextFormField(
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'Sarabun',
                  color: Colors.green.shade600),
              onChanged: (value) => empemail = value.trim(),
              initialValue: empemail,
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
  Widget empPassword() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top: 16.0),
            // width: 350,
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextFormField(
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'Sarabun',
                  color: Colors.green.shade600),
              onChanged: (value) => emppassword = value.trim(),
              initialValue: emppassword,
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
  Widget btEditUser() => Container(
      height: 80,
      // width: 350.0,
      width: MediaQuery.of(context).size.width * 0.9,
      child: ElevatedButton(
        // onPressed: null,
        // color: Mystyle().darkcolor,
        onPressed: () {
          if (empcode.isEmpty ||
              empdepartment.isEmpty ||
              empsection.isEmpty ||
              empposition.isEmpty ||
              empname.isEmpty ||
              emptel.isEmpty ||
              empremark.isEmpty ||
              empemail.isEmpty ||
              emppassword.isEmpty) {
            normalDialog(context, 'Missing information, please check again.');
          } else {
            editUser();
          }
        },
        child: Text(
          'แก้ไขข้อมูลพนักงาน',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
            fontFamily: 'Sarabun',
          ),
        ),
      ));

  Future<Null> editUser() async {
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
                  String url = '${MyConstant().urlUserEdit}';
                  await Dio().post(url, data: {
                    "emp_id": useraddModel.empId,
                    "emp_code": empcode,
                    "emp_Department": empdepartment,
                    "emp_Section": empsection,
                    "emp_Position": empposition,
                    "emp_Name": empname,
                    "emp_Tel": emptel,
                    "emp_Remark": empremark,
                    "emp_Email": empemail,
                    "emp_Password": emppassword
                  }).then(
                    (value) {
                      if (value.toString() ==
                          '{"status":"edit user success"}') {
                        print('UPDATE USER SUCCESS');
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
