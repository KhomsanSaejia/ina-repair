// import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inapos/utility/dialog.dart';
import 'package:inapos/utility/my_constant.dart';
import 'package:inapos/utility/mystyle.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
// import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class ScreenWorkOrderAdd extends StatefulWidget {
  @override
  _ScreenWorkOrderAddState createState() => _ScreenWorkOrderAddState();
}

class _ScreenWorkOrderAddState extends State<ScreenWorkOrderAdd> {
  DateTime selectedDate = DateTime.now();

  bool status = true;
  bool loadstatus = true;
  String repairserialno = "-";
  String repairworkess = "-";
  String repairticket = "-";
  String repairdetail = "-";
  final reDateinstall = TextEditingController();
  final reDateOpen = TextEditingController();
  String userName, userEmail, userCode;
  String selected;
  String warranty;

  String _selectedBranch;
  List _listBranch = [];
  List<Map> myJson = [
    {
      "id": '1',
      "image": "images/device/01_tplink_master.jpg",
      "name": "TP-LINK MASTER"
    },
    {
      "id": '2',
      "image": "images/device/01_tplink_master.jpg",
      "name": "TP-LINK SLAVE"
    },
    {
      "id": '3',
      "image": "images/device/01_tplink_master.jpg",
      "name": "TP-LINK AP"
    },
    {
      "id": '4',
      "image": "images/device/02_tplink_hub16.jpg",
      "name": "TP-LINK 16 PORT"
    },
    {
      "id": '5',
      "image": "images/device/03_tplink_hub8.jpg",
      "name": "TP-LINK 8 PORT"
    },
    {"id": '6', "image": "images/device/18_POE.jpg", "name": "ADAPTER TP-LINK"},
    {"id": '7', "image": "images/device/05_antenna.jpg", "name": "เสาอากาศ"},
    {"id": '8', "image": "images/device/06_fcc_wifi.jpg", "name": "FCC WIFI"},
    {"id": '9', "image": "images/device/07_fcc_lan.jpg", "name": "FCC LAN"},
    {"id": '10', "image": "images/device/08_power5v.jpg", "name": "POWER 5V"},
    {"id": '11', "image": "images/device/09_power12v.jpg", "name": "POWER 12V"},
    {"id": '12', "image": "images/device/10_keyboard.jpg", "name": "คีย์บอร์ด"},
    {
      "id": '13',
      "image": "images/device/11_scanner.jpg",
      "name": "ตัวอ่านบัตร"
    },
    {"id": '14', "image": "images/device/12_mouse.jpg", "name": "เม้าส์"},
    {"id": '15', "image": "images/device/13_ups.jpg", "name": "เครื่องสำรองไฟ"},
    {"id": '16', "image": "images/device/14_surge.jpg", "name": "ปลั๊ก Surge"},
    {
      "id": '17',
      "image": "images/device/15_currentloop.jpg",
      "name": "Current Loop"
    },
    {"id": '18', "image": "images/device/16_edccable.jpg", "name": "สาย EDC"},
    {
      "id": '19',
      "image": "images/device/17_printcable.jpg",
      "name": "สาย Printer"
    },
    {
      "id": '20',
      "image": "images/device/04_printer.jpg",
      "name": "ปริ้นท์เตอร์"
    },
    {"id": '21', "image": "images/device/19_POS.jpg", "name": "POS"},
    {
      "id": '22',
      "image": "images/device/21_ubi_master.jpg",
      "name": "UBIQUITI MASTER"
    },
    {
      "id": '23',
      "image": "images/device/21_ubi_master.jpg",
      "name": "UBIQUITI SLAVE"
    },
    {"id": '24', "image": "images/device/22_ubi_ap.jpg", "name": "UBIQUITI AP"},
    {
      "id": '25',
      "image": "images/device/20_POE.jpg",
      "name": "ADAPTER UBIQUITI"
    },
  ];
  List<Map> myListwarraty = [
    {"id": '1', "name": "ไม่มีประกัน"},
    {"id": '2', "name": "มีประกัน"},
    {"id": '3', "name": "แจ้งเคลม"}
  ];

