import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inapos/model/history_model.dart';
import 'package:inapos/utility/dialog.dart';
import 'package:inapos/utility/my_constant.dart';
import 'package:inapos/utility/mystyle.dart';

class ScreenHistoryWork extends StatefulWidget {
  // const ScreenHistoryWork({ Key? key }) : super(key: key);

  @override
  _ScreenHistoryWorkState createState() => _ScreenHistoryWorkState();
}

class _ScreenHistoryWorkState extends State<ScreenHistoryWork> {
  TextEditingController controller = new TextEditingController();
  bool status = true;
  bool loadstatus = true;
  List<HistoryModel> _searchResult = [];
  List<HistoryModel> historylists = [];

  DateTime selectedDate = DateTime.now();
  final reDateOpen = TextEditingController();

  Future<void> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        reDateOpen.text = selectedDate.toString().split(' ')[0];
      });
  }

  Future<Null> readallbranch() async {
    if (historylists.length != 0) {
      historylists.clear();
    }
    print('status = $status');
    String url = '${MyConstant().urlHistory}';
    await Dio().get(url).then((value) {
      setState(() {
        loadstatus = false;
      });
      if (value.toString() != 'null') {
        for (var map in value.data) {
          HistoryModel historyModel = HistoryModel.fromJson(map);
          print(
              '${historyModel.repairOrderno}-${historyModel.branchCode}-${historyModel.branchName} ');
          setState(() {
            historylists.add(historyModel);
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

  Future<Null> readdistorydate() async {
    if (historylists.length != 0) {
      historylists.clear();
    }
    print('status = $status');
    String url = '${MyConstant().urlHistory2}';
    await Dio().post(url,
        data: {'date': selectedDate.toString().split(' ')[0]}).then((value) {
      setState(() {
        loadstatus = false;
      });

      if (value.toString() != 'null') {
        for (var map in value.data) {
          HistoryModel historyModel = HistoryModel.fromJson(map);
          print(
              '${historyModel.repairOrderno}-${historyModel.branchCode}-${historyModel.branchName} ');
          setState(() {
            historylists.add(historyModel);
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
    readallbranch();
  }

  Widget showdatarepair() {
    if (status == false) {
      return Column(
        children: <Widget>[
          Row(
            children: [
              Container(
                // width: ,
                child: Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          color: Colors.grey.shade400,
                          width: MediaQuery.of(context).size.width * 1,
                          height: 70,
                          child: Card(
                            child: ListTile(
                              leading: Icon(Icons.search),
                              title: TextField(
                                controller: controller,
                                decoration: InputDecoration(
                                  hintText: 'ค้นหา',
                                  border: InputBorder.none,
                                ),
                                onChanged: (text) {
                                  setState(() {
                                    onSearchTextChanged(text);
                                  });
                                },
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.cancel),
                                    onPressed: () {
                                      controller.clear();
                                      onSearchTextChanged('');
                                    },
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        readallbranch();
                                      },
                                      icon: Icon(Icons.refresh)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.grey.shade400,
                          width: MediaQuery.of(context).size.width * 1,
                          height: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                child: Text(
                                  'เลือกวันที่',
                                  style: TextStyle(
                                      fontFamily: 'Sarabun',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  showDatePicker(
                                          context: context,
                                          initialDate: selectedDate == null
                                              ? DateTime.now()
                                              : selectedDate,
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime.now())
                                      .then((date) {
                                    setState(() {
                                      selectedDate = date;
                                    });
                                  });
                                },
                              ),
                              date(),
                              // Text(selectedDate == null
                              //     ? 'Nothing has been picked yet'
                              //     : selectedDate.toString().split(' ')[0]),
                              ElevatedButton(
                                child: Text(
                                  'ค้นหา',
                                  style: TextStyle(
                                      fontFamily: 'Sarabun',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  readdistorydate();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            // color: Colors.green,
            height: MediaQuery.of(context).size.width * 1.5,
            child: Center(
              child: Text(
                'ยังไม่มีข้อมูลแจ้งซ่อม',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    fontFamily: 'Sarabun'),
              ),
            ),
          ),
        ],
      );
    } else {
      return showHistoryWork();
    }
  }

  Widget showHistoryWork() => Scaffold(
        body: Column(
          children: <Widget>[
            Row(children: [
              Container(
                // width: ,
                child: Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          color: Colors.grey.shade400,
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: 70,
                          child: Card(
                            child: ListTile(
                              leading: Icon(Icons.search),
                              title: TextField(
                                controller: controller,
                                decoration: InputDecoration(
                                  hintText: 'ค้นหา',
                                  border: InputBorder.none,
                                ),
                                onChanged: (text) {
                                  setState(() {
                                    onSearchTextChanged(text);
                                  });
                                },
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.cancel),
                                    onPressed: () {
                                      controller.clear();
                                      onSearchTextChanged('');
                                    },
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        readallbranch();
                                      },
                                      icon: Icon(Icons.refresh)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.grey.shade400,
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                child: Text(
                                  'เลือกวันที่',
                                  style: TextStyle(
                                      fontFamily: 'Sarabun',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  showDatePicker(
                                          context: context,
                                          initialDate: selectedDate == null
                                              ? DateTime.now()
                                              : selectedDate,
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime.now())
                                      .then((date) {
                                    setState(() {
                                      selectedDate = date;
                                    });
                                  });
                                },
                              ),
                              date(),
                              // Text(selectedDate == null
                              //     ? 'Nothing has been picked yet'
                              //     : selectedDate.toString().split(' ')[0]),
                              ElevatedButton(
                                child: Text(
                                  'ค้นหา',
                                  style: TextStyle(
                                      fontFamily: 'Sarabun',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  readdistorydate();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
            Expanded(
              child: _searchResult.length != 0 || controller.text.isNotEmpty
                  ? ListView.builder(
                      itemCount: _searchResult.length,
                      itemBuilder: (context, i) {
                        return Card(
                          elevation: 20,
                          child: ListTile(
                            onTap: () {
                              detailWorkDialog(context, _searchResult[i]);
                            },
                            title: Mystyle().showTitleCustom2(
                                '${_searchResult[i].branchCode} | ${_searchResult[i].branchName}'),
                            subtitle: Mystyle().sarabun(
                                '${_searchResult[i].repairOpen} ESS: ${_searchResult[i].repairWorkess} PT: ${_searchResult[i].repairTicketpt}'),
                          ),
                          margin: EdgeInsets.all(5),
                        );
                      },
                    )
                  : ListView.builder(
                      itemCount: historylists.length,
                      itemBuilder: (context, index) {
                        return new Card(
                          elevation: 20,
                          child: new ListTile(
                            onTap: () {
                              detailWorkDialog(context, historylists[index]);
                            },
                            title: Mystyle().showTitleCustom2(
                                '${historylists[index].branchCode} | ${historylists[index].branchName}'),
                            subtitle: Mystyle().sarabun(
                                '${historylists[index].repairOpen}            ESS: ${historylists[index].repairWorkess}        PT: ${historylists[index].repairTicketpt}'),
                          ),
                          margin: const EdgeInsets.all(5),
                        );
                      },
                    ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        loadstatus ? Mystyle().showprogress() : showdatarepair(),
      ],
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    historylists.forEach((history) {
      if (history.branchCode.contains(text) ||
          history.branchName.contains(text) ||
          history.repairTicketpt.contains(text) ||
          history.repairWorkess.contains(text) ||
          history.repairOrderno.contains(text)) _searchResult.add(history);
    });

    setState(() {});
  }

  Widget date() => Stack(children: <Widget>[
        Container(
          height: 35,
          width: 150,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(3)),
          child: Center(
            child: Text(
              '${selectedDate.toString().split(' ')[0]}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                // color: Colors.green.shade600,
                fontFamily: 'Sarabun',
              ),
            ),
          ),
        ),
      ]);
}
