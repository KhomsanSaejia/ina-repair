// import 'dart:convert';

// import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inapos/model/report_model.dart';
import 'package:inapos/utility/dialog.dart';
import 'package:inapos/utility/my_constant.dart';
import 'package:inapos/utility/mystyle.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as excel;
import 'package:universal_html/html.dart' show AnchorElement;
import 'package:flutter/foundation.dart' show kIsWeb;

class ScreenHistoryWork2 extends StatefulWidget {
  // const ScreenHistoryWork2({ Key? key }) : super(key: key);

  @override
  _ScreenHistoryWork2State createState() => _ScreenHistoryWork2State();
}

class _ScreenHistoryWork2State extends State<ScreenHistoryWork2> {
  TextEditingController controller = new TextEditingController();
  bool status = true;
  bool loadstatus = true;
  List<ReportRepair> reportRepairs = [];
  List _listBranch = [];
  String _selectedBranch, _typeWork;
  DateTimeRange dateRange;
  List _dateStartStop = [];
  List<Map> myListType = [
    {"id": '1', "name": "งาน ซ่อม"},
    {"id": '2', "name": "งาน PM"},
    // {"id": '3', "name": "อื่นๆ"}
  ];
  int count = 2;

  Future<Null> readHistory(
      String stationName, String typeWork, List dateRange) async {
    if (reportRepairs.length != 0) {
      setState(() {
        reportRepairs.clear();
      });
    }
    String url;
    if (dateRange.length == 0) {
      url =
          '${MyConstant().urlHistory}3?branch_name=$stationName&typeWork=$typeWork&dateStart=&dateStop=';
    } else {
      if (stationName != null) {
        url =
            '${MyConstant().urlHistory}3?branch_name=$stationName&typeWork=$typeWork&dateStart=${dateRange[0]}&dateStop=${dateRange[1]}';
      } else {
        url =
            '${MyConstant().urlHistory}3?branch_name=&typeWork=$typeWork&dateStart=${dateRange[0]}&dateStop=${dateRange[1]}';
      }
    }

    print(url);
    print("* * * * * * * * * * * * * * * * * * * * * *");
    await Dio().get(url).then((value) {
      if (value.toString() != 'null') {
        for (var map in value.data) {
          ReportRepair reportRepair = ReportRepair.fromJson(map);
          setState(() {
            reportRepairs.add(reportRepair);
            // status = true;
          });
        }
      } else {
        // setState(() {
        //   status = false;
        // });
      }
    });
  }

