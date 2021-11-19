import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inapos/model/user_model.dart';
import 'package:inapos/screen/screen_main_user.dart';
import 'package:inapos/screen/screen_main_admin.dart';
import 'package:inapos/utility/dialog.dart';
import 'package:inapos/utility/my_constant.dart';
import 'package:inapos/utility/mystyle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenLogin extends StatefulWidget {
  @override
  _ScreenLoginState createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  String user, password;
  void initState() {
    super.initState();
    checkPreference();
  }

  Future<Null> checkPreference() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String chooseType = preferences.getString('userPosition');
      print(chooseType);
      if (chooseType != null && chooseType.isNotEmpty) {
        if (chooseType == 'MD' || chooseType == 'GM' || chooseType == 'Chief') {
          routetoservice2(ScreenMainAdmin());
        } else if (chooseType == 'Staff') {
          routetoservice2(ScreenMainUser());
        } else {
          normalDialog(context, 'กรุณาลองใหม่อีกครั้งค่ะ');
        }
      }
    } catch (e) {
      normalDialog(context, e);
    }
  }

  void routetoservice2(Widget myWidget) {
    MaterialPageRoute route = MaterialPageRoute(builder: (context) => myWidget);
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: buttonedituser(),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: <Color>[Colors.white, Colors.indigoAccent.shade100],
                radius: 1.0,
                center: Alignment(0, -0.3),
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Mystyle().showLogo(),
                    Mystyle().mySizeBox(),
                    Mystyle().showTitle('Innoligent Automation Co., Ltd.'),
                    Mystyle().mySizeBox(),
                    screenloginTHuserform(),
                    Mystyle().mySizeBox(),
                    screenloginTHpasswordform(),
                    Mystyle().mySizeBox(),
                    screenloginTHbutton(),
                  ],
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: version(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<Null> checkAuthen() async {
    String url = '${MyConstant().urlUserCheck}';
    try {
      Response response = await Dio().post(url, data: {'user': user});
      print('response = $response');
      if (response.data == 'USE THIS USERNAME') {
        normalDialog(context, "ชื่อผู้ใช้งาน หรือ รหัสผ่าน ไม่ถูกต้อง");
      } else {
        for (var map in response.data) {
          print(map);
          UserModel userModel = UserModel.fromJson(map);
          if (password == userModel.empPassword) {
            String chooseType = userModel.empPosition;
            if (chooseType == 'MD' ||
                chooseType == 'GM' ||
                chooseType == 'Chief') {
              routetoservice(ScreenMainAdmin(), userModel);
            } else if (chooseType == 'Staff') {
              routetoservice(ScreenMainUser(), userModel);
            } else {
              normalDialog(context, 'ชื่อผู้ใช้งาน หรือ รหัสผ่าน ไม่ถูกต้อง');
            }
          } else {
            normalDialog(context, "ชื่อผู้ใช้งาน หรือ รหัสผ่าน ไม่ถูกต้อง");
          }
        }
      }
    } catch (e) {
      normalDialog(context,
          "ไม่สามารถเชื่อมต่อกับ Server ได้ กรุณาติดต่อผู้ดูแลระบบ $e");
    }
  }

  Future<Null> routetoservice(Widget myWidget, UserModel userModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('username', userModel.empUsername);
    preferences.setString('password', userModel.empPassword);
    preferences.setString('userPosition', userModel.empPosition);
    preferences.setString('userName', userModel.empName);
    preferences.setString('userEmail', userModel.empEmail);
    preferences.setString('userCode', userModel.empCode);
    MaterialPageRoute route = MaterialPageRoute(builder: (context) => myWidget);
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Widget screenloginTHbutton() => Container(
      // alignment: Alignment.center,
      height: 50,
      width: 250.0,
      child: ElevatedButton(
        // color: Mystyle().darkcolor,
        onPressed: () {
          print('username = $user , password = $password');
          if (user == null ||
              user.isEmpty ||
              password == null ||
              password.isEmpty) {
            normalDialog(context, "กรุณากรอกข้อมูลให้ครบ");
          } else {
            checkAuthen();
          }
        },
        child: Text(
          'เข้าสู่ระบบ',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'Sarabun'),
        ),
      ));
  Widget screenloginTHuserform() => Container(
        width: 250.0,
        child: TextField(
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30, fontFamily: 'Sarabun'),
          onChanged: (value) => user = value.trim(),
          // obscureText: true,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_circle,
            ),
            labelStyle: TextStyle(
                // color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Sarabun'),
            labelText: 'ชื่อผู้ใช้งาน : ',
          ),
        ),
      );
  Widget screenloginTHpasswordform() => Container(
        width: 250.0,
        child: TextField(
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30, fontFamily: 'Sarabun'),
          onChanged: (value) => password = value.trim(),
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
            ),
            labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Sarabun'),
            labelText: 'รหัสผ่าน : ',
          ),
        ),
      );
  Widget version() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Mystyle().mySizeBox(),
          Text(
            'v 0.1.8.2 on 2564-11-17',
            style: TextStyle(color: Mystyle().darkcolor),
          ),
          Mystyle().mySizeBox(),
          // Text(
          //   'MOBILE',
          //   style: TextStyle(color: Mystyle().darkcolor),
          // ),
          // Text(
          //   'EMU',
          //   style: TextStyle(color: Mystyle().darkcolor),
          // ),
          Text(
            'WEB APP',
            style: TextStyle(color: Mystyle().darkcolor),
          ),
        ],
      );
}
