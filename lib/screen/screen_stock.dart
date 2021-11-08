import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inapos/model/stock_model.dart';
import 'package:inapos/screen/screen_stock_add.dart';
import 'package:inapos/screen/screen_stock_edit.dart';
import 'package:inapos/utility/my_constant.dart';
import 'package:inapos/utility/mystyle.dart';

class ScreenStock extends StatefulWidget {
  @override
  _ScreenStockState createState() => _ScreenStockState();
}

class _ScreenStockState extends State<ScreenStock> {
  TextEditingController controller = new TextEditingController();
  bool status = true;
  bool loadstatus = true;
  List<StockModel> searchResult = [];
  List<StockModel> stockModels = [];

  @override
  void initState() {
    super.initState();
    readallbranch();
  }

  Future<Null> readallbranch() async {
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
    return Stack(
      children: <Widget>[
        loadstatus ? Mystyle().showprogress() : showdatastation(),
        addmaterial(),
      ],
    );
  }

  Widget addmaterial() => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 10, right: 10),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    MaterialPageRoute route = MaterialPageRoute(
                        builder: (context) => ScreenStockAdd());
                    Navigator.push(context, route)
                        .then((value) => readallbranch());
                  },
                  icon: Icon(Icons.add_circle),
                  label: Text(
                    'เพิ่มอุปกรณ์',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        fontFamily: 'Sarabun'),
                  ),
                ),
              ),
            ],
          ),
        ],
      );

  Widget showdatastation() {
    if (status == false) {
      return Center(
        child: Text(
          'ไม่มีข้อมูลอุปกรณ์',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30, fontFamily: 'Sarabun'),
        ),
      );
    } else {
      return showMaterialList();
      // return showliststation();
    }
  }

  Widget showMaterialList() => Scaffold(
        body: new Column(
          children: <Widget>[
            new Container(
              color: Theme.of(context).primaryColor,
              child: new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Card(
                  child: new ListTile(
                    leading: new Icon(Icons.search),
                    title: new TextField(
                      controller: controller,
                      decoration: new InputDecoration(
                          hintText: 'ค้นหา', border: InputBorder.none),
                      onChanged: onSearchTextChanged,
                    ),
                    trailing: new IconButton(
                      icon: new Icon(Icons.cancel),
                      onPressed: () {
                        controller.clear();
                        onSearchTextChanged('');
                      },
                    ),
                  ),
                ),
              ),
            ),
            new Expanded(
              child: searchResult.length != 0 || controller.text.isNotEmpty
                  ? ListView.builder(
                      itemCount: searchResult.length,
                      itemBuilder: (context, index) => Card(
                            elevation: 10,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(3),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Mystyle().showTitleCustom(
                                          '${searchResult[index].stockMaterial}'),
                                      Row(
                                        children: [
                                          Mystyle().showTitleH2(
                                              'รหัส: ${searchResult[index].stockId} จำนวน: ${searchResult[index].stockTotal}'),
                                          IconButton(
                                            icon: Icon(Icons.edit),
                                            onPressed: () {
                                              // MaterialPageRoute route =
                                              //     MaterialPageRoute(
                                              //   builder: (context) =>
                                              //       ScreenStationEdit(
                                              //     stationaddModel:
                                              //         _searchResult[index],
                                              //   ),
                                              // );
                                              // Navigator.push(context, route)
                                              //     .then((value) =>
                                              //         readallbranch());
                                            },
                                          ),
                                          IconButton(
                                              icon: Icon(Icons.delete),
                                              // onPressed: null,
                                              onPressed: () {
                                                // deleteStation(
                                                // _searchResult[index],
                                                // 'คุณต้องการลบข้อมูลสาขาใช่หรือไม่'),
                                              }),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ))
                  : ListView.builder(
                      itemCount: stockModels.length,
                      itemBuilder: (context, index) => Card(
                            elevation: 10,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(3),
                                  // width: MediaQuery.of(context).size.width * 0.3,
                                  // height: MediaQuery.of(context).size.width * 0.3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Mystyle().showTitleCustom(
                                          '${stockModels[index].stockMaterial}'),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.edit),
                                            onPressed: () {
                                              MaterialPageRoute route =
                                                  MaterialPageRoute(
                                                builder: (context) =>
                                                    ScreenStockEdit(
                                                  stockeditModel:
                                                      stockModels[index],
                                                ),
                                              );
                                              Navigator.push(context, route)
                                                  .then((value) =>
                                                      readallbranch());
                                            },
                                          ),
                                          Mystyle().showTitleH2(
                                              'รหัส: ${stockModels[index].stockId} จำนวน: ${stockModels[index].stockTotal}'),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
            ),
          ],
        ),
      );

  onSearchTextChanged(String text) async {
    searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    stockModels.forEach((stock) {
      if (stock.stockMaterial.contains(text) ||
          stock.stockMaterialDetial.contains(text) ||
          stock.stockId.toString().contains(text)) searchResult.add(stock);
    });

    setState(() {});
  }
}
