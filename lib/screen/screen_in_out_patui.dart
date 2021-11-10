import 'dart:async';
import 'dart:convert';
// import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:inapos/model/in_out_model.dart';
import 'package:inapos/model/user_add_model.dart';
// import 'package:inapos/utility/dialog.dart';
// import 'package:inapos/utility/dialog.dart';
// import 'package:inapos/model/user_model.dart';
import 'package:inapos/utility/my_constant.dart';
import 'package:inapos/utility/mystyle.dart';
import 'package:flutter_speed_dial_material_design/flutter_speed_dial_material_design.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as excel;
import 'package:universal_html/html.dart' show AnchorElement;
import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';

// import 'package:fab_circular_menu/fab_circular_menu.dart';

class ScreenInOutPatui extends StatefulWidget {
  // const ScreenInOutPatui({ Key? key }) : super(key: key);

  @override
  _ScreenInOutPatuiState createState() => _ScreenInOutPatuiState();
}

class _ScreenInOutPatuiState extends State<ScreenInOutPatui> {
  bool status = true;
  bool loadstatus = true;
  List<InOutModel> inOutModels = [];

  UseraddModel useraddModel;
  List<Map> myListuseraddModel = [];

  String selectEmp, valFileName, referrence;
  TextEditingController _valFileName = TextEditingController();
  TextEditingController _valRef = TextEditingController();

  DateTime selectedDateStart = DateTime.now();
  DateTime selectedDateStop = DateTime.now();

  int count = 13;

  @override
  void initState() {
    super.initState();
    readalluser();
  }

