import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:inapos/model/alert_model.dart';
import 'package:inapos/model/status_model.dart';
import 'package:inapos/utility/dialog.dart';
import 'package:inapos/utility/my_constant.dart';
import 'package:inapos/utility/mystyle.dart';

class ScreenHomePageResult extends StatefulWidget {
  // final ScreenHomePageResult({ Key? key }) : super(key: key);
  final String result;
  // alertModel: alertModels[index]
  ScreenHomePageResult({Key key, this.result}) : super(key: key);

  @override
  _ScreenHomePageResultState createState() => _ScreenHomePageResultState();
}

class _ScreenHomePageResultState extends State<ScreenHomePageResult> {
  String statusresult;
  bool status = true;
  bool loadstatus = true;
  List<StatusModel> statusModels = [];

  @override
  void initState() {
    super.initState();
    statusresult = widget.result;
    readStatus();
  }

  Future<Null> readStatus() async {
    if (statusModels.length != 0) {
      print(statusModels);
      statusModels.clear();
    }
    print('status = $status');
    String url = '${MyConstant().urlStatuschec3}';
    await Dio().post(url, data: {"status": statusresult}).then((value) {
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('ข้อมูลงานค้างตามสถานะ',
            style: TextStyle(
                // fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Sarabun')),
      ),
      body: Stack(
        children: <Widget>[
          loadstatus ? Mystyle().showprogress() : showdatarepair(),
          // Positioned(
          //   child: FloatingActionButton(
          //     child: Icon(
          //       Icons.refresh,
          //       // textDirection: TextDirection.ltr,
          //     ),
          //     elevation: 10,
          //     onPressed: () {
          //       setState(() {
          //         readStatus();
          //       });
          //     },
          //   ),
          //   // top: 70,
          //   left: MediaQuery.of(context).size.width * 0.4,
          //   // right: 5,
          //   width: MediaQuery.of(context).size.width * 1,
          //   height: 50,
          //   bottom: 10,
          // ),
        ],
      ),
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
                  height: 80,
                  width: MediaQuery.of(context).size.width * 0.9,
                  // width: 400,
                  child: InkWell(
                    onTap: () {
                      detailStatus(context, statusModels[index]);
                    },
                    child: Card(
                      elevation: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            // color: Colors.blue,
                            height: 70,
                            width: MediaQuery.of(context).size.width * 0.9,
                            // width: 400,
                            padding: EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${statusModels[index].repairOrderno}',
                                      style: TextStyle(
                                          fontFamily: 'Sarabun',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue.shade900),
                                    ),
                                    Text(
                                      '${statusModels[index].branchName}',
                                      style: TextStyle(
                                          fontFamily: 'Sarabun',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue.shade900),
                                    ),
                                  ],
                                ),
                                // Mystyle().showTitleCustom(
                                //     'สาขา : ${statusModels[index].branchName}'),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'วันที่เปิดงาน : ${statusModels[index].repairOpen}',
                                      style: TextStyle(
                                          fontFamily: 'Sarabun',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                    Text(
                                      'ประกัน : ${statusModels[index].repairWarranty}',
                                      style: TextStyle(
                                          fontFamily: 'Sarabun',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                    // Mystyle().showTitleH2(
                                    //     'วันที่เปิดงาน : ${statusModels[index].repairOpen}'),
                                    // Mystyle().showTitleH2(
                                    //     'ประกัน : ${statusModels[index].repairWarranty}'),
                                  ],
                                ),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'สถานะ : ${statusModels[index].repairStatus}',
                                      style: TextStyle(
                                          fontFamily: 'Sarabun',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue.shade300),
                                    ),
                                    Text(
                                      'อุปกรณ์ : ${statusModels[index].repairDevice}',
                                      style: TextStyle(
                                          fontFamily: 'Sarabun',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue.shade300),
                                    ),
                                  ],
                                ),

                                // Text(
                                //   'สถานะ : ${statusModels[index].repairStatus}',
                                //   style: TextStyle(
                                //       fontFamily: 'Sarabun',
                                //       fontWeight: FontWeight.bold,
                                //       color: Colors.blueGrey.shade500),
                                // ),
                                // Mystyle().showTitleH2(
                                //     'อุปกรณ์ที่เสีย : ${statusModels[index].repairDevice}'),
                                // Mystyle().showTitleH2(
                                //     'สถานะ : ${statusModels[index].repairStatus}'),
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Mystyle().showTitleH2(
                                //         'อุปกรณ์ที่เสีย : ${statusModels[index].repairDevice}'),
                                //     Mystyle().showTitleH2(
                                //         'สถานะ : ${statusModels[index].repairStatus}'),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
      );
}
