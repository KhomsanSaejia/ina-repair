import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inapos/model/alert_model.dart';
import 'package:inapos/screen/screen_homepage_result.dart';
import 'package:inapos/utility/my_constant.dart';
import 'package:inapos/utility/mystyle.dart';

class ScreenHomePage2 extends StatefulWidget {
  // const ScreenHomePage2({ Key? key }) : super(key: key);

  @override
  _ScreenHomePage2State createState() => _ScreenHomePage2State();
}

class _ScreenHomePage2State extends State<ScreenHomePage2> {
  bool status = true;
  bool loadstatus = true;
  List<AlertModel> alertModels = [];
  @override
  void initState() {
    super.initState();
    readStatus();
  }

  Future<Null> readStatus() async {
    if (alertModels.length != 0) {
      alertModels.clear();
    }
    String url = '${MyConstant().urlStatuschec2}';
    await Dio().get(url).then((value) {
      setState(() {
        loadstatus = false;
      });
      if (value.toString() != 'null') {
        for (var map in value.data) {
          AlertModel alertModel = AlertModel.fromJson(map);
          setState(() {
            alertModels.add(alertModel);
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
      // return showStatus();
      return showStatus2();

      // return GridView.extent(
      //   maxCrossAxisExtent: 500,
      //   children: [showStatus()],
      // );
    }
  }

  Widget showStatus() => Center(
        child: ListView.builder(
            itemCount: alertModels.length,
            itemBuilder: (context, index) => Container(
                  alignment: Alignment.center,
                  height: 96,
                  width: MediaQuery.of(context).size.width * 0.9,
                  // width: 400,
                  child: InkWell(
                    onTap: () {
                      print('สถานะที่เลือก ${alertModels[index].sTATUS}');
                    },
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
                                    'สถานะ : ${alertModels[index].sTATUS}'),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Mystyle().showTitleH2(
                                        'จำนวนใบงาน : ${alertModels[index].tOTAL}'),
                                    // Mystyle().showTitleH2(
                                    //     'ประกัน : ${alertModels[index].repairWarranty}'),
                                  ],
                                ),
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Mystyle().showTitleH2(
                                //         'อุปกรณ์ที่เสีย : ${alertModels[index].repairDevice}'),
                                //     Mystyle().showTitleH2(
                                //         'สถานะ : ${alertModels[index].repairStatus}'),
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

  Widget showStatus2() => Center(
        child: ListView.builder(
          itemCount: alertModels.length,
          itemBuilder: (context, index) => Container(
            // color: Colors.blueAccent,
            child: Card(
              child: ListTile(
                // contentPadding: EdgeInsets.only(left: 50),
                // hoverColor: Colors.blueAccent,
                // focusColor: Colors.blue.shade500,
                onTap: () {
                  // print('สถานะที่เลือก ${alertModels[index].sTATUS}');
                  MaterialPageRoute route = MaterialPageRoute(
                    builder: (context) =>
                        ScreenHomePageResult(result: alertModels[index].sTATUS),
                  );
                  Navigator.push(context, route).then((value) => readStatus());
                },
                title: Mystyle()
                    .showTitleCustom('สถานะ : ${alertModels[index].sTATUS}'),
                subtitle: Mystyle()
                    .showTitleH2('จำนวนใบงาน : ${alertModels[index].tOTAL}'),
              ),
            ),
          ),
        ),
      );

  // Widget showStatus2() => Column(
  //   children: <Widget>[
  //     Container(
  //       height: 100,
  //       child: ListView.builder(
  //         itemBuilder: itemBuilder),
  //     ),
  //   ],

  // );
}
