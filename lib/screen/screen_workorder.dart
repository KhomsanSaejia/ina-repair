import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inapos/model/job_model.dart';
import 'package:inapos/screen/screen_workorder_add.dart';
import 'package:inapos/screen/screen_workorder_edit.dart';
import 'package:inapos/utility/my_constant.dart';
import 'package:inapos/utility/mystyle.dart';

class ScreenWorkOrder extends StatefulWidget {
  @override
  _ScreenWorkOrderState createState() => _ScreenWorkOrderState();
}

class _ScreenWorkOrderState extends State<ScreenWorkOrder> {
  TextEditingController controller = new TextEditingController();
  bool status = true;
  bool loadstatus = true;
  List<JobModel> _searchResult = [];
  List<JobModel> jobmodels = [];
  @override
  void initState() {
    super.initState();
    jobCheck();
  }

  Future<Null> jobCheck() async {
    if (jobmodels.length != 0) {
      jobmodels.clear();
    }
    String url = '${MyConstant().urlJobCheck}';
    await Dio().get(url).then((value) {
      setState(() {
        loadstatus = false;
      });
      print('${MyConstant().urlJobCheck} = ${value.toString()}');
      if (value.toString() != 'null') {
        for (var map in value.data) {
          JobModel jobModel = JobModel.fromJson(map);
          setState(() {
            jobmodels.add(jobModel);
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
        loadstatus ? Mystyle().showprogress() : showlistjob(),
        addjob(),
      ],
    );
  }

  Widget showlistjob() {
    return status ? showStationList() : nodata();
  }

  Widget addjob() => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 10, right: 10),
                child: FloatingActionButton.extended(
                  heroTag: 'addjob',
                  onPressed: () {
                    MaterialPageRoute route = MaterialPageRoute(
                        builder: (context) => ScreenWorkOrderAdd());
                    Navigator.push(context, route).then((value) => jobCheck());
                  },
                  icon: Icon(Icons.add_to_photos),
                  label: Text(
                    'แจ้งซ่อม',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        fontFamily: 'Sarabun'),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
  Widget showStationList() => Scaffold(
        body: new Column(
          children: <Widget>[
            new Container(
              color: Theme.of(context).primaryColor,
              child: new Padding(
                padding: const EdgeInsets.all(3),
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
                                InkWell(
                                  onTap: () {
                                    MaterialPageRoute route = MaterialPageRoute(
                                      builder: (context) => ScreenWorkOrderEdit(
                                        jobModel: _searchResult[index],
                                      ),
                                    );
                                    Navigator.push(context, route)
                                        .then((value) => jobCheck());
                                  },
                                  child: Container(
                                    // color: Colors.red.shade200,
                                    padding: EdgeInsets.all(3),
                                    // margin: EdgeInsets.only(left: 2),
                                    width: MediaQuery.of(context).size.width *
                                        0.98,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Mystyle().showTitleCustom(
                                            'สาขา : ${_searchResult[index].branchName}'),
                                        Mystyle().showTitleH2(
                                            'อุปกรณ์ : ${_searchResult[index].repairDevice}'),
                                        // Mystyle().showTitleCustom(
                                        //     '${jobmodels[index].repairOrderno}'),

                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Mystyle().showTitleH2(
                                                'เปิดงาน ${_searchResult[index].repairOpen}'),
                                            Mystyle().showTitleH2(
                                                'โดย ${_searchResult[index].repairEmp}'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))
                  : ListView.builder(
                      itemCount: jobmodels.length,
                      itemBuilder: (context, index) => Card(
                            elevation: 20,
                            child: Row(
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    MaterialPageRoute route = MaterialPageRoute(
                                      builder: (context) => ScreenWorkOrderEdit(
                                        jobModel: jobmodels[index],
                                      ),
                                    );
                                    Navigator.push(context, route)
                                        .then((value) => jobCheck());
                                  },
                                  child: Container(
                                    // color: Colors.red.shade200,
                                    padding: EdgeInsets.all(3),
                                    // margin: EdgeInsets.only(left: 2),
                                    width: MediaQuery.of(context).size.width *
                                        0.98,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Mystyle().showTitleCustom(
                                            'สาขา : ${jobmodels[index].branchName}'),
                                        Mystyle().showTitleH2(
                                            'อุปกรณ์ : ${jobmodels[index].repairDevice}'),
                                        // Mystyle().showTitleCustom(
                                        //     '${jobmodels[index].repairOrderno}'),

                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Mystyle().showTitleH2(
                                                'เปิดงาน ${jobmodels[index].repairOpen}'),
                                            Mystyle().showTitleH2(
                                                'โดย ${jobmodels[index].repairEmp}'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
            ),
          ],
        ),
      );
  Widget nodata() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ไม่มีข้อมูลงานซ่อม',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: 'Sarabun'),
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
    jobmodels.forEach((jobmodel) {
      if (jobmodel.repairEmp.contains(text) ||
          jobmodel.repairDevice.contains(text) ||
          jobmodel.repairTicketpt.contains(text) ||
          jobmodel.repairWorkess.contains(text) ||
          jobmodel.branchName.contains(text)) _searchResult.add(jobmodel);
    });

    setState(() {});
  }
}