  @override
  void initState() {
    super.initState();
    findUser();
    readnamebranch();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userName = preferences.getString('userName');
      userEmail = preferences.getString('userEmail');
      userCode = preferences.getString('userCode');
    });
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
        reDateOpen.text = selectedDate.toString().split(' ')[0];
      });
  }

  Future<Null> readnamebranch() async {
    if (_listBranch.length != 0) {
      _listBranch.clear();
    }
    print('status = $status');
    String url = '${MyConstant().urlBranchList}';
    await Dio().get(url).then((value) {
      setState(() {
        loadstatus = false;
      });
      // print('${MyConstant().urlBranchList} ${value.toString()}');
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "เพิ่มข้อมูลแจ้งซ่อม",
          style: TextStyle(
            fontFamily: 'Sarabun',
            fontSize: 20,
          ),
        ),
      ),
      body: loadstatus ? Mystyle().showprogress() : showdatauser(),
    );
  }

  Widget showdatauser() {
    return status
        ? builData()
        : Center(
            child: Text('ไม่มีข้อมูลผู้ใช้งาน'),
          );
  }

  Widget builData() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  date(),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  repairStation(),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  listdevicedropdown(),
                  // Mystyle().mySizeBox(),
                  listwarranty(),
                ],
              ),
            ),
            repairSerialno(),
            Container(
              width: MediaQuery.of(context).size.width * 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  repairWorkess(),
                  repairTicket(),
                ],
              ),
            ),
            // repairWorkess(),
            // repairTicket(),
            repairDetail(),
            Container(
              padding: EdgeInsets.only(right: 10),
              // color: Colors.green.shade200,
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.width * 0.27,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  openrepaircase(),
                ],
              ),
            ),

            // openrepaircase(),
          ],
        ),
      ),
    );
  }

  Widget date() => Stack(children: <Widget>[
        Container(
          height: 66,
          margin: EdgeInsets.only(top: 15),
          width: MediaQuery.of(context).size.width * 1,
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
          left: 3,
          bottom: 0,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.985,
            height: 68.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(1)),
              border: Border.all(color: Colors.grey, width: 1),
            ),
          ),
        ),
        Positioned(
          left: 13,
          bottom: 55,
          child: Container(
              width: 50,
              padding: EdgeInsets.only(left: 5),
              color: Colors.grey.shade50,
              child: Text('วันที่ :',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontFamily: 'Sarabun',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ))),
        )
      ]);
  // Widget repairStation() => Container(
  //       margin: EdgeInsets.only(top: 10),
  //       height: 66,
  //       decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
  //       padding: EdgeInsets.all(1),
  //       // color: Colors.green.shade200,
  //       width: MediaQuery.of(context).size.width * 0.985,
  //       alignment: Alignment.center,
  //       child: Center(
  //         child: Autocomplete(
  //           optionsBuilder: (TextEditingValue value) {
  //             if (value.text.isEmpty) {
  //               return [];
  //             }
  //             return _listBranch.where((suggestion) =>
  //                 suggestion.toLowerCase().contains(value.text.toLowerCase()));
  //           },
  //           onSelected: (value) {
  //             setState(() {
  //               _selectedBranch = value;
  //               print('selectedBranch = $_selectedBranch');
  //             });
  //           },
  //         ),
  //       ),
  //     );
  Widget repairStation() => Stack(children: <Widget>[
        Positioned(
          left: 3,
          bottom: 0,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.985,
            height: 68.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(1)),
              border: Border.all(color: Colors.grey, width: 1),
            ),
          ),
        ),
        Positioned(
          left: 13,
          bottom: 55,
          child: Container(
              width: 100,
              padding: EdgeInsets.only(left: 5),
              color: Colors.grey.shade50,
              child: Text('เลือกสาขา :',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontFamily: 'Sarabun',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ))),
        ),
        Container(
          height: 66,
          margin: EdgeInsets.only(top: 15),
          width: MediaQuery.of(context).size.width * 1,
          padding: EdgeInsets.all(1),
          // decoration: BoxDecoration(
          //   border: Border.all(color: Colors.grey),
          // ),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Autocomplete(
                optionsBuilder: (TextEditingValue value) {
                  if (value.text.isEmpty) {
                    return [];
                  }
                  return _listBranch.where((suggestion) => suggestion
                      .toLowerCase()
                      .contains(value.text.toLowerCase()));
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
        ),
      ]);

  Widget listdevicedropdown() => Container(
        margin: EdgeInsets.only(left: 3, top: 10),
        width: MediaQuery.of(context).size.width * 0.49,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: DropdownButton<String>(
          hint: new Text("เลือกอุปกรณ์ที่เสีย",
              style: TextStyle(fontFamily: 'Sarabun', fontSize: 15)),
          value: selected,
          onChanged: (String newValue) {
            setState(() {
              selected = newValue;
            });
          },
          items: myJson.map((Map map) {
            return new DropdownMenuItem<String>(
              value: map["name"].toString(),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    map["image"],
                    width: 25,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      map["name"],
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
      );
  Widget listwarranty() => Container(
        margin: EdgeInsets.only(
          top: 10,
          right: 3,
        ),
        width: MediaQuery.of(context).size.width * 0.49,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: Center(
          child: DropdownButton<String>(
            hint: new Text("เลือกสถานะประกัน",
                style: TextStyle(fontFamily: 'Sarabun', fontSize: 15)),
            value: warranty,
            onChanged: (String newValue) {
              setState(() {
                warranty = newValue;
              });
            },
            items: myListwarraty.map((Map map) {
              return new DropdownMenuItem<String>(
                value: map["name"].toString(),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        map["name"],
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
      );

  Widget repairSerialno() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // padding: EdgeInsets.all(3),
            margin: EdgeInsets.only(top: 10.0),
            // height: 75,
            // decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            width: MediaQuery.of(context).size.width * 0.985,
            child: TextFormField(
              enableInteractiveSelection: true,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.grey.shade600,
                  fontFamily: 'Sarabun'),
              onChanged: (value) => repairserialno = value.trim(),
              decoration: InputDecoration(
                labelText: 'Serial No :',
                prefixIcon: Icon(Icons.select_all_rounded),
                contentPadding:
                    new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(1),
                  borderSide: BorderSide(
                      style: BorderStyle.solid, color: Colors.grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(1),
                  borderSide: BorderSide(
                      style: BorderStyle.solid, color: Colors.grey, width: 1),
                ),
              ),
            ),
          ),
        ],
      );
  Widget repairWorkess() => Container(
        // padding: EdgeInsets.all(3),
        margin: EdgeInsets.only(left: 3, top: 10.0),
        // height: 80,
        width: MediaQuery.of(context).size.width * 0.49,
        child: TextFormField(
          // controller: reDateinstall,
          enableInteractiveSelection: true,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.grey.shade600,
              fontFamily: 'Sarabun'),
          onChanged: (value) => repairworkess = value.trim(),
          decoration: InputDecoration(
            labelText: 'Ess :',
            prefixIcon: Icon(Icons.add_chart),
            contentPadding:
                new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(1),
              borderSide: BorderSide(
                  style: BorderStyle.solid, color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(1),
              borderSide: BorderSide(
                  style: BorderStyle.solid, color: Colors.grey, width: 1),
            ),
          ),
        ),
      );
  Widget repairTicket() => Container(
        // padding: EdgeInsets.all(3),
        margin: EdgeInsets.only(top: 10.0, right: 3),
        // height: 80,
        width: MediaQuery.of(context).size.width * 0.49,
        child: TextFormField(
          // controller: reDateinstall,
          enableInteractiveSelection: true,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.grey.shade600,
              fontFamily: 'Sarabun'),
          onChanged: (value) => repairticket = value.trim(),
          decoration: InputDecoration(
            labelText: 'Ticket :',
            prefixIcon: Icon(Icons.web_outlined),
            contentPadding:
                new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(1.0),
              borderSide: BorderSide(
                  style: BorderStyle.solid, color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(1.0),
              borderSide: BorderSide(
                  style: BorderStyle.solid, color: Colors.grey, width: 1),
            ),
          ),
        ),
      );
  Widget repairDetail() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // padding: EdgeInsets.all(3),
            margin: EdgeInsets.only(top: 10.0),
            // height: 75,
            width: MediaQuery.of(context).size.width * 0.985,
            child: TextFormField(
              maxLines: 5,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'Sarabun'),
              onChanged: (value) => repairdetail = value.trim(),
              decoration: InputDecoration(
                labelText: 'รายละเอียดแจ้งซ่อม :',
                prefixIcon: Icon(Icons.description_outlined),
                contentPadding:
                    new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(1.0),
                  borderSide: BorderSide(
                      style: BorderStyle.solid, color: Colors.grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(1.0),
                  borderSide: BorderSide(
                      style: BorderStyle.solid, color: Colors.grey, width: 1),
                ),
              ),
            ),
          ),
        ],
      );
  Widget openrepaircase() => Container(
        // height: 80,
        width: MediaQuery.of(context).size.width * 0.3,
        child: FloatingActionButton.extended(
          focusColor: Colors.green,
          heroTag: 'openrepaircase',
          onPressed: () {
            if (_selectedBranch == null ||
                _selectedBranch.isEmpty ||
                selected == null ||
                selected.isEmpty ||
                warranty == null ||
                warranty.isEmpty) {
              normalDialog(context, 'ข้อมูลไม่ครบ กรุณาลองใหม่อีกครั้ง');
            } else {
              print("INA-${DateTime.now().toUtc().millisecondsSinceEpoch}");
              print(selectedDate.toString().split(" ")[0]);
              print('$_selectedBranch $selected $warranty');
              print('$repairserialno $repairworkess $repairticket');
              print('$repairdetail $userName');
              Mystyle().showprogress();
              addworkrepair();
            }
          },
          label: Text(
            'เปิดงาน',
            style: TextStyle(
              fontFamily: 'Sarabun',
              fontSize: 20,
            ),
          ),
        ),
      );

  Future<Null> addworkrepair() async {
    String url = '${MyConstant().urlJobAdd}';
    try {
      await Dio().post(url, data: {
        "repair_inawork":
            "INA-${DateTime.now().toUtc().millisecondsSinceEpoch}",
        "repair_dateopen": selectedDate.toString().split(" ")[0],
        "repair_open_unixtime": DateTime.now().toUtc().millisecondsSinceEpoch,
        "repair_branchname": _selectedBranch,
        "repair_device": selected,
        "repair_serial": repairserialno,
        "repair_ess": repairworkess,
        "repair_warranty": warranty,
        "repair_ticket": repairticket,
        "repair_detail": repairdetail,
        "repair_emp": userName,
      }).then((value) {
        if (value.toString() == 'ADD JOB SUCCESS') {
          Navigator.pop(context);
          Toast.show("เพิ่มข้อมูล สำเร็จ", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
        } else {
          normalDialog(context, 'ไม่สามารถเพิ่มข้อมูลได้ กรุณาลองใหม่อีกครั้ง');
        }
      });
    } catch (e) {
      normalDialog(context, e);
    }
  }
}
