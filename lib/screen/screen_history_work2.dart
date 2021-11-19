import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inapos/model/history_model2.dart';
import 'package:inapos/utility/my_constant.dart';
import 'package:inapos/utility/mystyle.dart';

class ScreenHistoryWork2 extends StatefulWidget {
  // const ScreenHistoryWork2({ Key? key }) : super(key: key);

  @override
  _ScreenHistoryWork2State createState() => _ScreenHistoryWork2State();
}

class _ScreenHistoryWork2State extends State<ScreenHistoryWork2> {
  TextEditingController controller = new TextEditingController();
  bool status = true;
  bool loadstatus = true;
  List<HistoryModel2> _searchResult = [];
  List<HistoryModel2> historylists2 = [];

  Future<Null> readHistory() async {
    if (historylists2.length != 0) {
      historylists2.clear();
    }
    print('status = $status');
    String url = '${MyConstant().urlHistory}';
    await Dio().get(url).then((value) {
      setState(() {
        loadstatus = false;
      });

      if (value.toString() != 'null') {
        for (var map in value.data) {
          HistoryModel2 historyModel2 = HistoryModel2.fromJson(map);
          print(
              '${historyModel2.repairOrderno}-${historyModel2.branchCode}-${historyModel2.branchName} ');
          setState(() {
            historylists2.add(historyModel2);
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
    readHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width * 1,
        color: Colors.grey.shade200,
        child: Column(
          children: <Widget>[
            bodyMenu(),
            loadstatus ? Mystyle().showprogress() : bodyData()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.print),
      ),
    );
  }

  Widget bodyData() {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            showCheckboxColumn: false,
            // columns: [],
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  'ลำดับ',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                    fontFamily: 'Sarabun',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'เลขที่ใบงาน',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                    fontFamily: 'Sarabun',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'อุปกรณ์',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                    fontFamily: 'Sarabun',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'วันที่เปิดงาน',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                    fontFamily: 'Sarabun',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'วันที่ปิดงาน',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                    fontFamily: 'Sarabun',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'S/N',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                    fontFamily: 'Sarabun',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Work ESS',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                    fontFamily: 'Sarabun',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'จำนวน',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                    fontFamily: 'Sarabun',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'ประกัน',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                    fontFamily: 'Sarabun',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
            rows: [],
          ),
        ),
      ),
    );
  }

  Widget bodyMenu() {
    return Row(
      children: [
        Container(
          color: Colors.grey.shade400,
          width: MediaQuery.of(context).size.width * 1,
          height: 70,
          child: Card(
            child: ListTile(
              leading: Icon(Icons.search),
              title: TextField(
                style: TextStyle(
                  fontFamily: 'Sarabun',
                  fontSize: 20,
                ),
                // controller: controller,
                decoration: InputDecoration(
                  hintText: 'ค้นหา รหัสสาขา หรือ ชื่อสาขา',
                  border: InputBorder.none,
                ),
                onChanged: (text) {
                  // setState(() {
                  //   onSearchTextChanged(text);
                  // });
                },
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      // controller.clear();
                      // onSearchTextChanged('');
                    },
                  ),
                  IconButton(
                      onPressed: () {
                        // readallbranch();
                      },
                      icon: Icon(Icons.refresh)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
