import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inapos/utility/dialog.dart';
import 'package:inapos/utility/my_constant.dart';
import 'package:inapos/utility/mystyle.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class ScreenStockAdd extends StatefulWidget {
  // const ScreenStockAdd({ Key? key }) : super(key: key);

  @override
  _ScreenStockAddState createState() => _ScreenStockAddState();
}

class _ScreenStockAddState extends State<ScreenStockAdd> {
  DateTime selectedDate = DateTime.now();

  String userName,
      userEmail,
      userCode,
      materialId,
      materialName,
      materialDetail,
      materialTotal;

  @override
  void initState() {
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userName = preferences.getString('userName');
      userEmail = preferences.getString('userEmail');
      userCode = preferences.getString('userCode');
      print(userCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "เพิ่มข้อมูลอุปกรณ์",
          style: TextStyle(
            fontFamily: 'Sarabun',
            fontSize: 15,
          ),
        ),
      ),
      body: showdatauser(),
    );
  }

  Widget showdatauser() {
    return Center(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              stockDateUpdate(),
              Mystyle().mySizeBox(),
              stockMaterialID(),
            ],
          ),
          stockMaterialName(),
          stockMaterialDetail(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              stockMaterialTotal(),
              Mystyle().mySizeBox(),
              stockMaterialAdd(),
            ],
          )
        ],
      ),
    );
  }

  Widget stockDateUpdate() => Container(
        // color: Colors.green.shade500,
        margin: EdgeInsets.only(top: 10.0),
        width: 195,
        child: TextFormField(
          enableInteractiveSelection: false,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.grey.shade600,
              fontFamily: 'Sarabun'),
          // onChanged: (value) => reDateOpen.text = value.trim(),
          // onChanged: (value) =>
          //     selectedDate.toString().split(' ')[0] = value.trim(),
          initialValue: selectedDate.toString().split(' ')[0],
          readOnly: true,
          decoration: InputDecoration(
            labelText: 'วันที่อัพเดท',
            prefixIcon: Icon(Icons.date_range),
            contentPadding: EdgeInsets.all(10),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
        ),
      );
  Widget stockMaterialID() => Container(
        margin: EdgeInsets.only(top: 10.0),
        width: 195,
        child: TextFormField(
          keyboardType: TextInputType.number,
          enableInteractiveSelection: false,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.green.shade600,
              fontFamily: 'Sarabun'),
          onChanged: (value) => materialId = value.trim(),
          decoration: InputDecoration(
            labelText: 'รหัสอุปกรณ์',
            // prefixIcon: Icon(Icons.adjust),
            contentPadding: EdgeInsets.all(10),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
        ),
      );
  Widget stockMaterialName() => Container(
        margin: EdgeInsets.only(top: 10.0),
        width: 400,
        child: TextFormField(
          enableInteractiveSelection: false,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.green.shade600,
              fontFamily: 'Sarabun'),
          onChanged: (value) => materialName = value.trim(),
          decoration: InputDecoration(
            labelText: 'ชื่ออุปกรณ์',
            // prefixIcon: Icon(Icons.date_range),
            contentPadding: EdgeInsets.all(10),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
        ),
      );
  Widget stockMaterialDetail() => Container(
        margin: EdgeInsets.only(top: 10.0),
        width: 400,
        child: TextFormField(
          enableInteractiveSelection: false,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.green.shade600,
              fontFamily: 'Sarabun'),
          maxLines: 2,
          onChanged: (value) => materialDetail = value.trim(),
          decoration: InputDecoration(
            labelText: 'รายละเอียด',
            contentPadding: EdgeInsets.all(10),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
        ),
      );
  Widget stockMaterialTotal() => Container(
        margin: EdgeInsets.only(top: 10.0),
        width: 195,
        child: TextFormField(
          keyboardType: TextInputType.number,
          enableInteractiveSelection: false,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.green.shade600,
              fontFamily: 'Sarabun'),
          onChanged: (value) => materialTotal = value.trim(),
          decoration: InputDecoration(
            labelText: 'จำนวน',
            contentPadding: EdgeInsets.all(10),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
        ),
      );
  Widget stockMaterialAdd() => Container(
        margin: EdgeInsets.only(top: 10.0),
        width: 195,
        height: 50,
        child: ElevatedButton.icon(
          onPressed: () {
            print(
                '$materialId, $materialName, $materialDetail, $materialTotal, ${selectedDate.toString().split(' ')[0]} ,$userCode');
            stockAdd();
          },
          icon: Icon(Icons.save),
          label: Text(
            'บันทึก',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
                fontFamily: 'Sarabun'),
          ),
        ),
      );
  Future<Null> stockAdd() async {
    String url = '${MyConstant().urlStockAdd}';
    try {
      await Dio().post(url, data: {
        "stock_id": materialId,
        "stock_material": materialName,
        "stock_material_detial": materialDetail,
        "stock_total": materialTotal,
        "stock_lastupdate": selectedDate.toString().split(" ")[0],
        "emp_code": userCode,
      }).then((value) {
        if (value.toString() == 'ADD MATERIAL SUCCESS') {
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

// CREATE TABLE stock (
// 	id	INTEGER NOT NULL UNIQUE,
// 	stock_id	TEXT,
// 	stock_material	TEXT,
// 	stock_material_detial	TEXT,
// 	stock_total	TEXT,
// 	stock_lastupdate	TEXT,
// 	emp_code	TEXT,
// 	PRIMARY KEY(id AUTOINCREMENT)
// );