  Future<Null> readalluser() async {
    if (myListuseraddModel.length != 0) {
      print(myListuseraddModel);
      myListuseraddModel.clear();
    }
    print('status = $status');
    String url = '${MyConstant().urlUserRead}';
    await Dio().get(url).then((value) {
      setState(() {
        loadstatus = false;
      });
      if (value.toString() != 'null') {
        for (var map in value.data) {
          // UseraddModel userModel = UseraddModel.fromJson(map);
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

  Future<Null> readInOutTime() async {
    if (inOutModels.length != 0) {
      inOutModels.clear();
    }
    String url =
        '${MyConstant().urlInOutDetail}?emp_id=$selectEmp&f_date=${selectedDateStart.toString().split(' ')[0]}&l_date=${selectedDateStop.toString().split(' ')[0]}';
    print(url);
    await Dio().get(url).then((value) {
      setState(() {
        loadstatus = false;
      });
      if (value.toString() != 'null') {
        for (var map in value.data) {
          InOutModel inOutModel = InOutModel.fromJson(map);

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

  Future<Null> readInOutTimeAll() async {
    if (inOutModels.length != 0) {
      inOutModels.clear();
    }
    String url =
        '${MyConstant().urlInOutAll}?f_date=${selectedDateStart.toString().split(' ')[0]}&l_date=${selectedDateStop.toString().split(' ')[0]}';
    print(url);
    await Dio().get(url).then((value) {
      setState(() {
        loadstatus = false;
      });
      if (value.toString() != 'null') {
        for (var map in value.data) {
          InOutModel inOutModel = InOutModel.fromJson(map);

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

  @override
  Widget build(BuildContext context) {
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
      createExcelSelect();
      setState(() {
        count = 13;
      });
    } else {
      readInOutTimeAll();
      print('$selectedActionIndex Selected');
    }
  }

  Widget textBoxCustom(TextEditingController _textEditingController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Mystyle().textHeader("หมายเหตุ"),
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
              controller: _textEditingController,
              style: const TextStyle(
                  fontFamily: "Sarabun",
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              onChanged: (value) {
                referrence = value.trim();
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
        readInOutTime();
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
                            showDialog(
                              context: context,
                              builder: (context) => SimpleDialog(
                                title: Center(
                                  child: Column(
                                    children: [
                                      Mystyle().textHeader("แก้ไขหมายเหตุ"),
                                      textBoxCustom(_valRef),
                                      Row(
                                        // mainAxisAlignment:
                                        // MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
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

                                  // child: Text(
                                  //   "แก้ไขหมายเหตุ",
                                  //   style: TextStyle(
                                  //       fontSize: 18,
                                  //       fontWeight: FontWeight.bold),
                                  // ),
                                ),
                              ),
                            );
                            // setState(() {});
                          },
                          cells: [
                            DataCell(
                              Container(
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: Text(
                                  inOutModel.inDate.toString(),
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
  Future<void> downloadExcel() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Mystyle().textCustom(
            "คุณต้องการเปลี่ยนแปลงหมายเหตุใช่หรือไม่", 20.0, Colors.red),
        children: [
          textBox(),
          TextButton.icon(
            onPressed: () {
              // if (_valFileName.text.isEmpty) {
              //   normalDialog(context, "กรุณากรอกข้อมูลให้ครบ");
              // } else {
              //   // createExcelSelect();
              //   Navigator.pop(context);
              //   setState(() {
              //     readInOutTime();

              //     // _valFileName.clear();
              //   });
              // }
            },
            icon: const Icon(
              Icons.check,
              color: Colors.green,
            ),
            label: Mystyle().textCustom("ตกลง", 20, Colors.black),
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.clear,
              color: Colors.red,
            ),
            label: Mystyle().textCustom("ยกเลิก", 20, Colors.black),
          ),
        ],
      ),
    );
  }

  Future<void> createExcelSelect() async {
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
    print('$_month $_monthNo $_year');

    final excel.Workbook workbook = excel.Workbook();
    final excel.Worksheet sheet = workbook.worksheets[0];

    // final excel.Picture picture =
    //     sheet.pictures.addStream(1, 2, await _readImageData('INA-LOGO.png'));
    // picture.lastRow = 5;
    // picture.lastColumn = 3;

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
    style1.borders.top.lineStyle = excel.LineStyle.medium;
    style1.borders.top.color = '#AEAAAA';

    sheet.getRangeByName('A5:I5').merge();
    sheet.getRangeByName('A5:I5').cellStyle = style1;

    sheet.getRangeByName('B6').text = 'รหัสพนักงาน';
    sheet.getRangeByName('B7').text = 'ชื่อ - นามสกุล';
    sheet.getRangeByName('B8').text = 'ตำแหน่ง';
    sheet.getRangeByName('B9').text = 'แผนก';

    sheet.getRangeByName('C6').text = ':';
    sheet.getRangeByName('C7').text = ':';
    sheet.getRangeByName('C8').text = ':';
    sheet.getRangeByName('C9').text = ':';

    final excel.Range mergeempId = sheet.getRangeByName('D6:H6');
    mergeempId.merge();
    mergeempId.cellStyle.hAlign = excel.HAlignType.right;
    mergeempId.cellStyle.vAlign = excel.VAlignType.center;
    sheet.getRangeByName('D6').text = inOutModels[0].empId;

    final excel.Range mergeempName = sheet.getRangeByName('D7:H7');
    mergeempName.merge();
    mergeempName.cellStyle.hAlign = excel.HAlignType.right;
    mergeempName.cellStyle.vAlign = excel.VAlignType.center;
    sheet.getRangeByName('D7').text = inOutModels[0].empName;

    final excel.Range mergeempPosition = sheet.getRangeByName('D8:H8');
    mergeempPosition.merge();
    mergeempPosition.cellStyle.hAlign = excel.HAlignType.right;
    mergeempPosition.cellStyle.vAlign = excel.VAlignType.center;
    sheet.getRangeByName('D8').text = inOutModels[0].empPosition;

    final excel.Range mergeempDepartment = sheet.getRangeByName('D9:H9');
    mergeempDepartment.merge();
    mergeempDepartment.cellStyle.hAlign = excel.HAlignType.right;
    mergeempDepartment.cellStyle.vAlign = excel.VAlignType.center;
    sheet.getRangeByName('D9').text = inOutModels[0].empDepartment;

    final excel.Style style2 = workbook.styles.add('style2');
    style2.borders.bottom.lineStyle = excel.LineStyle.medium;
    style2.borders.bottom.color = '#AEAAAA';

    sheet.getRangeByName('A10:I10').merge();
    sheet.getRangeByName('A10:I10').cellStyle = style2;

    sheet.getRangeByName('A12').setText('ลำดับ');
    sheet.getRangeByName('B12').setText('วันที่');
    sheet.getRangeByName('C12').setText('เวลาเข้า');
    sheet.getRangeByName('D12').setText('เวลาออก');
    sheet.getRangeByName('E12').setText('โอที');
    sheet.getRangeByName('F12').setText('หมายเหตุ');

    for (var item in inOutModels) {
      sheet.getRangeByName('A$count').setText((count - 12).toString());
      sheet.getRangeByName('B$count').setText(item.inDate);
      sheet.getRangeByName('C$count').setText(item.inTime);
      sheet.getRangeByName('D$count').setText(item.outTime);
      sheet.getRangeByName('E$count').setText(item.overTime);
      sheet.getRangeByName('F$count').setText(item.referrence);
      setState(() {
        count = count + 1;
      });
    }

    sheet.getRangeByName('A${count + 2}:D${count + 2}').merge();
    sheet
        .getRangeByName('A${count + 2}')
        .setText('ผู้ตรวจสอบ (….............................................)');

    sheet.getRangeByName('E${count + 2}:I${count + 2}').merge();
    sheet.getRangeByName('E${count + 2}').setText(
        'ชื่อพนักงาน (….............................................)');

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    if (kIsWeb) {
      AnchorElement(
          href:
              'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
        ..setAttribute('download',
            'รายงานบันทึกเวลา ประจำเดือน ${_monthName[_monthNo - 1]} ปี $_year ${inOutModels[0].empName}.xlsx')
        ..click();
    }
  }

  // Future<List<int>> _readImageData(String name) async {
  //   final ByteData data = await rootBundle.load('images/$name');
  //   return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  // }

  Widget textBox() {
    return Container(
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
          controller: _valFileName,
          style: const TextStyle(
              fontFamily: "Sarabun", fontSize: 20, fontWeight: FontWeight.bold),
          onChanged: (value) {
            valFileName = value.trim();
          },
        ),
      ),
    );
  }
}
