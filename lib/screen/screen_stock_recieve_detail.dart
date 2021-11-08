import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inapos/model/recieve_model.dart';
import 'package:inapos/screen/screen_stock_recieve_add.dart';
import 'package:inapos/utility/dialog.dart';
import 'package:inapos/utility/my_constant.dart';
import 'package:inapos/utility/mystyle.dart';

class ScreenStockReceiveDetail extends StatefulWidget {
  // const ScreenStockReceiveDetail({ Key? key }) : super(key: key);

  @override
  _ScreenStockReceiveDetailState createState() =>
      _ScreenStockReceiveDetailState();
}

class _ScreenStockReceiveDetailState extends State<ScreenStockReceiveDetail> {
  TextEditingController controller = new TextEditingController();
  bool status = true;
  bool loadstatus = true;
  List<RecieveModel> searchResult = [];
  List<RecieveModel> recievemodelslist = [];
  @override
  void initState() {
    super.initState();
    readallrecieve();
  }

  Future<Null> readallrecieve() async {
    if (recievemodelslist.length != 0) {
      recievemodelslist.clear();
    }
    String url = '${MyConstant().urlStockRec}';
    await Dio().get(url).then((value) {
      setState(() {
        loadstatus = false;
      });
      if (value.toString() != 'null') {
        for (var map in value.data) {
          RecieveModel recieveModel = RecieveModel.fromJson(map);
          setState(() {
            recievemodelslist.add(recieveModel);
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
        loadstatus ? Mystyle().showprogress() : showrecievedetail(),
        addrecieve(),
      ],
    );
  }

  Widget showrecievedetail() {
    if (status == false) {
      return Center(
        child: Text(
          'ไม่มีข้อมูลรับของ',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30, fontFamily: 'Sarabun'),
        ),
      );
    } else {
      return showRecieveDetailList();
    }
  }

  Widget addrecieve() => Column(
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
                        builder: (context) => ScreenStockReceiveAdd());
                    Navigator.push(context, route)
                        .then((value) => readallrecieve());
                  },
                  icon: Icon(Icons.add_circle_outline),
                  label: Text(
                    'รับของเข้า',
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
  Widget showRecieveDetailList() => Scaffold(
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
              child: searchResult.length != 0 || controller.text.isNotEmpty
                  ? ListView.builder(
                      itemCount: searchResult.length,
                      itemBuilder: (context, index) => Card(
                            elevation: 20,
                            child: InkWell(
                              onTap: () {
                                detailRecieveDialog(
                                    context, searchResult[index]);
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
                                            '${searchResult[index].recId}'),
                                        Row(
                                          children: [
                                            Mystyle().showTitleH2(
                                                'อุปกรณ์ : ${searchResult[index].stockMaterial}'),
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
                      itemCount: recievemodelslist.length,
                      itemBuilder: (context, index) => Card(
                            elevation: 20,
                            child: InkWell(
                              onTap: () {
                                detailRecieveDialog(
                                    context, recievemodelslist[index]);
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
                                                '${recievemodelslist[index].recId}'),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Mystyle().showTitleH2(
                                                'อุปกรณ์ : ${recievemodelslist[index].stockMaterial}'),
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

  onSearchTextChanged(String text) async {
    searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    recievemodelslist.forEach((recieve) {
      if (recieve.recId.contains(text) ||
          recieve.recInv.contains(text) ||
          recieve.stockMaterial.contains(text) ||
          recieve.empName.contains(text)) searchResult.add(recieve);
    });

    setState(() {});
  }
}
