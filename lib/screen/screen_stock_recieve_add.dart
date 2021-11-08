import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inapos/utility/dialog.dart';
import 'package:inapos/utility/my_constant.dart';
import 'package:inapos/utility/mystyle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenStockReceiveAdd extends StatefulWidget {
  // const ScreenStockReceiveAdd({ Key? key }) : super(key: key);

  @override
  _ScreenStockReceiveAddState createState() => _ScreenStockReceiveAddState();
}

class _ScreenStockReceiveAddState extends State<ScreenStockReceiveAdd> {
  DateTime selectedDate = DateTime.now();
  bool status = true;
  bool loadstatus = true;
  String userName, recinv, rectotal;
  String inV = "IN-${DateTime.now().toUtc().millisecondsSinceEpoch}";
  List<Map> myListDevice = [];

  String device;
  @override
  void initState() {
    super.initState();
    findUser();
    readallrecieve();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userName = preferences.getString('userName');
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ใบรับของ'),
      ),
      body: loadstatus
          ? Mystyle().showprogress()
          : SingleChildScrollView(
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      inv(),
                      abc(),
                      def(),
                      buttonSave(),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget abc() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [date(), listdevice()],
      );
  Widget def() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [recINV(), Mystyle().mySizeBox(), recTOTAL()],
      );
  Widget listdevice() => Expanded(
        flex: 2,
        child: Container(
          margin: EdgeInsets.only(top: 3),
          // color: Colors.blue,
          width: MediaQuery.of(context).size.width * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(style: BorderStyle.solid, color: Colors.grey),
          ),
          child: Center(
            child: DropdownButton<String>(
              // isDense: true,
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
                        // width: MediaQuery.of(context).size.width * 0.3,
                        // margin: EdgeInsets.only(left: 10),
                        child: Text(
                          map["stock_material"],
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
      );
  Widget date() => Expanded(
        flex: 2,
        child: Container(
          margin: EdgeInsets.only(top: 10.0),
          width: MediaQuery.of(context).size.width * 0.2,
          child: Text(
            'วันที่ ${selectedDate.toString().split(' ')[0]}',
            // enableInteractiveSelection: false,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.red.shade600,
                fontFamily: 'Sarabun'),
          ),
        ),
      );
  Widget inv() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10.0),
            width: MediaQuery.of(context).size.width * 0.95,
            child: TextFormField(
              enableInteractiveSelection: false,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.red.shade600,
                  fontFamily: 'Sarabun'),
              initialValue: inV,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'เลขที่ใบงาน',
                // prefixIcon: Icon(Icons.date_range),
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
          ),
        ],
      );
  Widget recINV() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 3),
            width: MediaQuery.of(context).size.width * 0.55,
            child: TextFormField(
              enableInteractiveSelection: false,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.green.shade600,
                  fontFamily: 'Sarabun'),
              onChanged: (value) => recinv = value.trim(),
              decoration: InputDecoration(
                labelText: 'เลขที่ Invoice',
                // prefixIcon: Icon(Icons.date_range),
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
          ),
        ],
      );
  Widget recTOTAL() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 3),
            width: MediaQuery.of(context).size.width * 0.375,
            child: TextFormField(
              keyboardType: TextInputType.number,
              enableInteractiveSelection: false,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.green.shade600,
                  fontFamily: 'Sarabun'),
              onChanged: (value) => rectotal = value.trim(),
              decoration: InputDecoration(
                labelText: 'จำนวน',
                // prefixIcon: Icon(Icons.date_range),
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
          ),
        ],
      );
  Widget buttonSave() => Container(
        padding: EdgeInsets.only(top: 3),
        // height: 80,
        // width: MediaQuery.of(context).size.width * 0.3,
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
  Future<Null> saVe() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(
          'คุณต้องการบันทึกข้อมูล $inV',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.blue.shade900,
            fontWeight: FontWeight.bold,
            fontFamily: 'Sarabun',
          ),
        ),
        // title: Mystyle().showTitleH2('คุณต้องการบันทึกข้อมูล $inV'),

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
                  String url = '${MyConstant().urlStockRecAdd}';
                  await Dio().post(url, data: {
                    "rec_id": inV,
                    "rec_date": selectedDate.toString().split(' ')[0],
                    "rec_inv": recinv,
                    "stock_material": device,
                    "rec_total": rectotal,
                    "emp_name": userName
                  }).then(
                    (value) {
                      print(value.toString());
                      if (value.toString() == 'SUCCESS') {
                        // print('UPDATE JOB SUCCESS');
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
