import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inapos/model/in_out_model.dart';
import 'package:inapos/model/user_add_model.dart';
import 'package:inapos/utility/my_constant.dart';
import 'package:inapos/utility/mystyle.dart';
import 'package:flutter_speed_dial_material_design/flutter_speed_dial_material_design.dart';
// import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as excel;
import 'package:universal_html/html.dart' show AnchorElement;
import 'package:flutter/foundation.dart' show kIsWeb;

class ScreenInOutPatui extends StatefulWidget {
  // const ScreenInOutPatui({ Key? key }) : super(key: key);

  @override
  _ScreenInOutPatuiState createState() => _ScreenInOutPatuiState();
}

class _ScreenInOutPatuiState extends State<ScreenInOutPatui> {
  bool status = true;
  bool loadstatus = true;
  List<InOutModel> inOutModels = [];
  List<InOutModel> inOutModelAlls = [];

  UseraddModel useraddModel;
  List<Map> myListuseraddModel = [];

  String selectEmp, valIntime, valRef, valOuttime, valOvertime;
  TextEditingController _valRef = TextEditingController();
  TextEditingController _valIntime = TextEditingController();
  TextEditingController _valOuttime = TextEditingController();
  TextEditingController _valOvertime = TextEditingController();

  DateTime selectedDateStart = DateTime.now();
  DateTime selectedDateStop = DateTime.now();

  int count = 12;

  @override
  void initState() {
    super.initState();
    readalluser();
  }

