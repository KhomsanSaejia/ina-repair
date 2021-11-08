import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:inapos/model/station_model.dart';
import 'package:inapos/screen/screen_station_add.dart';
import 'package:inapos/screen/screen_station_edit.dart';
import 'package:inapos/utility/my_constant.dart';
import 'package:inapos/utility/mystyle.dart';
import 'package:dio/dio.dart';

class ScreenStation extends StatefulWidget {
  @override
  _ScreenStationState createState() => _ScreenStationState();
}

class _ScreenStationState extends State<ScreenStation> {
  TextEditingController controller = new TextEditingController();
  bool status = true;
  bool loadstatus = true;
  List<StationModel> _searchResult = [];
  List<StationModel> stationModels = [];
  @override
  void initState() {
    super.initState();
    readallbranch();
  }

  Future<Null> readallbranch() async {
    if (stationModels.length != 0) {
      print(stationModels);
      stationModels.clear();
    }
    print('status = $status');
    String url = '${MyConstant().urlBranchRead}';
    await Dio().get(url).then((value) {
      setState(() {
        loadstatus = false;
      });
      print('${MyConstant().urlBranchRead} ${value.toString()}');
      if (value.toString() != 'null') {
        for (var map in value.data) {
          StationModel stationModel = StationModel.fromJson(map);
          print(stationModel.branchCode);
          setState(() {
            stationModels.add(stationModel);
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
        addstation(),
      ],
    );
  }

  Widget showdatastation() {
    if (status == false) {
      return Center(
        child: Text(
          'ไม่มีข้อมูลสาขา',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30, fontFamily: 'Sarabun'),
        ),
      );
    } else {
      return showStationList();
    }
  }

  Widget showStationList() => Scaffold(
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
                  ? ListView.builder(
                      itemCount: _searchResult.length,
                      itemBuilder: (context, index) => Card(
                            elevation: 20,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Mystyle().showTitleCustom(
                                          '${_searchResult[index].branchName}'),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.edit),
                                            onPressed: () {
                                              MaterialPageRoute route =
                                                  MaterialPageRoute(
                                                builder: (context) =>
                                                    ScreenStationEdit(
                                                  stationaddModel:
                                                      _searchResult[index],
                                                ),
                                              );
                                              Navigator.push(context, route)
                                                  .then((value) =>
                                                      readallbranch());
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.delete),
                                            // onPressed: null,
                                            onPressed: () => deleteStation(
                                                _searchResult[index],
                                                'คุณต้องการลบข้อมูลสาขาใช่หรือไม่'),
                                          ),
                                          Mystyle().showTitleH2(
                                              'รหัสสาขา: ${_searchResult[index].branchCode}'),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ))
                  : ListView.builder(
                      itemCount: stationModels.length,
                      itemBuilder: (context, index) => Card(
                            elevation: 20,
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
                                              '${stationModels[index].branchName}'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.edit),
                                            onPressed: () {
                                              MaterialPageRoute route =
                                                  MaterialPageRoute(
                                                builder: (context) =>
                                                    ScreenStationEdit(
                                                  stationaddModel:
                                                      stationModels[index],
                                                ),
                                              );
                                              Navigator.push(context, route)
                                                  .then((value) =>
                                                      readallbranch());
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.delete),
                                            // onPressed: null,
                                            onPressed: () => deleteStation(
                                                stationModels[index],
                                                'คุณต้องการลบข้อมูลสาขาใช่หรือไม่'),
                                          ),
                                          Mystyle().showTitleH2(
                                              'รหัสสาขา: ${stationModels[index].branchCode}'),
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
                        builder: (context) => ScreenStationAdd());
                    Navigator.push(context, route)
                        .then((value) => readallbranch());
                  },
                  icon: Icon(Icons.person_add),
                  label: Text(
                    'เพิ่มสาขา',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        fontFamily: 'Sarabun'),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
  Future<Null> deleteStation(StationModel stationModels, String header) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Mystyle().showTitleH2(header),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ElevatedButton(
                // onPressed: null,
                onPressed: () async {
                  Navigator.pop(context);
                  String url = '${MyConstant().urlBranchDelete}';
                  await Dio().post(url,
                      data: {'branch_code': stationModels.branchCode}).then(
                    (value) {
                      print('DELETE SUCCESS');
                      readallbranch();
                    },
                  );
                },
                child: Text('ตกลง'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('ยกเลิก'),
              ),
            ],
          )
        ],
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    stationModels.forEach((station) {
      if (station.branchCode.contains(text) ||
          station.branchName.contains(text)) _searchResult.add(station);
    });

    setState(() {});
  }
}
