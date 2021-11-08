import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inapos/model/lading_model.dart';
import 'package:inapos/utility/dialog.dart';
import 'package:inapos/utility/my_constant.dart';
import 'package:inapos/utility/mystyle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenLadingEdit extends StatefulWidget {
  final LadingModel ladingModel;
  ScreenLadingEdit({Key key, this.ladingModel}) : super(key: key);
  @override
  _ScreenLadingEditState createState() => _ScreenLadingEditState();
}

class _ScreenLadingEditState extends State<ScreenLadingEdit> {
  LadingModel ladingModel;
  List<Map> myListDevice = [];
  String device;

  DateTime selectedDate = DateTime.now();
  bool status = true;
  bool loadstatus = true;

  String repairBranchname,
      repairDateopen,
      repairDevice,
      repairEmpname,
      serialdevice,
      empname,
      userName,
      repairInawork;
  Future<Null> readallrecieve() async {
    if (myListDevice.length != 0) {
      myListDevice.clear();
    }
    String url = '${MyConstant().urlGetItem}';
    await Dio().get(url).then((value) {
      setState(() {
        loadstatus = false;
      });
      print(value.toString());
      if (value.toString() != 'null') {
        for (var map in value.data) {
          setState(() {
            myListDevice.add(map);
            status = true;
          });
        }
      } else {
        setState(() {
          status = false;
        });
      }
    });
  }