  Future<Null> readalluser() async {
    if (myListuseraddModel.length != 0) {
      myListuseraddModel.clear();
    }
    String url = '${MyConstant().urlUserRead}';
    await Dio().get(url).then((value) {
      setState(() {
        loadstatus = false;
      });
      if (value.toString() != 'null') {
        for (var map in value.data) {
          setState(() {
            myListuseraddModel.add(map);
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

  Future<Null> readInOutTime(
      String emp, DateTime statrDate, DateTime stopDate) async {
    if (inOutModels.length != 0) {
      inOutModels.clear();
    }
    String url =
        '${MyConstant().urlInOutDetail}?emp_id=$emp&f_date=${statrDate.toString().split(' ')[0]}&l_date=${stopDate.toString().split(' ')[0]}';
    await Dio().get(url).then((value) {
      setState(() {
        loadstatus = false;
      });
      if (value.toString() != 'null') {
        for (var map in value.data) {
          InOutModel inOutModel = InOutModel.fromJson(map);
          print(
              '${inOutModel.empId} ${inOutModel.empName} ${inOutModel.inDate}');

          setState(() {
            inOutModels.add(inOutModel);
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

  Future<Null> readInOutTimeAll(
      String emp, DateTime statrDate, DateTime stopDate) async {
    if (inOutModelAlls.length != 0 || inOutModelAlls.isNotEmpty) {
      inOutModelAlls.clear();
    }
    String url =
        '${MyConstant().urlInOutDetail}?emp_id=$emp&f_date=${statrDate.toString().split(' ')[0]}&l_date=${stopDate.toString().split(' ')[0]}';
    await Dio().get(url).then((value) {
      if (value.toString() != 'null') {
        for (var map in value.data) {
          InOutModel inOutModel = InOutModel.fromJson(map);
          setState(() {
            inOutModelAlls.add(inOutModel);
          });
        }
        createExcelAll(inOutModelAlls);
        setState(() {
          count = 12;
          inOutModelAlls.clear();
        });
      } else {
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // initializeDateFormatting('th', _valOuttime.text);
    // Intl.defaultLocale = 'th';
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width * 1,
        color: Colors.grey.shade200,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              width: MediaQuery.of(context).size.width * 0.2,
              color: Colors.grey.shade400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text('${reformatDate("2021-11-16")}'),
                  seleceDateStart(),
                  seleceDateStop(),
                  selectedEmp(),
                  Mystyle().mySizeBox(),
                  searchData(),
                  // bodyMenu(),
                  // _inserDataQuota
                  //     ? insertProductButton()
                  //     : updateProductButton(),
                ],
              ),
            ),
            bodyTable(),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      // bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildFloatingActionButton() {
    final TextStyle customStyle =
        TextStyle(inherit: false, color: Colors.black);
    final icons = [
      SpeedDialAction(
          // backgroundColor: Colors.green,
          // foregroundColor: Colors.yellow,
          child: Icon(Icons.person_sharp),
          label: Text('ออกรายงาน พนักงานที่เลือก', style: customStyle)),
      SpeedDialAction(
          child: Icon(Icons.people),
          label: Text('ออกรายงาน พนักงานทุกคน', style: customStyle)),
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SpeedDialFloatingActionButton(
        actions: icons,
        childOnFold: Icon(Icons.event_note, key: UniqueKey()),
        screenColor: Colors.black.withOpacity(0.3),
        //childOnUnfold: Icon(Icons.add),
        useRotateAnimation: false,
        onAction: _onSpeedDialAction,
        // controller: _controller,
        isDismissible: true,
        //backgroundColor: Colors.yellow,
        //foregroundColor: Colors.blue,
      ),
    );
  }

  _onSpeedDialAction(int selectedActionIndex) {
    if (selectedActionIndex == 0) {
      createExcelAll(inOutModels);
      setState(() {
        count = 12;
      });
    } else {
      for (var item in myListuseraddModel) {
        readInOutTimeAll(item['emp_code'], selectedDateStart, selectedDateStop);
      }
    }
  }

  Widget textBoxCustom(
      TextEditingController textEditingController, String data, String header) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Mystyle().textHeader(header),
        Mystyle().mySizeBox(),
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromRGBO(143, 148, 251, .2),
                    blurRadius: 20.0,
                    offset: Offset(0, 10))
              ]),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.2,
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: textEditingController,
              style: const TextStyle(
                  fontFamily: "Sarabun",
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              onChanged: (value) {
                setState(() {
                  data = value.trim();
                  data = textEditingController.text;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget seleceDateStart() {
    return Container(
      // color: Colors.grey.shade100,
      width: MediaQuery.of(context).size.width * 0.5,
      height: 70,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "วันที่เริ่มต้น",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              // color: Colors.green.shade600,
              fontFamily: 'Sarabun',
            ),
          ),
          Mystyle().mySizeBox(),
          date(selectedDateStart),
          IconButton(
              onPressed: () {
                showDatePicker(
                        context: context,
                        initialDate: selectedDateStart == null
                            ? DateTime.now()
                            : selectedDateStart,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now())
                    .then((date) {
                  setState(() {
                    selectedDateStart = date;
                  });
                });
              },
              icon: Icon(
                Icons.date_range,
                color: Colors.green,
              )),
        ],
      ),
    );
  }

  Widget seleceDateStop() {
    return Container(
      // color: Colors.grey.shade100,
      width: MediaQuery.of(context).size.width * 0.5,
      height: 70,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "วันที่สิ้นสุด",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              // color: Colors.green.shade600,
              fontFamily: 'Sarabun',
            ),
          ),
          Mystyle().mySizeBox(),
          date(selectedDateStop),
          IconButton(
              onPressed: () {
                showDatePicker(
                        context: context,
                        initialDate: selectedDateStop == null
                            ? DateTime.now()
                            : selectedDateStop,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now())
                    .then((date) {
                  setState(() {
                    selectedDateStop = date;
                  });
                });
              },
              icon: Icon(
                Icons.date_range,
                color: Colors.red,
              )),
        ],
      ),
    );
  }

  Widget date(DateTime dateTime) {
    return Stack(children: <Widget>[
      Container(
        height: 35,
        width: 150,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(3)),
        child: Center(
          child: Text(
            '${dateTime.toString().split(' ')[0]}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              // color: Colors.green.shade600,
              fontFamily: 'Sarabun',
            ),
          ),
        ),
      ),
    ]);
  }

  Widget selectedEmp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromRGBO(143, 148, 251, .2),
                    blurRadius: 20.0,
                    offset: Offset(0, 10))
              ]),
          child: Container(
            height: 65,
            // width: MediaQuery.of(context).size.width * 0.2,
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              hint: Mystyle().textHeader("เลือกพนักงาน"),
              value: selectEmp,
              isDense: true,
              onChanged: (String newValue) {
                setState(() {
                  selectEmp = newValue;
                });
              },
              items: myListuseraddModel.map((Map map) {
                return new DropdownMenuItem<String>(
                  value: map["emp_code"].toString(),
                  child: Row(
                    children: <Widget>[
                      Container(
                        // width: MediaQuery.of(context).size.width * 0.1,
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          map["emp_Name"] + " ",
                          style: TextStyle(
                              fontFamily: 'Sarabun',
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget searchData() {
    var w = MediaQuery.of(context).size.width * 0.1;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(w, 50.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        primary: Colors.orange.shade200,
        elevation: 20,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      ),
      onPressed: () {
        readInOutTime(selectEmp, selectedDateStart, selectedDateStop);
      },
      child: Mystyle().textCustom("ค้นหา", 20.0, Colors.white),
    );
  }

  Widget bodyTable() => Container(
        width: MediaQuery.of(context).size.width * 0.8,
        // color: Colors.green.shade200,
        child: inOutModels.isEmpty
            ? Center(
                child: Mystyle().showTitleCustom("ไม่มีข้อมูล"),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  showCheckboxColumn: false,
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        'วันที่',
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
                        'เวลาเข้างาน',
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
                        'เวลาออกงาน',
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
                        'O.T',
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
                        'หมายเหตุ',
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
                        'ชื่อ - นามสกุล',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                          fontFamily: 'Sarabun',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                  rows: inOutModels
                      .map(
                        (inOutModel) => DataRow(
                          onSelectChanged: (newValue) {
                            _valRef.text = inOutModel.referrence.toString();
                            _valIntime.text = inOutModel.inTime.toString();
                            _valOuttime.text = inOutModel.outTime.toString();
                            _valOvertime.text = inOutModel.overTime.toString();
                            showDialog(
                              context: context,
                              builder: (context) => SimpleDialog(
                                title: Center(
                                  child: Column(
                                    children: [
                                      Mystyle().textHeader("แก้ไข"),
                                      textBoxCustom(
                                          _valIntime, valIntime, "เวลาเข้างาน"),
                                      Mystyle().mySizeBox(),
                                      textBoxCustom(_valOuttime, valOuttime,
                                          "เวลาออกงาน"),
                                      Mystyle().mySizeBox(),
                                      textBoxCustom(
                                          _valOvertime, valOvertime, "โอที"),
                                      Mystyle().mySizeBox(),
                                      textBoxCustom(
                                          _valRef, valRef, "หมายเหตุ"),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          TextButton(
                                            onPressed: () async {
                                              String url =
                                                  '${MyConstant().urlInOutEdit}';
                                              await Dio().put(url, data: {
                                                "emp_id": inOutModel.empId,
                                                "in_date": inOutModel.inDate,
                                                "in_time": _valIntime.text,
                                                "out_time": _valOuttime.text,
                                                "over_time": _valOvertime.text,
                                                "referrence": _valRef.text
                                              }).then(
                                                (value) {
                                                  if (value.toString() ==
                                                      'SUCCESS') {
                                                    Navigator.pop(context);
                                                  } else {
                                                    Navigator.pop(context);
                                                  }
                                                  // readInOutTime();
                                                  readInOutTime(
                                                      selectEmp,
                                                      selectedDateStart,
                                                      selectedDateStop);
                                                },
                                              );
                                            },
                                            child: Text(
                                              'บันทึก',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.green),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text(
                                              'ยกเลิก',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.red),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          cells: [
                            DataCell(
                              Container(
                                width: MediaQuery.of(context).size.width * 0.1,
                                // child: (() {
                                //   if (reformatDate(inOutModel.inDate.toString())
                                //               .split(",")[0] ==
                                //           "Sat" ||
                                //       reformatDate(inOutModel.inDate.toString())
                                //               .split(",")[0] ==
                                //           "Sun") {
                                //     Text(
                                //       "${reformatDate(inOutModel.inDate.toString())}",
                                //       style: TextStyle(
                                //         color: Colors.red,
                                //         fontSize: 13,
                                //         fontFamily: 'Sarabun',
                                //         fontWeight: FontWeight.bold,
                                //       ),
                                //     );
                                //   } else {
                                //     Text(
                                //       "${reformatDate(inOutModel.inDate.toString())}",
                                //       style: TextStyle(
                                //         color: Colors.blue.shade400,
                                //         fontSize: 13,
                                //         fontFamily: 'Sarabun',
                                //         fontWeight: FontWeight.bold,
                                //       ),
                                //     );
                                //   }
                                // }()),
                                child: Text(
                                  "${reformatDate(inOutModel.inDate.toString())}",
                                  style: TextStyle(
                                    color: Colors.blue.shade400,
                                    fontSize: 13,
                                    fontFamily: 'Sarabun',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              Container(
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: Text(
                                  inOutModel.inTime.toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontFamily: 'Sarabun',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              Container(
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: Text(
                                  inOutModel.outTime.toString(),
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 13,
                                    fontFamily: 'Sarabun',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              Container(
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: Text(
                                  inOutModel.overTime.toString(),
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 13,
                                    fontFamily: 'Sarabun',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              Container(
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: Text(
                                  inOutModel.referrence.toString(),
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 13,
                                    fontFamily: 'Sarabun',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              Container(
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: Text(
                                  inOutModel.empName.toString(),
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 13,
                                    fontFamily: 'Sarabun',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
      );

  String reformatDate(String date) {
    List<String> _date = date.split("-");
    DateTime myDatetime =
        DateTime(int.parse(_date[0]), int.parse(_date[1]), int.parse(_date[2]));
    DateFormat formatter = DateFormat.yMEd();
    String finishDate = formatter.format(myDatetime);
    return finishDate;
  }

  Future<void> createExcelAll(List<InOutModel> listInOutModel) async {
    String _month = selectedDateStop.toString().split(' ')[0];
    int _monthNo = int.parse(_month.split('-')[1]);
    int _year = int.parse(_month.split('-')[0]);
    List<String> _monthName = [
      'มกราคม',
      'กุมภาพันธ์',
      'มีนาคม',
      'เมษายน',
      'พฤษภาคม',
      'มิถุนายน',
      'กรกฎาคม',
      'สิงหาคม',
      'กันยายน',
      'ตุลาคม',
      'พฤศจิกายน',
      'ธันวาคม'
    ];

    final excel.Workbook workbook = excel.Workbook();
    final excel.Worksheet sheet = workbook.worksheets[0];

    sheet.getRangeByName('A1').columnWidth = 8.43;
    sheet.getRangeByName('B1').columnWidth = 12.00;
    sheet.getRangeByName('C1:H1').columnWidth = 8.43;
    sheet.getRangeByName('I1').columnWidth = 3.57;

    final excel.Range mergeHeader1 = sheet.getRangeByName('C1:G2');
    mergeHeader1.merge();
    mergeHeader1.cellStyle.hAlign = excel.HAlignType.center;
    mergeHeader1.cellStyle.vAlign = excel.VAlignType.center;

    sheet.getRangeByName('C1').text = 'บริษัท อินโนลิเจนท์ ออโตเมชั่น จำกัด';
    sheet.getRangeByName('C1').cellStyle.fontSize = 20;
    sheet.getRangeByName('C1').cellStyle.fontName = 'TH Sarabun New';
    sheet.getRangeByName('C1').cellStyle.bold = true;

    final excel.Range mergeHeader2 = sheet.getRangeByName('C3:G3');
    mergeHeader2.merge();
    mergeHeader2.cellStyle.hAlign = excel.HAlignType.center;
    mergeHeader2.cellStyle.vAlign = excel.VAlignType.center;

    sheet.getRangeByName('C3').text = 'รายงานบันทึกเวลา การ เข้า- ออก งาน';
    sheet.getRangeByName('C3').cellStyle.fontSize = 15;
    sheet.getRangeByName('C3').cellStyle.fontName = 'TH Sarabun New';
    sheet.getRangeByName('C1').cellStyle.bold = true;

    final excel.Range mergeHeader3 = sheet.getRangeByName('C4:G4');
    mergeHeader3.merge();
    mergeHeader3.cellStyle.hAlign = excel.HAlignType.center;
    mergeHeader3.cellStyle.vAlign = excel.VAlignType.center;

    sheet.getRangeByName('C4').text =
        'ประจำเดือน ${_monthName[_monthNo - 1]} ปี $_year';
    sheet.getRangeByName('C4').cellStyle.fontSize = 15;
    sheet.getRangeByName('C4').cellStyle.fontName = 'TH Sarabun New';
    sheet.getRangeByName('C1').cellStyle.bold = true;

    final excel.Style style1 = workbook.styles.add('style1');
    style1.borders.bottom.lineStyle = excel.LineStyle.thin;
    style1.borders.bottom.color = '#AEAAAA';

    // sheet.getRangeByName('A5:I5').merge();
    sheet.getRangeByName('A5:I5').cellStyle = style1;

    sheet.getRangeByName('B6').text = 'รหัสพนักงาน';
    sheet.getRangeByName('B6').cellStyle.fontSize = 14;
    sheet.getRangeByName('B6').cellStyle.fontName = 'TH Sarabun New';

    sheet.getRangeByName('B7').text = 'ชื่อ - นามสกุล';
    sheet.getRangeByName('B7').cellStyle.fontSize = 14;
    sheet.getRangeByName('B7').cellStyle.fontName = 'TH Sarabun New';

    sheet.getRangeByName('B8').text = 'ตำแหน่ง';
    sheet.getRangeByName('B8').cellStyle.fontSize = 14;
    sheet.getRangeByName('B8').cellStyle.fontName = 'TH Sarabun New';

    sheet.getRangeByName('B9').text = 'แผนก';
    sheet.getRangeByName('B9').cellStyle.fontSize = 14;
    sheet.getRangeByName('B9').cellStyle.fontName = 'TH Sarabun New';

    sheet.getRangeByName('C6').text = ':';
    sheet.getRangeByName('C7').text = ':';
    sheet.getRangeByName('C8').text = ':';
    sheet.getRangeByName('C9').text = ':';

    final excel.Range mergeempId = sheet.getRangeByName('D6:H6');
    mergeempId.merge();
    mergeempId.cellStyle.hAlign = excel.HAlignType.right;
    mergeempId.cellStyle.vAlign = excel.VAlignType.center;
    sheet.getRangeByName('D6').text = listInOutModel[0].empId;
    sheet.getRangeByName('D6').cellStyle.fontSize = 14;
    sheet.getRangeByName('D6').cellStyle.fontName = 'TH Sarabun New';

    final excel.Range mergeempName = sheet.getRangeByName('D7:H7');
    mergeempName.merge();
    mergeempName.cellStyle.hAlign = excel.HAlignType.right;
    mergeempName.cellStyle.vAlign = excel.VAlignType.center;
    sheet.getRangeByName('D7').text = listInOutModel[0].empName;
    sheet.getRangeByName('D7').cellStyle.fontSize = 14;
    sheet.getRangeByName('D7').cellStyle.fontName = 'TH Sarabun New';

    final excel.Range mergeempPosition = sheet.getRangeByName('D8:H8');
    mergeempPosition.merge();
    mergeempPosition.cellStyle.hAlign = excel.HAlignType.right;
    mergeempPosition.cellStyle.vAlign = excel.VAlignType.center;
    sheet.getRangeByName('D8').text = listInOutModel[0].empPosition;
    sheet.getRangeByName('D8').cellStyle.fontSize = 14;
    sheet.getRangeByName('D8').cellStyle.fontName = 'TH Sarabun New';

    final excel.Range mergeempDepartment = sheet.getRangeByName('D9:H9');
    mergeempDepartment.merge();
    mergeempDepartment.cellStyle.hAlign = excel.HAlignType.right;
    mergeempDepartment.cellStyle.vAlign = excel.VAlignType.center;
    sheet.getRangeByName('D9').text = listInOutModel[0].empDepartment;
    sheet.getRangeByName('D9').cellStyle.fontSize = 14;
    sheet.getRangeByName('D9').cellStyle.fontName = 'TH Sarabun New';

    final excel.Style style2 = workbook.styles.add('style2');
    style2.borders.top.lineStyle = excel.LineStyle.thin;
    style2.borders.top.color = '#AEAAAA';

    // sheet.getRangeByName('A10:I10').merge();
    sheet.getRangeByName('A10:I10').cellStyle = style2;

    sheet.getRangeByName('A11').setText('ลำดับ');
    sheet.getRangeByName('B11').setText('วันที่');
    sheet.getRangeByName('C11').setText('เวลาเข้า');
    sheet.getRangeByName('D11').setText('เวลาออก');
    sheet.getRangeByName('E11').setText('โอที');

    final excel.Style styleBorder = workbook.styles.add('styleBorder');
    styleBorder.borders.bottom.lineStyle = excel.LineStyle.thin;
    styleBorder.borders.bottom.color = '#AEAAAA';

    final excel.Range mergeReference = sheet.getRangeByName('F11:H11');
    mergeReference.merge();
    mergeReference.cellStyle.hAlign = excel.HAlignType.center;
    mergeReference.cellStyle.vAlign = excel.VAlignType.center;
    sheet.getRangeByName('F11').setText('หมายเหตุ');

    sheet.getRangeByName('A11:I11').cellStyle = styleBorder;

    for (var item in listInOutModel) {
      sheet.getRangeByName('A$count').setText((count - 11).toString());
      sheet.getRangeByName('B$count').setText(item.inDate);
      sheet.getRangeByName('C$count').setText(item.inTime);
      sheet.getRangeByName('D$count').setText(item.outTime);
      sheet.getRangeByName('E$count').setText(item.overTime);

      final excel.Range mergeBodyReference =
          sheet.getRangeByName('F$count:I$count');
      mergeBodyReference.merge();
      mergeBodyReference.cellStyle.hAlign = excel.HAlignType.left;
      mergeBodyReference.cellStyle.vAlign = excel.VAlignType.center;
      sheet.getRangeByName('F$count').setText(item.referrence);
      sheet.getRangeByName('A$count:I$count').cellStyle = styleBorder;

      setState(() {
        count = count + 1;
      });
    }

    sheet.getRangeByName('A${count + 1}:D${count + 1}').merge();
    sheet
        .getRangeByName('A${count + 1}')
        .setText('ผู้ตรวจสอบ (….............................................)');

    sheet.getRangeByName('E${count + 1}:I${count + 1}').merge();
    sheet.getRangeByName('E${count + 1}').setText(
        'ชื่อพนักงาน (….............................................)');

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    if (kIsWeb) {
      AnchorElement(
          href:
              'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
        ..setAttribute('download',
            'รายงานบันทึกเวลา ประจำเดือน ${_monthName[_monthNo - 1]} ปี $_year ${listInOutModel[0].empName}.xlsx')
        ..click();
    }
  }
}
