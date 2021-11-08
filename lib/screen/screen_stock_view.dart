import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inapos/model/stock_model.dart';
import 'package:inapos/utility/my_constant.dart';
import 'package:inapos/utility/mystyle.dart';

class ScreenStockView extends StatefulWidget {
  // const ScreenStockView({ Key? key }) : super(key: key);

  @override
  _ScreenStockViewState createState() => _ScreenStockViewState();
}

class _ScreenStockViewState extends State<ScreenStockView> {
  bool status = true;
  bool loadstatus = true;
  List<StockModel> stockModels = [];

  @override
  void initState() {
    super.initState();
    readStock();
  }

  Future<Null> readStock() async {
    if (stockModels.length != 0) {
      print(stockModels);
      stockModels.clear();
    }
    print('status = $status');
    String url = '${MyConstant().urlStockCheck}';
    await Dio().get(url).then((value) {
      setState(() {
        loadstatus = false;
      });
      print('${MyConstant().urlStockCheck} ${value.toString()}');
      if (value.toString() != 'null') {
        for (var map in value.data) {
          StockModel stockModel = StockModel.fromJson(map);
          print(stockModel.stockId);
          setState(() {
            stockModels.add(stockModel);
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
      body: stockModels.length == 0
          ? Mystyle().showprogress()
          : SingleChildScrollView(
              child: Column(
                children: [
                  buildTitleStock(),
                  buildListStock(),
                ],
              ),
            ),
    );
  }

  Widget buildTitleStock() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.amber),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 1, child: Text('รหัสอุปกรณ์')),
          Expanded(flex: 2, child: Text('ชื่ออุปกรณ์')),
          Expanded(flex: 1, child: Text('จำนวนคงเหลือ')),
        ],
      ),
    );
  }

  Widget buildListStock() => ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        padding: EdgeInsets.all(10),
        itemCount: stockModels.length,
        itemBuilder: (context, index) => Row(
          children: [
            // Expanded(flex: 1, child: Text(stockModels[index].id.toString())),
            Expanded(
                flex: 1,
                child: Text(
                  stockModels[index].stockId,
                  style: TextStyle(
                    color: Colors.green.shade700,
                    fontSize: 15,
                    fontFamily: 'Sarabun',
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.grey.shade300,
                  ),
                )),
            Expanded(flex: 2, child: Text(stockModels[index].stockMaterial)),
            // Expanded(flex: 1, child: Text(stockModels[index].stockMaterial)),
            Expanded(
                flex: 1,
                child: Text(
                  stockModels[index].stockTotal.toString(),
                  style: TextStyle(
                    color: Colors.blue.shade400,
                    fontSize: 17,
                    fontFamily: 'Sarabun',
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ],
        ),
      );
}
