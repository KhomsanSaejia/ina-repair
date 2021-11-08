import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inapos/model/lading_model.dart';
import 'package:inapos/screen/screen_lading_edit.dart';
import 'package:inapos/utility/my_constant.dart';
import 'package:inapos/utility/mystyle.dart';

class ScreenLading extends StatefulWidget {
  @override
  _ScreenLadingState createState() => _ScreenLadingState();
}

class _ScreenLadingState extends State<ScreenLading> {
  TextEditingController controller = new TextEditingController();
  bool status = true;
  bool loadstatus = true;
  List<LadingModel> ladingModels = [];

  Future<Null> readalllading() async {
    if (ladingModels.length != 0) {
      ladingModels.clear();
    }
    String url = '${MyConstant().urlStockBillLading}';
    await Dio().get(url).then((value) {
      setState(() {
        loadstatus = false;
      });
      if (value.toString() != 'null') {
        for (var map in value.data) {
          LadingModel ladingModel = LadingModel.fromJson(map);
          setState(() {
            ladingModels.add(ladingModel);
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
    readalllading();
  }

  Widget showdatainstall() {
    if (status == false) {
      return Center(
        child: Text(
          'ยังไม่มีข้อมูลใบเบิก',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30, fontFamily: 'Sarabun'),
        ),
      );
    } else {
      return showlistlading();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('งานเบิกใช้'),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            loadstatus ? Mystyle().showprogress() : showdatainstall()
          ],
        ),
      ),
    );
  }

  Widget showlistlading() => ListView.builder(
        itemCount: ladingModels.length,
        itemBuilder: (context, index) => Card(
          elevation: 10,
          child: InkWell(
            onTap: () {
              MaterialPageRoute route = MaterialPageRoute(
                builder: (context) => ScreenLadingEdit(
                  ladingModel: ladingModels[index],
                ),
              );
              Navigator.push(context, route).then((value) => readalllading());
            },
            child: Row(
              children: <Widget>[
                Container(
                  // color: Colors.blue.shade300,
                  padding: EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width * 0.9,
                  // height: MediaQuery.of(context).size.width * 0.35,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Mystyle().showTitleH2(
                          'ใบงานเลขที่: ${ladingModels[index].repairInawork}'),
                      detailData('สาขา', ladingModels[index].repairBranchname),
                      detailData('วันที่', ladingModels[index].repairDateopen),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  Text detailData(String header, String detail) {
    return Text('$header: $detail',
        style: TextStyle(
            color: Mystyle().darkcolor,
            fontSize: 15,
            fontWeight: FontWeight.bold));
  }
}