  Widget listContractor() => Container(
        margin: EdgeInsets.only(top: 3),
        height: 61,
        width: MediaQuery.of(context).size.width * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(style: BorderStyle.solid, color: Colors.grey),
        ),
        child: Center(
          child: DropdownButton<String>(
            hint: new Text("เลือกประเภท",
                style: TextStyle(fontFamily: 'Sarabun', fontSize: 20)),
            value: _typeWork,
            onChanged: (String newValue) {
              setState(() {
                _typeWork = newValue;
                print('typeWork = $_typeWork');
              });
            },
            items: myListType.map((Map map) {
              return new DropdownMenuItem<String>(
                value: map["name"].toString(),
                child: Row(
                  children: <Widget>[
                    Container(
                      // width: MediaQuery.of(context).size.width * 0.3,
                      child: Text(
                        map["name"],
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

  Future pickDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().add(Duration(hours: 24 * 3)),
    );
    final newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: dateRange ?? initialDateRange,
    );

    if (newDateRange == null) return;

    setState(() {
      _dateStartStop.clear();
      dateRange = newDateRange;
      String _start = dateRange.toString().split(" - ")[0];
      String _stop = dateRange.toString().split(" - ")[1];
      _dateStartStop.add(_start.split(" ")[0]);
      _dateStartStop.add(_stop.split(" ")[0]);
      print(_dateStartStop);
    });
  }

  Future<Null> readallbranch() async {
    if (_listBranch.length != 0) {
      _listBranch.clear();
    }
    print('status = $status');
    String url = '${MyConstant().urlBranchList}';
    await Dio().get(url).then((value) {
      setState(() {
        loadstatus = false;
      });
      if (value.toString() != 'null') {
        for (var map in value.data) {
          setState(() {
            _listBranch.add(map);
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

  @override
  void initState() {
    super.initState();
    readallbranch();
    // var bytes = utf8.encode("foobar"); // data being hashed
    // var digest = sha1.convert(bytes);
    // print("Digest as bytes: ${digest.bytes}");
    // print("Digest as hex string: $digest");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width * 1,
        color: Colors.grey.shade200,
        child: Column(
          children: <Widget>[
            bodyMenu(),
            loadstatus ? Mystyle().showprogress() : Expanded(child: bodyData())
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_dateStartStop.length == 0 && _selectedBranch == null) {
            normalDialog(context, "กรุณาค้นหาข้อมูลก่อนออกรายงาน");
          } else {
            createExcelAll();
          }
        },
        child: Icon(Icons.print),
      ),
    );
  }

  Widget bodyData() {
    return reportRepairs.length == 0
        ? Center(
            child: Mystyle().textCustom("ยังไม่มีข้อมูล", 30, Colors.red),
          )
        : SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              showCheckboxColumn: false,
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    'ชื่อสาขา',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontFamily: 'Sarabun',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'เลขที่ใบงาน',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontFamily: 'Sarabun',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'อุปกรณ์',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontFamily: 'Sarabun',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'วันที่เปิดงาน',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontFamily: 'Sarabun',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'วันที่ปิดงาน',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontFamily: 'Sarabun',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'S/N',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontFamily: 'Sarabun',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Work ESS',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontFamily: 'Sarabun',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'จำนวน',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontFamily: 'Sarabun',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'ประกัน',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontFamily: 'Sarabun',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'ระบบ',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontFamily: 'Sarabun',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'บริษัท',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontFamily: 'Sarabun',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'วันที่ติดตั้ง',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontFamily: 'Sarabun',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
              rows: reportRepairs
                  .map((reportRepair) => DataRow(cells: [
                        DataCell(dataCell(reportRepair.branchName)),
                        DataCell(dataCell(reportRepair.repairOrderno)),
                        DataCell(dataCell(reportRepair.repairDevice)),
                        DataCell(dataCell(reportRepair.repairOpen)),
                        DataCell(dataCell(reportRepair.repairClose)),
                        DataCell(dataCell(reportRepair.repairSerialDevice)),
                        DataCell(dataCell(reportRepair.repairWorkess)),
                        DataCell(dataCell("1")),
                        DataCell(dataCell(reportRepair.repairWarranty)),
                        DataCell(dataCell(reportRepair.branchMa)),
                        DataCell(dataCell(reportRepair.branchCompany)),
                        DataCell(dataCell(reportRepair.branchInstallDate)),
                      ]))
                  .toList(),
            ),
          );
  }

  Widget dataCell(String data) {
    return Container(
      // width: MediaQuery.of(context).size.width * 0.2,
      child: Text(
        data,
        style: TextStyle(
          color: Colors.blue.shade400,
          fontSize: 13,
          fontFamily: 'Sarabun',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget bodyMenu() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Mystyle().sarabunTitle("เลือกสาขา"),
          Mystyle().mySizeBox(),
          Container(
            margin: EdgeInsets.only(top: 3),
            width: MediaQuery.of(context).size.width * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(style: BorderStyle.solid, color: Colors.grey),
            ),
            child: Container(
              padding: EdgeInsets.all(5),
              child: Autocomplete(
                optionsBuilder: (TextEditingValue value) {
                  if (value.text.isEmpty) {
                    return [];
                  }
                  return _listBranch.where((suggestion) => suggestion
                      .toLowerCase()
                      .contains(value.text.toLowerCase()));
                },
                fieldViewBuilder: (BuildContext context,
                    TextEditingController controller,
                    FocusNode fieldFocusNode,
                    VoidCallback onFieldSubmitted) {
                  return Center(
                    child: TextField(
                      controller: controller,
                      focusNode: fieldFocusNode,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Sarabun",
                          fontSize: 20),
                    ),
                  );
                },
                onSelected: (value) {
                  setState(() {
                    _selectedBranch = value;
                    print('selectedBranch = $_selectedBranch');
                  });
                },
              ),
            ),
          ),
          Mystyle().mySizeBox(),
          Container(
            // color: Colors.grey,
            margin: EdgeInsets.only(top: 3),
            height: 61,
            width: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(style: BorderStyle.solid, color: Colors.grey),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton.small(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  onPressed: () => pickDateRange(context),
                  child: Icon(Icons.date_range),
                ),
                Mystyle().mySizeBox(),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: _dateStartStop.isEmpty
                      ? Center(
                          child: Mystyle().textCustom(
                              "กรุณาเลือกวันที่", 20.0, Colors.black),
                        )
                      : Center(
                          child: Mystyle().textCustom(
                              "วันที่เริ่ม : ${_dateStartStop[0]} , วันที่สิ้นสุด : ${_dateStartStop[1]}",
                              20.0,
                              Colors.black),
                        ),
                ),
              ],
            ),
          ),
          Mystyle().mySizeBox(),
          listContractor(),
          Mystyle().mySizeBox(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(200, 61),
            ),
            onPressed: () {
              print(_selectedBranch);
              print(_dateStartStop);
              print(_typeWork);
              // print("* * * * * * * * * * * * * * * * * * * * * * * ");
              if (_selectedBranch == null &&
                  _dateStartStop.length == 0 &&
                  _typeWork == null) {
                normalDialog(context, "กรุณาป้อนข้อมูลที่ต้องการเลือก");
              } else if (_selectedBranch != null &&
                  _dateStartStop.length == 0 &&
                  _typeWork == null) {
                normalDialog(context, "กรุณาเลือกประเภทงาน");
              } else if (_selectedBranch != null &&
                  _dateStartStop.length != 0 &&
                  _typeWork == null) {
                normalDialog(context, "กรุณาเลือกประเภทงาน");
              } else if (_selectedBranch != null &&
                  _dateStartStop.length == 0 &&
                  _typeWork != null) {
                readHistory(_selectedBranch, _typeWork, _dateStartStop);
              } else if (_selectedBranch != null &&
                  _dateStartStop.length != 0 &&
                  _typeWork != null) {
                readHistory(_selectedBranch, _typeWork, _dateStartStop);
              } else if (_selectedBranch == null &&
                  _dateStartStop.length != 0 &&
                  _typeWork != null) {
                readHistory(_selectedBranch, _typeWork, _dateStartStop);
              }
            },
            child: Mystyle().textCustom("ค้นหา", 23.0, Colors.white),
          )
        ],
      ),
    );
  }

  Future<void> createExcelAll() async {
    final excel.Workbook workbook = excel.Workbook();
    final excel.Worksheet sheet = workbook.worksheets[0];

    sheet.getRangeByName('A1').columnWidth = 11;
    sheet.getRangeByName('B1').columnWidth = 25;
    sheet.getRangeByName('C1').columnWidth = 20;
    sheet.getRangeByName('D1').columnWidth = 19;
    sheet.getRangeByName('E1:F1').columnWidth = 11;
    sheet.getRangeByName('G1').columnWidth = 14;
    sheet.getRangeByName('H1').columnWidth = 6;
    sheet.getRangeByName('I1').columnWidth = 11;
    sheet.getRangeByName('J1:M1').columnWidth = 11;

    sheet.getRangeByName('A1').text = 'ลำดับ';
    sheet.getRangeByName('B1').text = 'ชื่อสาขา';
    sheet.getRangeByName('C1').text = 'หมายเลขใบงาน';
    sheet.getRangeByName('D1').text = 'อุปกรณ์';
    sheet.getRangeByName('E1').text = 'วันที่เปิดงาน';
    sheet.getRangeByName('F1').text = 'วันที่ปิดงาน';
    sheet.getRangeByName('G1').text = 'เลข S/N';
    sheet.getRangeByName('H1').text = 'จำนวน';
    sheet.getRangeByName('I1').text = 'Ess';
    sheet.getRangeByName('J1').text = 'ประกัน';
    sheet.getRangeByName('K1').text = 'ประเภท';
    sheet.getRangeByName('L1').text = 'ลูกค้า';
    sheet.getRangeByName('M1').text = 'วันที่ติดตั้ง';

    for (var item in reportRepairs) {
      sheet.getRangeByName('A$count').setText((count - 1).toString());
      sheet.getRangeByName('B$count').setText(item.branchName);
      sheet.getRangeByName('C$count').setText(item.repairOrderno);
      sheet.getRangeByName('D$count').setText(item.repairDevice);
      sheet.getRangeByName('E$count').setText(item.repairOpen);
      sheet.getRangeByName('F$count').setText(item.repairClose);
      sheet.getRangeByName('G$count').setText(item.repairSerialDevice);
      sheet.getRangeByName('H$count').setText("1");
      sheet.getRangeByName('I$count').setText(item.repairWorkess);
      sheet.getRangeByName('J$count').setText(item.repairWarranty);
      sheet.getRangeByName('K$count').setText(item.branchMa);
      sheet.getRangeByName('L$count').setText(item.branchCompany);
      sheet.getRangeByName('M$count').setText(item.branchInstallDate);

      setState(() {
        count = count + 1;
      });
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    if (kIsWeb) {
      AnchorElement(
          href:
              'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
        ..setAttribute('download',
            'ราย$_typeWork ประจำวันที่ ${_dateStartStop[0]} ถึง ${_dateStartStop[1]}.xlsx')
        ..click();
    }
  }
}
