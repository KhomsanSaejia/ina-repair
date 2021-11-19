import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inapos/model/in_out_model.dart';
import 'package:inapos/utility/my_constant.dart';
import 'package:inapos/utility/mystyle.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String valRef;
  TextEditingController _valRef = TextEditingController();

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
                            onSelectChanged: (newValue) {
                              _valRef.text = inOutModel.referrence.toString();
                              showDialog(
                                context: context,
                                builder: (context) => SimpleDialog(
                                  title: Center(
                                    child: Column(
                                      children: [
                                        Mystyle().textHeader("แก้ไขหมายเหตุ"),
                                        Mystyle().mySizeBox(),
                                        textBoxCustom(_valRef, valRef),
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
                                                  "in_time": inOutModel.inTime,
                                                  "out_time":
                                                      inOutModel.outTime,
                                                  "over_time":
                                                      inOutModel.overTime,
                                                  "referrence": _valRef.text
                                                }).then(
                                                  (value) {
                                                    if (value.toString() ==
                                                        'SUCCESS') {
                                                      Navigator.pop(context);
                                                    } else {
                                                      Navigator.pop(context);
                                                    }
                                                    readInOutTime();
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
    );
  }

  Widget textBoxCustom(
      TextEditingController textEditingController, String data) {
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
            width: (MediaQuery.of(context).size.width * 0.7) - 11,
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
}
