import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inapos/model/user_add_model.dart';
import 'package:inapos/screen/screen_employee_add.dart';
import 'package:inapos/screen/screen_employee_edit.dart';
import 'package:inapos/utility/my_constant.dart';
import 'package:inapos/utility/mystyle.dart';

class ScreenEmployee extends StatefulWidget {
  @override
  _ScreenEmployeeState createState() => _ScreenEmployeeState();
}

class _ScreenEmployeeState extends State<ScreenEmployee> {
  bool status = true;
  bool loadstatus = true;
  List<UseraddModel> userModels = [];
  String vusername,
      vuserlastname,
      vuserusername,
      vuserpassword,
      vuserposition,
      vusermobile,
      vuseremail;
  @override
  void initState() {
    super.initState();
    readalluser();
  }

  Future<Null> readalluser() async {
    if (userModels.length != 0) {
      print(userModels);
      userModels.clear();
    }
    print('status = $status');
    String url = '${MyConstant().urlUserRead}';
    await Dio().get(url).then((value) {
      setState(() {
        loadstatus = false;
      });
      if (value.toString() != 'null') {
        for (var map in value.data) {
          UseraddModel userModel = UseraddModel.fromJson(map);
          setState(() {
            userModels.add(userModel);
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
        loadstatus ? Mystyle().showprogress() : showdatauser(),
        adduserbutton(),
      ],
    );
  }

  Widget showdatauser() {
    return status
        ? showlistuser()
        : Center(
            child: Text('ไม่มีข้อมูลผู้ใช้งาน'),
          );
  }

  Widget showlistuser() => ListView.builder(
      itemCount: userModels.length,
      itemBuilder: (context, index) => Card(
            elevation: 10,
            child: Row(
              children: <Widget>[
                Container(
                  // color: Colors.pink.shade300,
                  padding: EdgeInsets.all(5),
                  height: 120,
                  width: 120,
                  // width: MediaQuery.of(context).size.width * 0.3,
                  // height: MediaQuery.of(context).size.width * 0.3,
                  child: Image.asset(
                    'images/emp/${userModels[index].empCode}.png',
                    // 'images/profile.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  // color: Colors.blue.shade300,
                  padding: EdgeInsets.all(5),
                  height: 130,
                  width: 280,
                  // width: MediaQuery.of(context).size.width * 0.7,
                  // height: MediaQuery.of(context).size.width * 0.35,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Mystyle()
                          .showTitleH2('ชื่อ: ${userModels[index].empName}'),
                      detailData('ตำแหน่ง', userModels[index].empPosition),
                      detailData('เบอร์โทร', userModels[index].empTel),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              MaterialPageRoute route = MaterialPageRoute(
                                builder: (context) => ScreenEmployeeEdit(
                                  useraddModel: userModels[index],
                                ),
                              );
                              Navigator.push(context, route)
                                  .then((value) => readalluser());
                            },
                            // onPressed: null,
                            // onPressed: () => updatedetialUser(
                            //   userModels[index],
                            //   'Do you want to edit the information?',
                            // ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            // onPressed: null,
                            onPressed: () => deleteUser(userModels[index],
                                'คุณต้องการลบข้อมูลผู้ใช้งาน'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ));

  Text detailData(String header, String detail) {
    return Text('$header: $detail',
        style: TextStyle(
            color: Mystyle().darkcolor,
            fontSize: 15,
            fontWeight: FontWeight.bold));
  }

  Widget adduserbutton() => Column(
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
                        builder: (context) => ScreenEmpoyeeAdd());
                    Navigator.push(context, route)
                        .then((value) => readalluser());
                  },
                  icon: Icon(Icons.person_add),
                  label: Text('เพิ่มผู้ใช้งาน'),
                ),
              ),
            ],
          ),
        ],
      );
  Future<Null> deleteUser(UseraddModel userModels, String header) async {
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
                  String url = '${MyConstant().urlUserDelete}';
                  await Dio()
                      .post(url, data: {'user_id': userModels.empId}).then(
                    (value) {
                      print('DELETE SUCCESS');
                      readalluser();
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
}
