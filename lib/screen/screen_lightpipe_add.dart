import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inapos/utility/dialog.dart';
import 'package:inapos/utility/my_constant.dart';
import 'package:inapos/utility/mystyle.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:toast/toast.dart';

class ScreenLightPipeAdd extends StatefulWidget {
  // const ScreenLightPipeAdd({ Key? key }) : super(key: key);

  @override
  _ScreenLightPipeAddState createState() => _ScreenLightPipeAddState();
}

class _ScreenLightPipeAddState extends State<ScreenLightPipeAdd> {
  DateTime selectedDate = DateTime.now();
  List _listBranch = [];
  bool status = true;
  bool loadstatus = true;

  final reDateOpen = TextEditingController();
  var firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);

  List<Map> myListTeamInstall = [
    {"id": '1', "name": "ทีม พี่พี"},
    {"id": '2', "name": "ทีม พี่เอ๊กซ์"},
    {"id": '3', "name": "ทีม พี่วิทพี่วัท"},
    {"id": '4', "name": "ทีม พี่วงศ์"},
    {"id": '5', "name": "ทีม พี่สำเริง"},
    {"id": '6', "name": "ทีม พี่นารถ"},
    {"id": '7', "name": "ทีม INA"}
  ];

  String ref = "PREF-${DateTime.now().toUtc().millisecondsSinceEpoch}";
  String _selectedBranch;
  String totaleys = '0',
      totaleyk = '0',
      totalunion = '0',
      totalpg11 = '0',
      totalrubberblock = '0',
      totalll = '0',
      totallr = '0',
      totalclamp = '0',
      totalC = '0',
      totalcompound = '0',
      totalfiber = '0',
      totalbrass = '0';
  String teamInstall;

  Future<void> selectDate() async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        reDateOpen.text = selectedDate.toString().split(' ')[0];
        print('selectedDate = $selectedDate');
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
  void initState() {
    super.initState();
    readallbranch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ใบงานติดตั้ง POS'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            rowBranch(),
            Mystyle().mySizeBox(),
            rowContract(),
            Mystyle().mySizeBox(),
            rowDate(),
            Mystyle().mySizeBox(),
            Container(
              margin: EdgeInsets.only(top: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 3, color: Colors.grey),
              ),
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    output01('จำนวน LL'),
                    output02('จำนวน LR'),
                    output03('จำนวน EYS'),
                    output04('จำนวน EYK'),
                    output05('จำนวน UNION'),
                    output06('จำนวน บล็อคยาง+เต้ารับ'),
                    output07('จำนวน แคมป์ปะกับ'),
                    output08('จำนวน ราง C'),
                    output09('จำนวน คอมปาว'),
                    output10('จำนวน ไฟเบอร์'),
                    output11('จำนวน เกลียวทองเหลือง'),
                    output12('จำนวน PG11'),
                  ],
                ),
              ),
            ),
            Mystyle().mySizeBox(),
            buttonOK(),
            Mystyle().mySizeBox(),
          ],
        ),
      ),
    );
  }

  Widget rowBranch() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          titlebranch(),
          branch(),
        ],
      );
  Widget titlebranch() => Container(
        padding: EdgeInsets.only(left: 10),
        child: Text(
          'ชื่อสถานี',
          style: TextStyle(
              fontFamily: 'Sarabun', fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
  Widget branch() => Container(
        alignment: Alignment.bottomLeft,
        margin: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.6,
        child: Autocomplete(
          optionsBuilder: (TextEditingValue value) {
            if (value.text.isEmpty) {
              return [];
            }
            return _listBranch.where((suggestion) =>
                suggestion.toLowerCase().contains(value.text.toLowerCase()));
          },
          onSelected: (value) {
            setState(() {
              _selectedBranch = value;
              print('selectedBranch = $_selectedBranch');
            });
          },
        ),
      );
  Widget rowContract() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          titleContrac(),
          listContractor(),
        ],
      );
  Widget titleContrac() => Container(
        child: Text(
          'ผู้รับเหมา',
          style: TextStyle(
              fontFamily: 'Sarabun', fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
  Widget listContractor() => Container(
        margin: EdgeInsets.only(top: 3),
        width: MediaQuery.of(context).size.width * 0.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(style: BorderStyle.solid, color: Colors.grey),
        ),
        child: Center(
          child: DropdownButton<String>(
            hint: new Text("เลือกผู้รับเหมา",
                style: TextStyle(fontFamily: 'Sarabun', fontSize: 20)),
            value: teamInstall,
            onChanged: (String newValue) {
              setState(() {
                teamInstall = newValue;
                print('teamInstall = $teamInstall');
              });
            },
            items: myListTeamInstall.map((Map map) {
              return new DropdownMenuItem<String>(
                value: map["name"].toString(),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
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
  Widget rowDate() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          repairSelectDate(),
          repairDateopen(),
        ],
      );
  Widget repairSelectDate() => Container(
        margin: EdgeInsets.only(top: 3),
        height: 50,
        width: MediaQuery.of(context).size.width * 0.4,
        child: ElevatedButton(
          onPressed: () => selectDate(),
          child: Text(
            'วันที่ติดตั้ง',
            style: TextStyle(
              fontFamily: 'Sarabun',
              fontSize: 20,
            ),
          ),
        ),
      );
  Widget repairDateopen() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 3),
            width: MediaQuery.of(context).size.width * 0.5,
            child: TextFormField(
              controller: reDateOpen,
              enableInteractiveSelection: false,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.grey.shade600,
                  fontFamily: 'Sarabun'),
              onChanged: (value) =>
                  selectedDate.toString().split(' ')[0] = value.trim(),
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'วันที่ติดตั้ง :',
                prefixIcon: Icon(Icons.calendar_today_outlined),
                contentPadding:
                    new EdgeInsets.symmetric(vertical: 10, horizontal: 5.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
          ),
        ],
      );
  Widget output01(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => totalll = value.trim(),
                // initialValue: '0',
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: "0"),
              ),
            ),
          ),
          // ),
        ],
      );
  Widget output02(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => totallr = value.trim(),
                // initialValue: '0',
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: "0"),
              ),
            ),
          ),
          // ),
        ],
      );
  Widget output03(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => totaleys = value.trim(),
                // initialValue: '0',
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: "0"),
              ),
            ),
          ),
          // ),
        ],
      );
  Widget output04(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => totaleyk = value.trim(),
                // initialValue: '0',
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: "0"),
              ),
            ),
          ),
          // ),
        ],
      );
  Widget output05(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => totalunion = value.trim(),
                // initialValue: '0',
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: "0"),
              ),
            ),
          ),
          // ),
        ],
      );
  Widget output06(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => totalrubberblock = value.trim(),
                // initialValue: '0',
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: "0"),
              ),
            ),
          ),
          // ),
        ],
      );
  Widget output07(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => totalclamp = value.trim(),
                // initialValue: '0',
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: "0"),
              ),
            ),
          ),
          // ),
        ],
      );
  Widget output08(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => totalC = value.trim(),
                // initialValue: '0',
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: "0"),
              ),
            ),
          ),
          // ),
        ],
      );
  Widget output09(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => totalcompound = value.trim(),
                // initialValue: '0',
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: "0"),
              ),
            ),
          ),
          // ),
        ],
      );
  Widget output10(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => totalfiber = value.trim(),
                // initialValue: '0',
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: "0"),
              ),
            ),
          ),
          // ),
        ],
      );
  Widget output11(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => totalbrass = value.trim(),
                // initialValue: '0',
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: "0"),
              ),
            ),
          ),
          // ),
        ],
      );
  Widget output12(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => totalpg11 = value.trim(),
                // initialValue: '0',
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: "0"),
              ),
            ),
          ),
          // ),
        ],
      );
  Widget buttonOK() => NiceButton(
        width: MediaQuery.of(context).size.width * 1,
        background: firstColor,
        radius: 40,
        text: "บันทึก",
        icon: Icons.account_box,
        gradientColors: [secondColor, firstColor],
        onPressed: () {
          print('Branch $_selectedBranch');
          print('Con $teamInstall');
          print('Date ${selectedDate.toString().split(' ')[0]}');
          print('output01 $totalll');
          print('output02 $totallr');
          print('output03 $totaleys');
          print('output04 $totaleyk');
          print('output05 $totalunion');
          print('output06 $totalrubberblock');
          print('output07 $totalclamp');
          print('output08 $totalC');
          print('output09 $totalcompound');
          print('output10 $totalfiber');
          print('output11 $totalbrass');
          print('output12 $totalpg11');
          stockoutAdd();
        },
      );
  Future<Null> stockoutAdd() async {
    String url = '${MyConstant().urlStockPipeAdd}';
    try {
      await Dio().post(url, data: {
        "install_ref": ref,
        "branch_name": _selectedBranch,
        "teamInstall": teamInstall,
        "date_install": selectedDate.toString().split(' ')[0],
        "date_save": DateTime.now().toString().split(' ')[0],
        "total_eys": totaleys,
        "total_eyk": totaleyk,
        "total_union": totalunion,
        "total_pg11": totalpg11,
        "total_rubberblock": totalrubberblock,
        "total_ll": totalll,
        "total_lr": totallr,
        "total_clamp": totalclamp,
        "total_C": totalC,
        "total_compound": totalcompound,
        "total_fiber": totalfiber,
        "total_brass": totalbrass
      }).then((value) {
        if (value.toString() == 'SUCCESS') {
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
