import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inapos/model/stock_model.dart';
import 'package:inapos/utility/my_constant.dart';
import 'package:inapos/utility/mystyle.dart';

class ScreenStockView2 extends StatefulWidget {
  // const ScreenStockView2({ Key? key }) : super(key: key);

  @override
  _ScreenStockView2State createState() => _ScreenStockView2State();
}

class _ScreenStockView2State extends State<ScreenStockView2> {
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
              // scrollDirection: Axis.vertical,
              child: Center(
                child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        'รหัสอุปกรณ์',
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
                        'ชื่ออุปกรณ์',
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
                        'จำนวนคงเหลือ',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                          fontFamily: 'Sarabun',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                  rows: stockModels
                      .map(
                        (stockModel) => DataRow(
                          cells: [
                            DataCell(
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Text(
                                  stockModel.stockId.toString(),
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
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Text(
                                  stockModel.stockMaterial.toString(),
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
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Text(
                                  stockModel.stockTotal.toString(),
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
    );
  }
}