  void initState() {
    super.initState();
    readallrecieve();
    findUser();
    ladingModel = widget.ladingModel;
    repairBranchname = ladingModel.repairBranchname;
    repairDateopen = ladingModel.repairDateopen;
    repairDevice = ladingModel.repairDevice;
    repairEmpname = ladingModel.repairEmpname;
    repairInawork = ladingModel.repairInawork;
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userName = preferences.getString('userName');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('งานเบิกใช้ ${ladingModel.repairInawork}'),
      ),
      body: SingleChildScrollView(
        // padding: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Column(
          children: [
            Mystyle().mySizeBox(),
            repairBranch(),
            Mystyle().mySizeBox(),
            repairDate(),
            Mystyle().mySizeBox(),
            repairEmp(),
            Mystyle().mySizeBox(),
            repairDevices(),
            Mystyle().mySizeBox(),
            allowdate(),
            Mystyle().mySizeBox(),
            listdevice(),
            Mystyle().mySizeBox(),
            serialdevices(),
            Mystyle().mySizeBox(),
            buttonSave(),
            buttonCancel()
          ],
        ),
      ),
    );
  }

  Widget repairBranch() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top: 16.0),
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextFormField(
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Sarabun',
                color: Colors.red.shade400,
              ),
              onChanged: (value) => repairBranchname = value.trim(),
              readOnly: true,
              initialValue: repairBranchname,
              decoration: InputDecoration(
                labelText: 'สาขา :',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                  borderSide: BorderSide(
                      style: BorderStyle.solid, color: Colors.grey, width: 3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                  borderSide: BorderSide(
                      style: BorderStyle.solid, color: Colors.grey, width: 3),
                ),
              ),
            ),
          ),
        ],
      );
  Widget repairDate() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top: 16.0),
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextFormField(
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Sarabun',
                color: Colors.red.shade400,
              ),
              onChanged: (value) => repairDateopen = value.trim(),
              readOnly: true,
              initialValue: repairDateopen,
              decoration: InputDecoration(
                labelText: 'วันที่เบิก :',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                  borderSide: BorderSide(
                      style: BorderStyle.solid, color: Colors.grey, width: 3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                  borderSide: BorderSide(
                      style: BorderStyle.solid, color: Colors.grey, width: 3),
                ),
              ),
            ),
          ),
        ],
      );
  Widget repairEmp() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top: 16.0),
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextFormField(
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Sarabun',
                color: Colors.red.shade400,
              ),
              onChanged: (value) => repairEmpname = value.trim(),
              readOnly: true,
              initialValue: repairEmpname,
              decoration: InputDecoration(
                labelText: 'ผู้ขอเบิก :',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                  borderSide: BorderSide(
                      style: BorderStyle.solid, color: Colors.grey, width: 3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                  borderSide: BorderSide(
                      style: BorderStyle.solid, color: Colors.grey, width: 3),
                ),
              ),
            ),
          ),
        ],
      );
  Widget repairDevices() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top: 16.0),
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextFormField(
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Sarabun',
                color: Colors.red.shade400,
              ),
              onChanged: (value) => repairDevice = value.trim(),
              readOnly: true,
              initialValue: repairDevice,
              decoration: InputDecoration(
                labelText: 'อุปกรณ์ที่ต้องการ :',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                  borderSide: BorderSide(
                      style: BorderStyle.solid, color: Colors.grey, width: 3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                  borderSide: BorderSide(
                      style: BorderStyle.solid, color: Colors.grey, width: 3),
                ),
              ),
            ),
          ),
        ],
      );
  Widget allowdate() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top: 16.0),
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextFormField(
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Sarabun',
                color: Colors.green.shade600,
              ),
              // onChanged: (value) => repairDevice = value.trim(),
              readOnly: true,
              initialValue: selectedDate.toString().split(' ')[0],
              decoration: InputDecoration(
                labelText: 'วันที่อนุมัติ :',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                  borderSide: BorderSide(
                      style: BorderStyle.solid, color: Colors.grey, width: 3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                  borderSide: BorderSide(
                      style: BorderStyle.solid, color: Colors.grey, width: 3),
                ),
              ),
            ),
          ),
        ],
      );
  Widget serialdevices() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top: 16.0),
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextFormField(
              maxLines: null,
              textAlignVertical: TextAlignVertical.bottom,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.green.shade600),
              onChanged: (value) => serialdevice = value.trim(),
              // initialValue: repairDetail,
              // readOnly: true,
              decoration: InputDecoration(
                labelText: 'S/N ของอุปกรณ์ :',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                  borderSide: BorderSide(
                      style: BorderStyle.solid, color: Colors.grey, width: 3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                  borderSide: BorderSide(
                      style: BorderStyle.solid, color: Colors.grey, width: 3),
                ),
              ),
            ),
          ),
        ],
      );
  Widget listdevice() => Container(
        // margin: EdgeInsets.only(top: 3),
        // color: Colors.blue,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
              style: BorderStyle.solid, color: Colors.grey, width: 3),
        ),
        child: Center(
          child: DropdownButton<String>(
            hint: new Text("รายการอุปกรณ์",
                style: TextStyle(fontFamily: 'Sarabun', fontSize: 20)),
            value: device,
            onChanged: (String newValue) {
              setState(() {
                device = newValue;
              });
            },
            items: myListDevice.map((Map map) {
              return new DropdownMenuItem<String>(
                value: map["stock_material"].toString(),
                child: Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        map["stock_material"],
                        style: TextStyle(
                            fontFamily: 'Sarabun',
                            fontSize: 20,
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
  Widget buttonSave() => Container(
        padding: EdgeInsets.only(top: 3),
        // height: 80,
        width: MediaQuery.of(context).size.width * 0.9,
        child: ElevatedButton.icon(
          onPressed: () {
            saVe();
          },
          icon: Icon(Icons.save_rounded),
          label: Text(
            'บันทึก',
            style: TextStyle(
                fontFamily: 'Sarabun',
                fontSize: 40,
                fontWeight: FontWeight.bold),
          ),
        ),
      );
  Widget buttonCancel() => Container(
        padding: EdgeInsets.only(top: 3),
        // height: 80,
        width: MediaQuery.of(context).size.width * 0.9,
        child: ElevatedButton.icon(
          onPressed: () {
            cancel();
          },
          icon: Icon(Icons.block_rounded),
          label: Text(
            'ยกเลิกใบงาน',
            style: TextStyle(
                fontFamily: 'Sarabun',
                fontSize: 40,
                fontWeight: FontWeight.bold),
          ),
        ),
      );
  Future<Null> saVe() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(
          'คุณต้องการบันทึกข้อมูล $repairInawork',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.blue.shade900,
            fontWeight: FontWeight.bold,
            fontFamily: 'Sarabun',
          ),
        ),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextButton.icon(
                icon: Icon(
                  Icons.check,
                  color: Colors.green,
                  size: 40,
                ),
                onPressed: () async {
                  String url = '${MyConstant().urlStockBillLadingEdit}';
                  await Dio().post(url, data: {
                    "id": ladingModel.id,
                    "repair_inawork": repairInawork,
                    "repair_stockcut_device": device,
                    "repair_stockcut_serail": serialdevice,
                    "repair_stockcut_status": "success",
                    "repair_stockcut_date":
                        selectedDate.toString().split(' ')[0],
                    "empname": userName
                  }).then(
                    (value) {
                      print(value.toString());
                      if (value.toString() == 'SUCCESS') {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      } else {
                        Navigator.pop(context);
                        normalDialog(
                            context, 'การกระทำไม่สำเร็จ กรุณาลองใหม่อีกครั้ง');
                      }
                    },
                  );
                },
                label: Text('ตกลง',
                    style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Sarabun',
                        fontWeight: FontWeight.bold)),
              ),
              TextButton.icon(
                icon: Icon(
                  Icons.close_outlined,
                  color: Colors.red,
                  size: 40,
                ),
                onPressed: () => Navigator.pop(context),
                label: Text('ยกเลิก',
                    style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Sarabun',
                        fontWeight: FontWeight.bold)),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<Null> cancel() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(
          'คุณต้องการยกเลิกใบงาน $repairInawork',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.blue.shade900,
            fontWeight: FontWeight.bold,
            fontFamily: 'Sarabun',
          ),
        ),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextButton.icon(
                icon: Icon(
                  Icons.check,
                  color: Colors.green,
                  size: 40,
                ),
                onPressed: () async {
                  String url = '${MyConstant().urlStockBillLadingCancel}';
                  await Dio().post(url, data: {
                    "id": ladingModel.id,
                    "repair_inawork": repairInawork,
                    "repair_stockcut_status": "cancel",
                    "empname": userName
                  }).then(
                    (value) {
                      print(value.toString());
                      if (value.toString() == 'SUCCESS') {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      } else {
                        Navigator.pop(context);
                        normalDialog(
                            context, 'การกระทำไม่สำเร็จ กรุณาลองใหม่อีกครั้ง');
                      }
                    },
                  );
                },
                label: Text('ตกลง',
                    style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Sarabun',
                        fontWeight: FontWeight.bold)),
              ),
              TextButton.icon(
                icon: Icon(
                  Icons.close_outlined,
                  color: Colors.red,
                  size: 40,
                ),
                onPressed: () => Navigator.pop(context),
                label: Text('ยกเลิก',
                    style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Sarabun',
                        fontWeight: FontWeight.bold)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
