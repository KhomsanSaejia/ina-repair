import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inapos/utility/dialog.dart';
import 'package:inapos/utility/my_constant.dart';
import 'package:inapos/utility/mystyle.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class ScreenPmAdd extends StatefulWidget {
  // const ScreenPmAdd({ Key? key }) : super(key: key);

  @override
  _ScreenPmAddState createState() => _ScreenPmAddState();
}

class _ScreenPmAddState extends State<ScreenPmAdd> {
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
  String _selectedBranch;
  String teamInstall, userCode;
  String totalfcc = '0',
      total5v = '0',
      total12v = '0',
      totalcurlentloop = '0',
      totalattenna2m = '0',
      totalattenna3m = '0',
      totaledc = '0',
      totalscanner = '0',
      detail1Pos = '-',
      detail1Printer = '-',
      detail1Keyboard = '-',
      detail1UPS = '-',
      detail1Surge = '-',
      detail1AP = '-',
      detail1SLAVE = '-',
      detail1Master = '-',
      detail2Pos = '-',
      detail2Printer = '-',
      detail2Keyboard = '-',
      detail2UPS = '-',
      detail2Surge = '-',
      detail2AP = '-',
      detail2SLAVE = '-',
      detail2Master = '-';
  String ref = "PM-${DateTime.now().toUtc().millisecondsSinceEpoch}";
  @override
  void initState() {
    super.initState();
    readallbranch();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userCode = preferences.getString('userCode');
    });
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ใบงาน Rreventive maintenance',
          style: TextStyle(fontFamily: 'Sarabun'),
        ),
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
                    border: Border.all()),
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      output01('จำนวน FCC'),
                      output02('จำนวน เล็ก'),
                      output03('จำนวน ใหญ่'),
                      output04('จำนวน Current Loop'),
                      output05('จำนวน เสาอากาศ 2 ม.'),
                      output06('จำนวน เสาอากาศ 3 ม.'),
                      output07('จำนวน สาย EDC'),
                      output08('จำนวน แสกนเนอร์'),
                    ],
                  ),
                )),
            Container(
              margin: EdgeInsets.only(top: 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all()),
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    outputScrollview01('Pos'),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all()),
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    outputScrollview02('Printer'),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all()),
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    outputScrollview03('เม้าส์ + คีย์บอร์ด'),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all()),
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    outputScrollview04('UPS'),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all()),
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    outputScrollview06('Surge'),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all()),
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    outputScrollview07('AP'),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all()),
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    outputScrollview08('Slave'),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all()),
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    outputScrollview09('Master'),
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
  Widget rowContract() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          titleContrac(),
          listContractor(),
        ],
      );
  Widget rowDate() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          repairSelectDate(),
          repairDateopen(),
        ],
      );
  Widget titlebranch() => Container(
        child: Text(
          'ชื่อสถานี',
          style: TextStyle(
              fontFamily: 'Sarabun', fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
  Widget titleContrac() => Container(
        child: Text(
          'ผู้รับเหมา',
          style: TextStyle(
              fontFamily: 'Sarabun', fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
  Widget branch() => Container(
        width: MediaQuery.of(context).size.width * 0.7,
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
  Widget repairSelectDate() => Container(
        margin: EdgeInsets.only(top: 3),
        height: 50,
        width: MediaQuery.of(context).size.width * 0.4,
        child: ElevatedButton(
          onPressed: () => selectDate(),
          child: Text(
            'วันที่ทำ PM',
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
            // color: Colors.green.shade500,
            // margin: EdgeInsets.all(10),
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
                labelText: 'วันที่ทำ PM :',
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
  Widget listContractor() => Container(
        margin: EdgeInsets.only(top: 3),
        width: MediaQuery.of(context).size.width * 0.7,
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
                onChanged: (value) => totalfcc = value.trim(),
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
                onChanged: (value) => total5v = value.trim(),
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
                onChanged: (value) => total12v = value.trim(),
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
                onChanged: (value) => totalcurlentloop = value.trim(),
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
                onChanged: (value) => totalattenna2m = value.trim(),
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
                onChanged: (value) => totalattenna3m = value.trim(),
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
                onChanged: (value) => totaledc = value.trim(),
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
                onChanged: (value) => totalscanner = value.trim(),
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
  Widget outputScrollview01(String title) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              title,
              style: TextStyle(
                  fontFamily: 'Sarabun',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width * 0.43,
                child: TextFormField(
                  style: TextStyle(
                      color: Colors.green.shade400,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Sarabun'),
                  onChanged: (value) => detail1Pos = value.trim(),
                  // initialValue: '0',
                  decoration: InputDecoration(
                    labelText: 'รหัสทรัพย์สิน',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width * 0.45,
                child: TextFormField(
                  style: TextStyle(
                      color: Colors.green.shade400,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Sarabun'),
                  onChanged: (value) => detail2Pos = value.trim(),
                  // initialValue: '0',
                  decoration: InputDecoration(
                    labelText: 'Serial Number',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
  Widget outputScrollview02(String title) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              title,
              style: TextStyle(
                  fontFamily: 'Sarabun',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width * 0.43,
                child: TextFormField(
                  style: TextStyle(
                      color: Colors.green.shade400,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Sarabun'),
                  onChanged: (value) => detail1Printer = value.trim(),
                  // initialValue: '0',
                  decoration: InputDecoration(
                    labelText: 'รหัสทรัพย์สิน',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width * 0.45,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                      color: Colors.green.shade400,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Sarabun'),
                  onChanged: (value) => detail2Printer = value.trim(),
                  // initialValue: '0',
                  decoration: InputDecoration(
                    labelText: 'Serial Number',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
  Widget outputScrollview03(String title) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              title,
              style: TextStyle(
                  fontFamily: 'Sarabun',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width * 0.43,
                child: TextFormField(
                  style: TextStyle(
                      color: Colors.green.shade400,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Sarabun'),
                  onChanged: (value) => detail1Keyboard = value.trim(),
                  // initialValue: '0',
                  decoration: InputDecoration(
                    labelText: 'รหัสทรัพย์สิน',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width * 0.45,
                child: TextFormField(
                  style: TextStyle(
                      color: Colors.green.shade400,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Sarabun'),
                  onChanged: (value) => detail2Keyboard = value.trim(),
                  // initialValue: '0',
                  decoration: InputDecoration(
                    labelText: 'Serial Number',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
  Widget outputScrollview04(String title) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              title,
              style: TextStyle(
                  fontFamily: 'Sarabun',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width * 0.43,
                child: TextFormField(
                  style: TextStyle(
                      color: Colors.green.shade400,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Sarabun'),
                  onChanged: (value) => detail1UPS = value.trim(),
                  // initialValue: '0',
                  decoration: InputDecoration(
                    labelText: 'รหัสทรัพย์สิน',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width * 0.45,
                child: TextFormField(
                  style: TextStyle(
                      color: Colors.green.shade400,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Sarabun'),
                  onChanged: (value) => detail2UPS = value.trim(),
                  // initialValue: '0',
                  decoration: InputDecoration(
                    labelText: 'Serial Number',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
  Widget outputScrollview06(String title) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              title,
              style: TextStyle(
                  fontFamily: 'Sarabun',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width * 0.43,
                child: TextFormField(
                  style: TextStyle(
                      color: Colors.green.shade400,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Sarabun'),
                  onChanged: (value) => detail1Surge = value.trim(),
                  // initialValue: '0',
                  decoration: InputDecoration(
                    labelText: 'รหัสทรัพย์สิน',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width * 0.45,
                child: TextFormField(
                  style: TextStyle(
                      color: Colors.green.shade400,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Sarabun'),
                  onChanged: (value) => detail2Surge = value.trim(),
                  // initialValue: '0',
                  decoration: InputDecoration(
                    labelText: 'Serial Number',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
  Widget outputScrollview07(String title) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              title,
              style: TextStyle(
                  fontFamily: 'Sarabun',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width * 0.43,
                child: TextFormField(
                  style: TextStyle(
                      color: Colors.green.shade400,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Sarabun'),
                  onChanged: (value) => detail1AP = value.trim(),
                  // initialValue: '0',
                  decoration: InputDecoration(
                    labelText: 'รหัสทรัพย์สิน',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width * 0.45,
                child: TextFormField(
                  style: TextStyle(
                      color: Colors.green.shade400,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Sarabun'),
                  onChanged: (value) => detail2AP = value.trim(),
                  // initialValue: '0',
                  decoration: InputDecoration(
                    labelText: 'Serial Number',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
  Widget outputScrollview08(String title) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              title,
              style: TextStyle(
                  fontFamily: 'Sarabun',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width * 0.43,
                child: TextFormField(
                  style: TextStyle(
                      color: Colors.green.shade400,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Sarabun'),
                  onChanged: (value) => detail1SLAVE = value.trim(),
                  // initialValue: '0',
                  decoration: InputDecoration(
                    labelText: 'รหัสทรัพย์สิน',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width * 0.45,
                child: TextFormField(
                  style: TextStyle(
                      color: Colors.green.shade400,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Sarabun'),
                  onChanged: (value) => detail2SLAVE = value.trim(),
                  // initialValue: '0',
                  decoration: InputDecoration(
                    labelText: 'Serial Number',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
  Widget outputScrollview09(String title) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              title,
              style: TextStyle(
                  fontFamily: 'Sarabun',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width * 0.43,
                child: TextFormField(
                  style: TextStyle(
                      color: Colors.green.shade400,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Sarabun'),
                  onChanged: (value) => detail1Master = value.trim(),
                  // initialValue: '0',
                  decoration: InputDecoration(
                    labelText: 'รหัสทรัพย์สิน',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width * 0.45,
                child: TextFormField(
                  style: TextStyle(
                      color: Colors.green.shade400,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Sarabun'),
                  onChanged: (value) => detail2Master = value.trim(),
                  // initialValue: '0',
                  decoration: InputDecoration(
                    labelText: 'Serial Number',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
              ),
            ],
          ),
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
          if (_selectedBranch == "" ||
              _selectedBranch == null ||
              teamInstall == "" ||
              teamInstall == null) {
            normalDialog(context, "ข้อมูลไม่ครบ กรุณาตรวจสอบใหม่อีกครั้ง");
          } else {
            if (totalfcc == '0' || totalfcc.isEmpty) {
              totalfcc = '0';
            }
            if (total5v == '0' || total5v.isEmpty) {
              total5v = '0';
            }
            if (total12v == '0' || total12v.isEmpty) {
              total12v = '0';
            }
            if (totalcurlentloop == '0' || totalcurlentloop.isEmpty) {
              totalcurlentloop = '0';
            }
            if (totalattenna2m == '0' || totalattenna2m.isEmpty) {
              totalattenna2m = '0';
            }
            if (totalattenna3m == '0' || totalattenna3m.isEmpty) {
              totalattenna3m = '0';
            }
            if (totaledc == '0' || totaledc.isEmpty) {
              totaledc = '0';
            }
            if (totalscanner == '0' || totalscanner.isEmpty) {
              totalscanner = '0';
            }
            if (detail1Pos == '-' || detail1Pos.isEmpty) {
              detail1Pos = '-';
            }
            if (detail1Printer == '-' || detail1Printer.isEmpty) {
              detail1Printer = '-';
            }
            if (detail1Keyboard == '-' || detail1Keyboard.isEmpty) {
              detail1Keyboard = '-';
            }
            if (detail1UPS == '-' || detail1UPS.isEmpty) {
              detail1UPS = '-';
            }
            if (detail1Surge == '-' || detail1Surge.isEmpty) {
              detail1Surge = '-';
            }
            if (detail1AP == '-' || detail1AP.isEmpty) {
              detail1AP = '-';
            }
            if (detail1SLAVE == '-' || detail1SLAVE.isEmpty) {
              detail1SLAVE = '-';
            }
            if (detail1Master == '-' || detail1Master.isEmpty) {
              detail1Master = '-';
            }
            if (detail2Pos == '-' || detail2Pos.isEmpty) {
              detail2Pos = '-';
            }
            if (detail2Printer == '-' || detail2Printer.isEmpty) {
              detail2Printer = '-';
            }
            if (detail2Keyboard == '-' || detail2Keyboard.isEmpty) {
              detail2Keyboard = '-';
            }
            if (detail2UPS == '-' || detail2UPS.isEmpty) {
              detail2UPS = '-';
            }
            if (detail2Surge == '-' || detail2Surge.isEmpty) {
              detail2Surge = '-';
            }
            if (detail2AP == '-' || detail2AP.isEmpty) {
              detail2AP = '-';
            }
            if (detail2SLAVE == '-' || detail2SLAVE.isEmpty) {
              detail2SLAVE = '-';
            }
            if (detail2Master == '-' || detail2Master.isEmpty) {
              detail2Master = '-';
            }
            stockoutPm();
          }
        },
      );
  Future<Null> stockoutPm() async {
    String url = '${MyConstant().urlPmAdd}';
    try {
      await Dio().post(url, data: {
        "pm_ref": ref,
        "branch_name": _selectedBranch,
        "teamInstall": teamInstall,
        "date_pm": selectedDate.toString().split(' ')[0],
        "date_save": DateTime.now().toString().split(' ')[0],
        "total_fcc": totalfcc,
        "total_power5v": total5v,
        "total_power12v": total12v,
        "total_curlentloop": totalcurlentloop,
        "total_attenna2m": totalattenna2m,
        "total_attenna3m": totalattenna3m,
        "total_edc": totaledc,
        "total_scanner": totalscanner,
        "detail1Pos": detail1Pos,
        "detail2Pos": detail2Pos,
        "detail1Printer": detail1Printer,
        "detail2Printer": detail2Printer,
        "detail1Keyboard": detail1Keyboard,
        "detail2Keyboard": detail2Keyboard,
        "detail1UPS": detail1UPS,
        "detail2UPS": detail2UPS,
        "detail1Surge": detail1Surge,
        "detail2Surge": detail2Surge,
        "detail1AP": detail1AP,
        "detail2AP": detail2AP,
        "detail1SLAVE": detail1SLAVE,
        "detail2SLAVE": detail2SLAVE,
        "detail1Master": detail1Master,
        "detail2Master": detail2Master,
        "userCode": userCode
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
