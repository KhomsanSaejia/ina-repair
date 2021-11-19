import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inapos/model/in_out_model.dart';
import 'package:inapos/model/user_add_model.dart';
import 'package:inapos/utility/my_constant.dart';
import 'package:inapos/utility/mystyle.dart';

class ScreenInOutPatuiMobile extends StatefulWidget {
  // const ScreenInOutPatuiMobile({ Key? key }) : super(key: key);

  @override
  _ScreenInOutPatuiMobileState createState() => _ScreenInOutPatuiMobileState();
}

class _ScreenInOutPatuiMobileState extends State<ScreenInOutPatuiMobile> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.width * 2,
        // color: Colors.blue.shade200,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(3),
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.width * 0.2,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    seleceDateStart1(),
                    SizedBox(
                      width: 5,
                    ),
                    seleceDateStop(),
                    SizedBox(
                      width: 5,
                    ),
                    selectedEmp(),
                    SizedBox(
                      width: 5,
                    ),
                    searchData()
                  ],
                ),
              ),
            ),
            inOutModels.isEmpty
                ? Mystyle().showTitleCustom("ไม่มีข้อมูล")
                : Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: (MediaQuery.of(context).size.width * 1.7) - 6.6,
                    // color: Colors.red,
                    child: body(),
                  ),
          ],
        ),
      ),
    );
  }

  Widget seleceDateStart1() {
    return Container(
      // width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.15,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(143, 148, 251, .2),
                  blurRadius: 5.0,
                  offset: Offset(0, 10))
            ]),
        child: Row(
          children: [
            IconButton(
                color: Colors.green,
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
                icon: Icon(Icons.date_range)),
            Text(
              "|",
              style: TextStyle(fontSize: 20, fontFamily: "Sarabun"),
            ),
            date(selectedDateStart)
          ],
        ),
      ),
    );
  }

  Widget seleceDateStop() {
    return Container(
      // width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.15,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(143, 148, 251, .2),
                  blurRadius: 5.0,
                  offset: Offset(0, 10))
            ]),
        child: Row(
          children: [
            IconButton(
                color: Colors.red,
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
                icon: Icon(Icons.date_range)),
            Text(
              "|",
              style: TextStyle(fontSize: 20, fontFamily: "Sarabun"),
            ),
            date(selectedDateStop)
          ],
        ),
      ),
    );
  }

  Widget date(DateTime dateTime) {
    return Stack(children: <Widget>[
      Container(
        height: MediaQuery.of(context).size.width * 0.1,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        // border: Border.all(color: Colors.white),
        // borderRadius: BorderRadius.circular(3)),
        child: Center(
          child: Text(
            '${dateTime.toString().split(' ')[0]}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
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
          // padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromRGBO(143, 148, 251, .2),
                    blurRadius: 5.0,
                    offset: Offset(0, 10))
              ]),
          child: Container(
            height: MediaQuery.of(context).size.width * 0.15,
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              hint: Mystyle().textHeader("เลือกพนักงาน"),
              value: selectEmp,
              // isDense: true,
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
                        child: Text(
                          map["emp_Name"] + " ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Sarabun',
                              fontSize: 15,
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
    var w = MediaQuery.of(context).size.width * 0.2;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(w, 65.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        primary: Colors.orange.shade200,
        elevation: 8,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      ),
      onPressed: () {
        readInOutTime(selectEmp, selectedDateStart, selectedDateStop);
      },
      child: Mystyle().textCustom("ค้นหา", 20.0, Colors.black),
    );
  }

  Widget body() {
    return SingleChildScrollView(
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
                    'โอที',
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
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // Mystyle().textHeader("แก้ไข"),
                                      Mystyle().mySizeBox(),
                                      header("เวลาเข้างาน"),
                                      textBoxCustom(
                                          _valIntime, valIntime, "เวลาเข้างาน"),
                                      Mystyle().mySizeBox(),
                                      header("เวลาออกงาน"),
                                      textBoxCustom(_valOuttime, valOuttime,
                                          "เวลาออกงาน"),
                                      Mystyle().mySizeBox(),
                                      header("โอที"),
                                      textBoxCustom(
                                          _valOvertime, valOvertime, "โอที"),
                                      Mystyle().mySizeBox(),
                                      header("หมายเหตุ"),
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
                                                  readInOutTime(
                                                      selectEmp,
                                                      selectedDateStart,
                                                      selectedDateStop);
                                                },
                                              );
                                            },
                                            child: header("บันทึก"),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: header("ยกเลิก"),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      cells: [
                        DataCell(
                          Container(
                            // width: MediaQuery.of(context).size.width * 0.2,
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
                            // width: MediaQuery.of(context).size.width * 0.2,
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
                            // width: MediaQuery.of(context).size.width * 0.2,
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
                            // width: MediaQuery.of(context).size.width * 0.2,
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
                            // width: MediaQuery.of(context).size.width * 0.2,
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
        ));
  }

  Widget textBoxCustom(
      TextEditingController textEditingController, String data, String header) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Text(header),
        // Mystyle().mySizeBox(),
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

  Widget header(String header) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:
          Text(header, style: TextStyle(fontSize: 15, fontFamily: "Sarabun")),
    );
  }
}
