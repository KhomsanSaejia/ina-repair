import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inapos/model/stock_output_detail.dart';
import 'package:inapos/screen/screen_stock_output.dart';
import 'package:inapos/utility/dialog.dart';
import 'package:inapos/utility/my_constant.dart';
import 'package:inapos/utility/mystyle.dart';

class ScreenStockOutputDetail extends StatefulWidget {
  // const ScreenStockOutputDetail({ Key? key }) : super(key: key);

  @override
  _ScreenStockOutputDetailState createState() =>
      _ScreenStockOutputDetailState();
}

class _ScreenStockOutputDetailState extends State<ScreenStockOutputDetail> {
  TextEditingController controller = new TextEditingController();
  bool status = true;
  bool loadstatus = true;
  List<StockOutputDetail> _searchResult = [];
  List<StockOutputDetail> stockOutputmodels = [];
  @override
  void initState() {
    super.initState();
    readallstockoutput();
  }

  Future<Null> readallstockoutput() async {
    if (stockOutputmodels.length != 0) {
      stockOutputmodels.clear();
    }
    print('status = $status');
    String url = '${MyConstant().urlStockTranOutCheck}';
    await Dio().get(url).then((value) {
      setState(() {
        loadstatus = false;
      });
      print('${MyConstant().urlStockTranOutCheck} ${value.toString()}');
      if (value.toString() != 'null') {
        for (var map in value.data) {
          StockOutputDetail stockOutputDetail = StockOutputDetail.fromJson(map);
          print(stockOutputDetail.inv);
          setState(() {
            stockOutputmodels.add(stockOutputDetail);
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
        loadstatus ? Mystyle().showprogress() : showdataoutputdetail(),
        addstation(),
      ],
    );
  }

  Widget showdataoutputdetail() {
    if (status == false) {
      return Center(
        child: Text(
          'ไม่มีข้อมูลใบเบิกของ',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30, fontFamily: 'Sarabun'),
        ),
      );
    } else {
      return showOutputDetailList();
    }
  }

  Widget showOutputDetailList() => Scaffold(
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
                        hintText: 'ค้นหา',
                        border: InputBorder.none,
                      ),
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
              child: _searchResult.length != 0 || controller.text.isNotEmpty
                  ? ListView.builder(
                      itemCount: _searchResult.length,
                      itemBuilder: (context, index) => Card(
                            elevation: 20,
                            child: InkWell(
                              onTap: () {
                                detailOutputDialog(
                                    context, _searchResult[index]);
                              },
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Mystyle().showTitleCustom(
                                            '${_searchResult[index].inv}'),
                                        Row(
                                          children: [
                                            Mystyle().showTitleH2(
                                                'ผรม : ${_searchResult[index].teaminsTall}'),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))
                  : ListView.builder(
                      itemCount: stockOutputmodels.length,
                      itemBuilder: (context, index) => Card(
                            elevation: 20,
                            child: InkWell(
                              onTap: () {
                                detailOutputDialog(
                                    context, stockOutputmodels[index]);
                              },
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    // width: MediaQuery.of(context).size.width * 0.3,
                                    // height: MediaQuery.of(context).size.width * 0.3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Mystyle().showTitleCustom(
                                                '${stockOutputmodels[index].inv}'),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Mystyle().showTitleH2(
                                                'ผรม : ${stockOutputmodels[index].teaminsTall}'),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
            ),
          ],
        ),
      );

  Widget addstation() => Column(
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
                        builder: (context) => ScreenStockOutput());
                    Navigator.push(context, route)
                        .then((value) => readallstockoutput());
                  },
                  icon: Icon(Icons.add_circle_outline),
                  label: Text(
                    'จ่ายของ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'Sarabun'),
                  ),
                ),
              ),
            ],
          ),
        ],
      );

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    stockOutputmodels.forEach((station) {
      if (station.teaminsTall.contains(text) ||
          station.empName.contains(text) ||
          station.inv.contains(text)) _searchResult.add(station);
    });

    setState(() {});
  }
}
