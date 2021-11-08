import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inapos/model/install_model.dart';
import 'package:inapos/screen/screen_out_stock_pos_detail_add.dart';
import 'package:inapos/utility/dialog.dart';
import 'package:inapos/utility/my_constant.dart';
import 'package:inapos/utility/mystyle.dart';

class ScreenOutStockPosDetail extends StatefulWidget {
  // const ScreenOutStockPosDetail({ Key? key }) : super(key: key);

  @override
  _ScreenOutStockPosDetailState createState() =>
      _ScreenOutStockPosDetailState();
}

class _ScreenOutStockPosDetailState extends State<ScreenOutStockPosDetail> {
  TextEditingController controller = new TextEditingController();
  bool status = true;
  bool loadstatus = true;
  List<InstallModel> _searchResult = [];
  List<InstallModel> installmodels = [];

  Future<Null> readallinstall() async {
    if (installmodels.length != 0) {
      installmodels.clear();
    }
    print('status = $status');
    String url = '${MyConstant().urlStockOutList}';
    await Dio().get(url).then((value) {
      setState(() {
        loadstatus = false;
      });
      if (value.toString() != 'null') {
        for (var map in value.data) {
          InstallModel installModel = InstallModel.fromJson(map);
          setState(() {
            installmodels.add(installModel);
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
    readallinstall();
  }

  Widget showdatainstall() {
    if (status == false) {
      return Center(
        child: Text(
          'ยังไม่มีข้อมูลติดตั้ง',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30, fontFamily: 'Sarabun'),
        ),
      );
    } else {
      return showHistoryInstall();
    }
  }

  // DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('งานติดตั้ง POS'),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            loadstatus ? Mystyle().showprogress() : showdatainstall(),
            addworkorder(),
          ],
        ),
      ),
    );
  }

  Widget showHistoryInstall() => Scaffold(
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
              child: _searchResult.length != 0 || controller.text.isNotEmpty
                  ? new ListView.builder(
                      itemCount: _searchResult.length,
                      itemBuilder: (context, i) {
                        return new Card(
                          child: new ListTile(
                            onTap: () {
                              installDialog(context, _searchResult[i]);
                            },
                            title: Mystyle().showTitleCustom2(
                                '${_searchResult[i].dateInstall} | ${_searchResult[i].installRef}'),
                            subtitle: Mystyle().sarabun(
                                'ESS: ${_searchResult[i].branchName} PT: ${_searchResult[i].teamInstall}'),
                          ),
                          margin: const EdgeInsets.all(5),
                        );
                      },
                    )
                  : new ListView.builder(
                      itemCount: installmodels.length,
                      itemBuilder: (context, index) {
                        return new Card(
                          child: new ListTile(
                            onTap: () {
                              installDialog(context, installmodels[index]);
                            },
                            title: Mystyle().showTitleCustom2(
                                '${installmodels[index].dateInstall} | ${installmodels[index].installRef}'),
                            subtitle: Mystyle().sarabun(
                                'สาขา: ${installmodels[index].branchName} ผรม: ${installmodels[index].teamInstall}'),
                          ),
                          margin: const EdgeInsets.all(5),
                        );
                      },
                    ),
            ),
          ],
        ),
      );

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    installmodels.forEach((insatll) {
      if (insatll.installRef.contains(text) ||
          insatll.branchName.contains(text) ||
          insatll.dateInstall.contains(text) ||
          insatll.teamInstall.contains(text)) _searchResult.add(insatll);
    });

    setState(() {});
  }

  Widget addworkorder() => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 5, right: 5),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    MaterialPageRoute route = MaterialPageRoute(
                        builder: (context) => ScreenOutStockPosDetailAdd());
                    Navigator.push(context, route)
                        .then((value) => readallinstall());
                    // Navigator.push(context, route).then((value) {});
                  },
                  icon: Icon(Icons.person_add),
                  label: Text(
                    'เพิ่มใบงาน',
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
}
