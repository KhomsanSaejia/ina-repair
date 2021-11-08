import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inapos/model/stock_model.dart';
import 'package:inapos/utility/my_constant.dart';
import 'package:inapos/utility/mystyle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenStockEdit extends StatefulWidget {
  // const ScreenStockEdit({ Key? key }) : super(key: key);

  final StockModel stockeditModel;
  ScreenStockEdit({Key key, this.stockeditModel}) : super(key: key);

  @override
  _ScreenStockEditState createState() => _ScreenStockEditState();
}

class _ScreenStockEditState extends State<ScreenStockEdit> {
  StockModel stockeditModel;
  DateTime selectedDate = DateTime.now();

  String stockEditId,
      stockEditName,
      stockEditDetail,
      // stockEditTotal,
      stockEditDate,
      stockEditEmpcode,
      userCode;
  int stockEditTotal;
  void initState() {
    super.initState();
    stockeditModel = widget.stockeditModel;
    stockEditId = stockeditModel.stockId;
    stockEditName = stockeditModel.stockMaterial;
    stockEditDetail = stockeditModel.stockMaterialDetial;
    stockEditTotal = stockeditModel.stockTotal;
    stockEditDate = stockeditModel.stockLastupdate;
    stockEditEmpcode = stockeditModel.empCode;
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userCode = preferences.getString('userCode');
      print(userCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขข้อมูล ${stockeditModel.stockMaterial}'),
      ),
      body: SingleChildScrollView(
        child: Center(
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
        ),
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
          onChanged: (value) => stockEditId = value.trim(),
          initialValue: stockEditId,
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
          onChanged: (value) => stockEditName = value.trim(),
          initialValue: stockEditName,
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
          // maxLines: 2,

          onChanged: (value) => stockEditDetail = value.trim(),
          initialValue: stockEditDetail,
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
          onChanged: (value) => stockEditTotal = int.parse(value),
          initialValue: stockEditTotal.toString(),
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
                '${stockeditModel.id}, $stockEditId, $stockEditName, $stockEditDetail, $stockEditTotal, ${selectedDate.toString().split(' ')[0]} ,$stockEditEmpcode');
            editStock();
          },
          icon: Icon(Icons.upload_rounded),
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
  Future<Null> editStock() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Mystyle().showTitleH2('คุณต้องการแก้ไขข้อมูลใช่หรือไม่'),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextButton.icon(
                icon: Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                onPressed: () async {
                  String url = '${MyConstant().urlStockEdit}';
                  await Dio().post(url, data: {
                    "id": stockeditModel.id,
                    "stock_id": stockEditId,
                    "stock_material": stockEditName,
                    "stock_material_detial": stockEditDetail,
                    "stock_total": stockEditTotal,
                    "stock_lastupdate": selectedDate.toString().split(' ')[0],
                    "emp_code": userCode
                  }).then(
                    (value) {
                      if (value.toString() == 'UPDATE STOCK SUCCESS') {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
                    },
                  );
                },
                label: Text('ตกลง',
                    style: TextStyle(fontSize: 30, fontFamily: 'Sarabun')),
              ),
              TextButton.icon(
                icon: Icon(
                  Icons.clear,
                  color: Colors.red,
                ),
                onPressed: () => Navigator.pop(context),
                label: Text('ยกเลิก',
                    style: TextStyle(fontSize: 30, fontFamily: 'Sarabun')),
              ),
            ],
          )
        ],
      ),
    );
  }
}
