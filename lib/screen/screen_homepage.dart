import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inapos/model/status_model.dart';
import 'package:inapos/utility/my_constant.dart';
import 'package:inapos/utility/mystyle.dart';

class ScreenHome extends StatefulWidget {
  @override
  _ScreenHomeState createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  bool status = true;
  bool loadstatus = true;
  List<StatusModel> statusModels = [];

  @override
  void initState() {
    super.initState();
    readStatus();
  }

  Future<Null> readStatus() async {
    if (statusModels.length != 0) {
      print(statusModels);
      statusModels.clear();
    }
    print('status = $status');
    String url = '${MyConstant().urlStatuscheck}';
    await Dio().get(url).then((value) {
      setState(() {
        loadstatus = false;
      });
      print(value.toString());
      if (value.toString() != 'null') {
        for (var map in value.data) {
          StatusModel statusModel = StatusModel.fromJson(map);
          setState(() {
            statusModels.add(statusModel);
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
        loadstatus ? Mystyle().showprogress() : showdatarepair(),
        Positioned(
          child: FloatingActionButton(
            child: Icon(
              Icons.refresh,
              // textDirection: TextDirection.ltr,
            ),
            elevation: 10,
            onPressed: () {
              setState(() {
                readStatus();
              });
            },
          ),
          // top: 70,
          left: MediaQuery.of(context).size.width * 0.4,
          // right: 5,
          width: MediaQuery.of(context).size.width * 1,
          height: 50,
          bottom: 10,
        ),
      ],
    );
  }

  Widget showdatarepair() {
    if (status == false) {
      return Center(
        child: Text(
          'ยังไม่มีข้อมูลแจ้งซ่อมที่เกินกำหนด',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, fontFamily: 'Sarabun'),
        ),
      );
    } else {
      return showStatus();
      // return GridView.extent(
      //   maxCrossAxisExtent: 500,
      //   children: [showStatus()],
      // );
    }
  }

  Widget showStatus() => Center(
        child: ListView.builder(
            itemCount: statusModels.length,
            itemBuilder: (context, index) => Container(
                  alignment: Alignment.center,
                  height: 96,
                  width: MediaQuery.of(context).size.width * 0.9,
                  // width: 400,
                  child: Card(
                    elevation: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          // color: Colors.blue,
                          height: 90,
                          width: MediaQuery.of(context).size.width * 0.9,
                          // width: 400,
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Mystyle().showTitleCustom(
                                  'สาขา : ${statusModels[index].branchName}'),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Mystyle().showTitleH2(
                                      'วันที่เปิดงาน : ${statusModels[index].repairOpen}'),
                                  Mystyle().showTitleH2(
                                      'ประกัน : ${statusModels[index].repairWarranty}'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Mystyle().showTitleH2(
                                      'อุปกรณ์ที่เสีย : ${statusModels[index].repairDevice}'),
                                  Mystyle().showTitleH2(
                                      'สถานะ : ${statusModels[index].repairStatus}'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
      );
}
