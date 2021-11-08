import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inapos/model/job_model.dart';
import 'package:inapos/utility/dialog.dart';
import 'package:inapos/utility/my_constant.dart';
import 'package:inapos/utility/mystyle.dart';

class ScreenWorkOrderEdit extends StatefulWidget {
  final JobModel jobModel;
  ScreenWorkOrderEdit({Key key, this.jobModel}) : super(key: key);

  @override
  _ScreenWorkOrderEditState createState() => _ScreenWorkOrderEditState();
}

class _ScreenWorkOrderEditState extends State<ScreenWorkOrderEdit> {
  DateTime selectedDate = DateTime.now();
  final reDateClose = TextEditingController();
  List<Map> myListStatus = [
    {"id": '1', "name": "ส่งของแล้ว"},
    {"id": '2', "name": "แก้ไขแล้วรอของคืน"},
    {"id": '3', "name": "แจ้งเคลมแล้ว"},
    {"id": '4', "name": "จ่ายงานช่าง"},
    {"id": '5', "name": "ปิดงาน"}
  ];
  String selectedStatus;
  JobModel jobModel;
  int id;
  String repairOrderno;
  String repairOpen;
  String repairClose;
  String repairStatus;
  String branchName;
  String repairDevice;
  String repairSerialDevice;
  String repairWorkess;
  String repairTicketpt;
  String repairWarranty;
  String repairDetail;
  String repairDetailNew = "-";
  String repairEmp;
  void initState() {
    super.initState();
    jobModel = widget.jobModel;
    repairOrderno = jobModel.repairOrderno;
    repairOpen = jobModel.repairOpen;
    repairClose = jobModel.repairClose;
    repairStatus = jobModel.repairStatus;
    branchName = jobModel.branchName;
    repairDevice = jobModel.repairDevice;
    repairSerialDevice = jobModel.repairSerialDevice;
    repairWorkess = jobModel.repairWorkess;
    repairTicketpt = jobModel.repairTicketpt;
    repairWarranty = jobModel.repairWarranty;
    repairDetail = jobModel.repairDetail;
    repairEmp = jobModel.repairEmp;
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        reDateClose.text = selectedDate.toString().split(' ')[0];
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'แก้ไขข้อมูล ${jobModel.repairOrderno}',
          style: TextStyle(
            fontFamily: 'Sarabun',
            // fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        // padding: EdgeInsets.all(5),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Mystyle().mySizeBox(),
            Mystyle().mySizeBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Mystyle().mySizeBox(),
                workeditBranchCode(),
                Mystyle().mySizeBox(),
                workeditDateOpen(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                workeditWarranty(),
                Mystyle().mySizeBox(),
                workeditDevice(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                workeditDetailOld(),
              ],
            ),
            liststatusropdown(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // liststatusropdown(),
                workeditStatus(),
                Mystyle().mySizeBox(),
                date(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                workeditWorkEss(),
                Mystyle().mySizeBox(),
                workeditPtTicket(),
              ],
            ),
            workeditSerialNo(),
            workeditDetailNew(),
            Mystyle().mySizeBox(),
            workeditButtonSave(),
            Mystyle().mySizeBox(),
          ],
        ),
      ),
    );
  }

  Widget workeditBranchCode() => Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.45,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.bottom,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Sarabun',
                  fontSize: 20,
                  color: Colors.red.shade600),
              onChanged: (value) => branchName = value.trim(),
              initialValue: branchName,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'ชื่อสาขา :',
                labelStyle: TextStyle(fontFamily: 'Sarabun'),
                // contentPadding:
                //     new EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
              ),
            ),
          ),
        ],
      );
  Widget workeditDateOpen() => Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.bottom,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Sarabun',
                  fontSize: 20,
                  color: Colors.red.shade600),
              onChanged: (value) => repairOpen = value.trim(),
              initialValue: repairOpen,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'วันที่เปิดงาน :',
                labelStyle: TextStyle(fontFamily: 'Sarabun'),
                // prefixIcon: Icon(Icons.pending_outlined),
                // contentPadding:
                //     new EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
              ),
            ),
          ),
        ],
      );
  Widget workeditWarranty() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width * 0.45,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.bottom,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Sarabun',
                  fontSize: 20,
                  color: Colors.red.shade600),
              onChanged: (value) => repairWarranty = value.trim(),
              initialValue: repairWarranty,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'การรับประกัน :',
                labelStyle: TextStyle(fontFamily: 'Sarabun'),
                // prefixIcon: Icon(Icons.pending_outlined),
                // contentPadding:
                //     new EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
              ),
            ),
          ),
        ],
      );
  Widget workeditDevice() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width * 0.5,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.bottom,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Sarabun',
                  fontSize: 20,
                  color: Colors.red.shade600),
              onChanged: (value) => repairDevice = value.trim(),
              initialValue: repairDevice,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'อุปกรณ์ที่เสีย :',
                labelStyle: TextStyle(fontFamily: 'Sarabun'),
                // prefixIcon: Icon(Icons.pending_outlined),
                // contentPadding:
                //     new EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
              ),
            ),
          ),
        ],
      );
  Widget workeditDetailOld() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // height: 65,
            margin: EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width * 0.975,
            child: TextFormField(
              maxLines: null,
              textAlignVertical: TextAlignVertical.bottom,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Sarabun',
                  fontSize: 20,
                  color: Colors.red.shade600),
              onChanged: (value) => repairDetail = value.trim(),
              initialValue: repairDetail,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'รายละเอียดการแจ้งซ่อม :',
                labelStyle: TextStyle(fontFamily: 'Sarabun'),
                // prefixIcon: Icon(Icons.pending_outlined),
                // contentPadding:
                //     new EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
              ),
            ),
          ),
        ],
      );
  Widget liststatusropdown() => Container(
        height: 66,
        margin: EdgeInsets.only(top: 10),
        width: MediaQuery.of(context).size.width * 0.975,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
        alignment: Alignment.center,
        child: DropdownButton<String>(
          hint: new Text("สถานะใบงาน",
              style: TextStyle(
                fontFamily: 'Sarabun',
                fontSize: 20,
              )),
          value: selectedStatus,
          onChanged: (String newValue) {
            setState(() {
              selectedStatus = newValue;
            });
          },
          items: myListStatus.map((Map map) {
            return new DropdownMenuItem<String>(
              value: map["name"].toString(),
              child: Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      map["name"],
                      style: TextStyle(
                        fontFamily: 'Sarabun',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      );
  Widget date() => Stack(children: <Widget>[
        Container(
          height: 66,
          margin: EdgeInsets.only(top: 10),
          width: MediaQuery.of(context).size.width * 0.5,
          padding: EdgeInsets.all(1),
          // decoration: BoxDecoration(
          //   border: Border.all(color: Colors.grey),
          // ),
          child: Center(
            child: Text(
              '${selectedDate.toString().split(' ')[0]}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.green.shade600,
                fontFamily: 'Sarabun',
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: 68.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(1)),
              border: Border.all(color: Colors.grey, width: 1),
            ),
          ),
        ),
        Positioned(
          left: 10,
          bottom: 53,
          child: Container(
              width: 140,
              padding: EdgeInsets.only(left: 5),
              color: Colors.grey.shade50,
              child: Text('วันที่อัพเดทล่าสุด :',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontFamily: 'Sarabun',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ))),
        )
      ]);
  Widget workeditStatus() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width * 0.45,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.bottom,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.red.shade600,
                  fontFamily: 'Sarabun'),
              onChanged: (value) => repairStatus = value.trim(),
              initialValue: repairStatus,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'สถานะใบงานล่าสุด :',
                labelStyle: TextStyle(fontFamily: 'Sarabun'),
                // prefixIcon: Icon(Icons.pending_outlined),
                // contentPadding:
                //     new EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
              ),
            ),
          ),
        ],
      );

  Widget workeditWorkEss() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width * 0.45,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.bottom,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.green.shade600),
              onChanged: (value) => repairWorkess = value.trim(),
              initialValue: repairWorkess,
              // readOnly: true,
              decoration: InputDecoration(
                labelText: 'Work Ess :',
                // prefixIcon: Icon(Icons.pending_outlined),
                // contentPadding:
                //     new EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
              ),
            ),
          ),
        ],
      );
  Widget workeditPtTicket() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width * 0.5,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.bottom,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.green.shade600),
              onChanged: (value) => repairTicketpt = value.trim(),
              initialValue: repairTicketpt,
              // readOnly: true,
              decoration: InputDecoration(
                labelText: 'SVD Ticket :',
                labelStyle: TextStyle(fontFamily: 'Sarabun'),
                // prefixIcon: Icon(Icons.pending_outlined),
                // contentPadding:
                //     new EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
              ),
            ),
          ),
        ],
      );
  Widget workeditSerialNo() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Mystyle().mySizeBox(),
          Container(
            margin: EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width * 0.975,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.bottom,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.green.shade600),
              onChanged: (value) => repairSerialDevice = value.trim(),
              initialValue: repairSerialDevice,
              // readOnly: true,
              decoration: InputDecoration(
                labelText: 'Serial No :',
                labelStyle: TextStyle(
                  fontFamily: 'Sarabun',
                ),
                // prefixIcon: Icon(Icons.pending_outlined),
                // contentPadding:
                //     new EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
              ),
            ),
          ),
        ],
      );

  Widget workeditDetailNew() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Mystyle().mySizeBox(),
          Container(
            margin: EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width * 0.975,
            child: TextFormField(
              maxLines: null,
              textAlignVertical: TextAlignVertical.bottom,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Sarabun',
                  fontSize: 20,
                  color: Colors.green.shade600),
              onChanged: (value) => repairDetailNew = value.trim(),
              // initialValue: repairDetail,
              // readOnly: true,
              decoration: InputDecoration(
                labelText: 'รายละเอียดเพิ่มเติม :',
                labelStyle: TextStyle(fontFamily: 'Sarabun'),
                // prefixIcon: Icon(Icons.pending_outlined),
                // contentPadding:
                //     new EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
              ),
            ),
          ),
        ],
      );
  Widget workeditButtonSave() => Container(
        // height: 80,
        width: MediaQuery.of(context).size.width * 0.5,
        child: FloatingActionButton.extended(
          heroTag: 'workeditButtonSave',
          // icon: Icon(Icons.),
          onPressed: () {
            workUpdate();
          },
          label: Text(
            'อัพเดทใบงาน',
            style: TextStyle(
                fontFamily: 'Sarabun',
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
      );
  Future<Null> workUpdate() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Mystyle().showTitleH2('คุณต้องการอัพเดทสถานะใบงานใช่หรือไม่'),
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
                  String url = '${MyConstant().urlJobEdit}';
                  await Dio().post(url, data: {
                    "repair_orderno": jobModel.repairOrderno,
                    "repair_update": selectedDate.toString().split(' ')[0],
                    "repair_serial_device": jobModel.repairSerialDevice,
                    "repair_status": selectedStatus,
                    "repair_workess": jobModel.repairWorkess,
                    "repair_ticketpt": jobModel.repairTicketpt,
                    "repair_detail":
                        jobModel.repairDetail + " | " + repairDetailNew
                  }).then(
                    (value) {
                      if (value.toString() == 'UPDATE JOB SUCCESS') {
                        print('UPDATE JOB SUCCESS');
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
