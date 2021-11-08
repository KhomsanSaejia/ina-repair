import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inapos/model/pm_model.dart';
import 'package:inapos/screen/screen_pm_add.dart';
import 'package:inapos/utility/dialog.dart';
// import 'package:inapos/utility/dialog.dart';
import 'package:inapos/utility/my_constant.dart';
import 'package:inapos/utility/mystyle.dart';

class ScreenPmDetail extends StatefulWidget {
  // const ScreenPmDetail({ Key? key }) : super(key: key);

  @override
  _ScreenPmDetailState createState() => _ScreenPmDetailState();
}

class _ScreenPmDetailState extends State<ScreenPmDetail> {
  TextEditingController controller = new TextEditingController();
  bool status = true;
  bool loadstatus = true;
  List<PMmodel> _searchResult = [];
  List<PMmodel> pmmodels = [];
  Future<Null> readallPm() async {
    if (pmmodels.length != 0) {
      pmmodels.clear();
    }
    print('status = $status');
    String url = '${MyConstant().urlPm}';
    await Dio().get(url).then((value) {
      setState(() {
        loadstatus = false;
      });
      if (value.toString() != 'null') {
        for (var map in value.data) {
          PMmodel pMmodel = PMmodel.fromJson(map);
          print(pMmodel.id);
          setState(() {
            pmmodels.add(pMmodel);
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
    readallPm();
  }

  Widget showdatapm() {
    if (status == false) {
      return Center(
        child: Text(
          'ยังไม่มีข้อมูล PM',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, fontFamily: 'Sarabun'),
        ),
      );
    } else {
      return showHistoryPm();
    }
  }

  // DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preventive maintenance'),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            loadstatus ? Mystyle().showprogress() : showdatapm(),
            addworkorder(),
          ],
        ),
      ),
    );
  }

  Widget showHistoryPm() => Scaffold(
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
                      onChanged: (text) {
                        setState(() {
                          onSearchTextChanged(text);
                        });
                      },
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
                              pmDialog(context, _searchResult[i]);
                            },
                            title: Mystyle().showTitleCustom2(
                                '${_searchResult[i].pmRef} | ${_searchResult[i].branchName}'),
                            subtitle: Mystyle().sarabun(
                                'วันที่ : ${_searchResult[i].datePm} ผรม: ${_searchResult[i].teamInstall}'),
                          ),
                          margin: const EdgeInsets.all(5),
                        );
                      },
                    )
                  : new ListView.builder(
                      itemCount: pmmodels.length,
                      itemBuilder: (context, index) {
                        return new Card(
                          child: new ListTile(
                            onTap: () {
                              pmDialog(context, pmmodels[index]);
                            },
                            title: Mystyle().showTitleCustom2(
                                '${pmmodels[index].pmRef} | ${pmmodels[index].branchName}'),
                            subtitle: Mystyle().sarabun(
                                'วันที่: ${pmmodels[index].datePm} ผรม: ${pmmodels[index].teamInstall}'),
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

    pmmodels.forEach((insatll) {
      if (insatll.branchName.contains(text) ||
          insatll.teamInstall.contains(text) ||
          insatll.datePm.contains(text)) _searchResult.add(insatll);
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
                    MaterialPageRoute route =
                        MaterialPageRoute(builder: (context) => ScreenPmAdd());
                    Navigator.push(context, route).then((value) => readallPm());
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
