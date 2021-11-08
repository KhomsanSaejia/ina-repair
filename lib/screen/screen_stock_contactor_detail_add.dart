import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inapos/utility/dialog.dart';
import 'package:inapos/utility/my_constant.dart';
import 'package:inapos/utility/mystyle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenStockInConDetaAdd extends StatefulWidget {
  // const ScreenStockInConDetaAdd({ Key? key }) : super(key: key);

  @override
  _ScreenStockInConDetaAddState createState() =>
      _ScreenStockInConDetaAddState();
}

class _ScreenStockInConDetaAddState extends State<ScreenStockInConDetaAdd> {
  DateTime selectedDate = DateTime.now();
  String userName;
  @override
  void initState() {
    super.initState();
    findUser();
  }

  String opPOS = '0',
      opPrinter = '0',
      opKeyboardMouse = '0',
      opScanner = '0',
      opUps = '0',
      opEDCCable = '0',
      oplan1m = '0',
      opstainlesssteelpole = '0',
      opattenna2m = '0',
      opattenna3m = '0',
      oppg11 = '0',
      opsuargeGuard = '0',
      opPaperPrint = '0',
      opFCC = '0',
      opPowerFcc = '0',
      opPowerCL = '0',
      opLOOP = '0',
      opP2P = '0',
      opKiosPos = '0',
      opKiosFleet = '0',
      opMiniPc = '0',
      opFTD = '0',
      opPad = '0',
      opFlScanner = '0',
      opHub8 = '0',
      opHub16 = '0',
      opOrdering = '0',
      opLL = '0',
      opLR = '0',
      opEYS = '0',
      opEYK = '0',
      opUnion = '0',
      opRubberBlock = '0',
      opSocket = '0',
      opPuk = '0',
      opClamp = '0',
      opC = '0',
      opCompound = '0',
      opFiber = '0',
      opALLOY = '0';

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userName = preferences.getString('userName');
    });
  }

  List<Map> myListTeamInstall = [
    {"id": '1', "name": "ทีม พี่พี"},
    {"id": '2', "name": "ทีม พี่เอ๊กซ์"},
    {"id": '3', "name": "ทีม พี่วิทพี่วัท"},
    {"id": '4', "name": "ทีม พี่วงศ์"},
    {"id": '5', "name": "ทีม พี่สำเริง"},
    {"id": '6', "name": "ทีม พี่นารถ"},
    {"id": '7', "name": "ทีม INA"}
  ];
  String teamInstall = 'ทีม INA';
  String inV = "INC-${DateTime.now().toUtc().millisecondsSinceEpoch}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'คืนของจากผู้รับเหมา',
          style: TextStyle(
            fontFamily: 'Sarabun',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                inv(),
                abc(),
                output01('1. POS'),
                output02('2. Printer'),
                output03('3. Keyboard + Mouse'),
                output04('4. Scanner'),
                output05('5. Ups'),
                output06('6. EDC Cable'),
                output07('7. LAN 1 m'),
                output08('8. เสาแสตนเลส'),
                output09('9. เสาอากาศ 2m'),
                output10('10. เสาอากาศ 3m'),
                output11('11. PG11'),
                output12('12. Suarge Guard'),
                output13('13. กระดาษปริ้นท์'),
                output14('14. FCC'),
                output15('15. Power เล็ก'),
                output16('16. Power ใหญ่'),
                output17('17. Current Loop'),
                output18('18. TP-LINK M/S/A'),
                output19('19. Kios POS'),
                output20('20. Fleet Kios'),
                output21('21. Fleet Mini PC'),
                output22('22. Fleet Touch Display'),
                output23('23. Fleet Keypad'),
                output24('24. Fleet Scanner'),
                output25('25. Switch hub 8 port'),
                output26('26. Switch hub 16 port'),
                output27('27. จอ Ordering'),
                output28('28. LL'),
                output29('29. LR'),
                output30('30. EYS'),
                output31('31. EYK'),
                output32('32. UNION'),
                output33('33. บล็อคยาง'),
                output34('34. เต้ารับ'),
                output35('35. พุก'),
                output36('36. แคมป์ปะกับ'),
                output37('37. ราง C'),
                output38('38. คอมปาว'),
                output39('39. ไฟเบอ'),
                output40('40. เกลียวทองเหลือง'),
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
        children: [date(), listContractor()],
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
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => opPOS = value.trim(),
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
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => opPrinter = value.trim(),
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
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => opKeyboardMouse = value.trim(),
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
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => opScanner = value.trim(),
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
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => opUps = value.trim(),
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
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => opEDCCable = value.trim(),
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
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => oplan1m = value.trim(),
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
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => opstainlesssteelpole = value.trim(),
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
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => opattenna2m = value.trim(),
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
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => opattenna3m = value.trim(),
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
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => oppg11 = value.trim(),
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
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => opsuargeGuard = value.trim(),
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
  Widget output13(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => opPaperPrint = value.trim(),
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
  Widget output14(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => opFCC = value.trim(),
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
  Widget output15(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => opPowerFcc = value.trim(),
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
  Widget output16(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => opPowerCL = value.trim(),
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
  Widget output17(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => opLOOP = value.trim(),
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
  Widget output18(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => opP2P = value.trim(),
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
  Widget output19(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => opKiosPos = value.trim(),
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
  Widget output20(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => opKiosFleet = value.trim(),
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
  Widget output21(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => opMiniPc = value.trim(),
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
  Widget output22(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => opFTD = value.trim(),
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
  Widget output23(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => opPad = value.trim(),
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
  Widget output24(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => opFlScanner = value.trim(),
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
  Widget output25(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => opHub8 = value.trim(),
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
  Widget output26(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => opHub16 = value.trim(),
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
  Widget output27(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => opOrdering = value.trim(),
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
  Widget output28(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => opLL = value.trim(),
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
  Widget output29(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => opLR = value.trim(),
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
  Widget output30(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => opEYS = value.trim(),
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
  Widget output31(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => opEYK = value.trim(),
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
  Widget output32(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => opUnion = value.trim(),
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
  Widget output33(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => opRubberBlock = value.trim(),
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
  Widget output34(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => opSocket = value.trim(),
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
  Widget output35(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => opPuk = value.trim(),
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
  Widget output36(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => opClamp = value.trim(),
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
  Widget output37(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => opC = value.trim(),
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
  Widget output38(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => opCompound = value.trim(),
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
  Widget output39(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => opFiber = value.trim(),
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
  Widget output40(String title) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(flex: 2, child: Mystyle().sarabuntext(title)),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              width: MediaQuery.of(context).size.width * 0.35,
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Sarabun'),
                onChanged: (value) => opALLOY = value.trim(),
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
  Widget listContractor() => Expanded(
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
              hint: new Text("เลือกผู้รับเหมา",
                  style: TextStyle(fontFamily: 'Sarabun', fontSize: 20)),
              value: teamInstall,
              onChanged: (String newValue) {
                setState(() {
                  teamInstall = newValue;
                });
              },
              items: myListTeamInstall.map((Map map) {
                return new DropdownMenuItem<String>(
                  value: map["name"].toString(),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        // margin: EdgeInsets.only(left: 10),
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
  Widget buttonSave() => Container(
        padding: EdgeInsets.only(top: 3),
        // height: 80,
        // width: MediaQuery.of(context).size.width * 0.3,
        child: ElevatedButton.icon(
          onPressed: () {
            if (opPOS == '0' || opPOS.isEmpty) {
              opPOS = '0';
            }
            if (opPrinter == '0' || opPrinter.isEmpty) {
              opPrinter = '0';
            }
            if (opKeyboardMouse == '0' || opKeyboardMouse.isEmpty) {
              opKeyboardMouse = '0';
            }
            if (opScanner == '0' || opScanner.isEmpty) {
              opScanner = '0';
            }
            if (opUps == '0' || opUps.isEmpty) {
              opUps = '0';
            }
            if (opEDCCable == '0' || opEDCCable.isEmpty) {
              opEDCCable = '0';
            }
            if (oplan1m == '0' || oplan1m.isEmpty) {
              oplan1m = '0';
            }
            if (opstainlesssteelpole == '0' || opstainlesssteelpole.isEmpty) {
              opstainlesssteelpole = '0';
            }
            if (opattenna2m == '0' || opattenna2m.isEmpty) {
              opattenna2m = '0';
            }
            if (opattenna3m == '0' || opattenna3m.isEmpty) {
              opattenna3m = '0';
            }
            if (oppg11 == '0' || oppg11.isEmpty) {
              oppg11 = '0';
            }
            if (opsuargeGuard == '0' || opsuargeGuard.isEmpty) {
              opsuargeGuard = '0';
            }
            if (opPaperPrint == '0' || opPaperPrint.isEmpty) {
              opPaperPrint = '0';
            }
            if (opFCC == '0' || opFCC.isEmpty) {
              opFCC = '0';
            }
            if (opPowerFcc == '0' || opPowerFcc.isEmpty) {
              opPowerFcc = '0';
            }
            if (opPowerCL == '0' || opPowerCL.isEmpty) {
              opPowerCL = '0';
            }
            if (opLOOP == '0' || opLOOP.isEmpty) {
              opLOOP = '0';
            }
            if (opP2P == '0' || opP2P.isEmpty) {
              opP2P = '0';
            }
            if (opKiosPos == '0' || opKiosPos.isEmpty) {
              opKiosPos = '0';
            }
            if (opKiosFleet == '0' || opKiosFleet.isEmpty) {
              opKiosFleet = '0';
            }
            if (opMiniPc == '0' || opMiniPc.isEmpty) {
              opMiniPc = '0';
            }
            if (opFTD == '0' || opFTD.isEmpty) {
              opFTD = '0';
            }
            if (opPad == '0' || opPad.isEmpty) {
              opPad = '0';
            }
            if (opFlScanner == '0' || opFlScanner.isEmpty) {
              opFlScanner = '0';
            }
            if (opHub8 == '0' || opHub8.isEmpty) {
              opHub8 = '0';
            }
            if (opHub16 == '0' || opHub16.isEmpty) {
              opHub16 = '0';
            }
            if (opOrdering == '0' || opOrdering.isEmpty) {
              opOrdering = '0';
            }
            if (opLL == '0' || opLL.isEmpty) {
              opLL = '0';
            }
            if (opLR == '0' || opLR.isEmpty) {
              opLR = '0';
            }
            if (opEYS == '0' || opEYS.isEmpty) {
              opEYS = '0';
            }
            if (opEYK == '0' || opEYK.isEmpty) {
              opEYK = '0';
            }
            if (opUnion == '0' || opUnion.isEmpty) {
              opUnion = '0';
            }
            if (opRubberBlock == '0' || opRubberBlock.isEmpty) {
              opRubberBlock = '0';
            }
            if (opSocket == '0' || opSocket.isEmpty) {
              opSocket = '0';
            }
            if (opPuk == '0' || opPuk.isEmpty) {
              opPuk = '0';
            }
            if (opClamp == '0' || opClamp.isEmpty) {
              opClamp = '0';
            }
            if (opC == '0' || opC.isEmpty) {
              opC = '0';
            }
            if (opCompound == '0' || opCompound.isEmpty) {
              opCompound = '0';
            }
            if (opFiber == '0' || opFiber.isEmpty) {
              opFiber = '0';
            }
            if (opALLOY == '0' || opALLOY.isEmpty) {
              opALLOY = '0';
            }
            if (opPOS == '0' &&
                opPrinter == '0' &&
                opKeyboardMouse == '0' &&
                opScanner == '0' &&
                opUps == '0' &&
                opEDCCable == '0' &&
                oplan1m == '0' &&
                opstainlesssteelpole == '0' &&
                opattenna2m == '0' &&
                opattenna3m == '0' &&
                oppg11 == '0' &&
                opsuargeGuard == '0' &&
                opPaperPrint == '0' &&
                opFCC == '0' &&
                opPowerFcc == '0' &&
                opPowerCL == '0' &&
                opLOOP == '0' &&
                opP2P == '0' &&
                opKiosPos == '0' &&
                opKiosFleet == '0' &&
                opMiniPc == '0' &&
                opFTD == '0' &&
                opPad == '0' &&
                opFlScanner == '0' &&
                opHub8 == '0' &&
                opHub16 == '0' &&
                opOrdering == '0' &&
                opLL == '0' &&
                opLR == '0' &&
                opEYS == '0' &&
                opEYK == '0' &&
                opUnion == '0' &&
                opRubberBlock == '0' &&
                opSocket == '0' &&
                opPuk == '0' &&
                opClamp == '0' &&
                opC == '0' &&
                opCompound == '0' &&
                opFiber == '0' &&
                opALLOY == '0') {
              normalDialog(context, 'บันทึกข้อมูลไม่ได้ ข้อมูลเป็น 0 ทั้งหมด');
            } else {
              saVe();
            }
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
                  String url = '${MyConstant().urlStockTranInAdd}';
                  await Dio().post(url, data: {
                    "inc_inV": inV,
                    "inc_teamInstall": teamInstall,
                    "inc_date": selectedDate.toString().split(' ')[0],
                    "inc_opPOS": opPOS,
                    "inc_opPrinter": opPrinter,
                    "inc_opKeyboardMouse": opKeyboardMouse,
                    "inc_opScanner": opScanner,
                    "inc_opUps": opUps,
                    "inc_opEDCCable": opEDCCable,
                    "inc_oplan1m": oplan1m,
                    "inc_opstainlesssteelpole": opstainlesssteelpole,
                    "inc_opattenna2m": opattenna2m,
                    "inc_opattenna3m": opattenna3m,
                    "inc_oppg11": oppg11,
                    "inc_opsuargeGuard": opsuargeGuard,
                    "inc_opPaperPrint": opPaperPrint,
                    "inc_opFCC": opFCC,
                    "inc_opPowerFcc": opPowerFcc,
                    "inc_opPowerCL": opPowerCL,
                    "inc_opLOOP": opLOOP,
                    "inc_opP2P": opP2P,
                    "inc_opKiosPos": opKiosPos,
                    "inc_opKiosFleet": opKiosFleet,
                    "inc_opMiniPc": opMiniPc,
                    "inc_opFTD": opFTD,
                    "inc_opPad": opPad,
                    "inc_opFlScanner": opFlScanner,
                    "inc_opHub8": opHub8,
                    "inc_opHub16": opHub16,
                    "inc_opOrdering": opOrdering,
                    "inc_opLL": opLL,
                    "inc_opLR": opLR,
                    "inc_opEYS": opEYS,
                    "inc_opEYK": opEYK,
                    "inc_opUnion": opUnion,
                    "inc_opRubberBlock": opRubberBlock,
                    "inc_opSocket": opSocket,
                    "inc_opPuk": opPuk,
                    "inc_opClamp": opClamp,
                    "inc_opC": opC,
                    "inc_opCompound": opCompound,
                    "inc_opFiber": opFiber,
                    "inc_opALLOY": opALLOY,
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
