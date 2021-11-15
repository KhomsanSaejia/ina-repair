import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inapos/model/in_out_model.dart';
import 'package:inapos/utility/my_constant.dart';
import 'package:inapos/utility/mystyle.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:universal_html/html.dart' show AnchorElement;
import 'package:flutter/foundation.dart' show kIsWeb;

class ScreenInOutTime extends StatefulWidget {
  // const ScreenInOutTime({ Key? key }) : super(key: key);

  @override
  _ScreenInOutTimeState createState() => _ScreenInOutTimeState();
}

class _ScreenInOutTimeState extends State<ScreenInOutTime> {
  bool status = true;
  bool loadstatus = true;
  List<InOutModel> inoutModels = [];
  String userCode;
  int count = 2;

  @override
  void initState() {
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userCode = preferences.getString('userCode');
    });
    readInOutTime();
  }

  Future<Null> readInOutTime() async {
    if (inoutModels.length != 0) {
      inoutModels.clear();
    }
    String url = '${MyConstant().urlInOut}';
    await Dio().post(url, data: {"emp_id": userCode}).then((value) {
      setState(() {
        loadstatus = false;
      });
      if (value.toString() != 'null') {
        for (var map in value.data) {
          InOutModel inOutModel = InOutModel.fromJson(map);
          setState(() {
            inoutModels.add(inOutModel);
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
      body: inoutModels.length == 0
          ? Mystyle().showprogress()
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Center(
                  child: DataTable(
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
                          'หมายเหตุ',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontFamily: 'Sarabun',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                    rows: inoutModels
                        .map(
                          (inOutModel) => DataRow(
                            cells: [
                              DataCell(
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
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
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
      // floatingActionButton: FloatingActionButton.extended(
      //   icon: Icon(Icons.add),
      //   onPressed: () {
      //     createExcel();
      //   },
      //   label: Text("DATA"),
      // ),
    );
  }

  Future<void> createExcel() async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    sheet.getRangeByName('A1').setText('emp_id');
    sheet.getRangeByName('B1').setText('in_date');
    sheet.getRangeByName('C1').setText('in_time');
    sheet.getRangeByName('D1').setText('out_time');
    sheet.getRangeByName('E1').setText('over_time');

    for (var item in inoutModels) {
      sheet.getRangeByName('A$count').setText(item.empId);
      sheet.getRangeByName('B$count').setText(item.inDate);
      sheet.getRangeByName('C$count').setText(item.inTime);
      sheet.getRangeByName('D$count').setText(item.outTime);
      sheet.getRangeByName('E$count').setText(item.overTime);
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
        ..setAttribute('download', 'เอกสารสำคัญ$userCode.xlsx')
        ..click();
    } else {
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName =
          Platform.isWindows ? '$path\\เอกสาร.xlsx' : '$path/เอกสาร.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);
    }
  }
}
