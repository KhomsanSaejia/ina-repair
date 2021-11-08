import 'package:flutter/material.dart';
import 'package:inapos/screen/screen_history_work.dart';
// import 'package:inapos/screen/screen_homepage.dart';
import 'package:inapos/screen/screen_homepage_2.dart';
import 'package:inapos/screen/screen_in_out_stamp.dart';
import 'package:inapos/screen/screen_out_stock.dart';
import 'package:inapos/screen/screen_station.dart';
import 'package:inapos/screen/screen_stock_contactor_detail.dart';
import 'package:inapos/screen/screen_stock_output_detail.dart';
import 'package:inapos/screen/screen_stock_recieve_detail.dart';
import 'package:inapos/screen/screen_stock_view.dart';
import 'package:inapos/screen/screen_workorder.dart';
import 'package:inapos/utility/mystyle.dart';
import 'package:inapos/utility/sign_out_process.dart';
// import 'package:inapos/widget/th/screen_th_repair_manage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenMainUser extends StatefulWidget {
  @override
  _ScreenMainUserState createState() => _ScreenMainUserState();
}

class _ScreenMainUserState extends State<ScreenMainUser> {
  Widget currentWidget = ScreenHomePage2();
  String nameAppbar;

  String userName, userEmail, userCode;
  @override
  void initState() {
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userName = preferences.getString('userName');
      userEmail = preferences.getString('userEmail');
      userCode = preferences.getString('userCode');
      nameAppbar = 'หน้าหลัก';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('$nameAppbar', style: TextStyle(fontFamily: 'Sarabun')),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list_alt),
            onPressed: () {
              setState(() {
                currentWidget = ScreenHomePage2();
                nameAppbar = 'หน้าหลัก';
              });
            },
          )
        ],
      ),
      drawer: showDrawer(),
      body: currentWidget,
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                showHead(),
                home(),
                managestation(),
                managerepair(),
                historywork(),
                stock(),
                stockrecieve(),
                stockrecievecontractor(),
                stockoutput(),
                stockout(),
                inout(),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                signout(),
              ],
            ),
          ],
        ),
      );
  ListTile stockrecieve() => ListTile(
        leading: Icon(
          Icons.west,
          color: Colors.green,
          size: 30.0,
        ),
        title: Text('รับของเข้า'),
        // onTap: () => Navigator.pop(context),
        onTap: () {
          setState(() {
            currentWidget = ScreenStockReceiveDetail();
            nameAppbar = 'รับของเข้า';
          });
          Navigator.pop(context);
        },
      );
  ListTile stockrecievecontractor() => ListTile(
        leading: Icon(
          Icons.west,
          color: Colors.green,
          size: 30.0,
        ),
        title: Text('ของคืนจากผู้รับเหมา'),
        onTap: () {
          setState(() {
            currentWidget = ScreenStockInputContactorDetail();
            nameAppbar = 'ของคืนจากผู้รับเหมา';
          });
          Navigator.pop(context);
        },
      );
  ListTile stockout() => ListTile(
        leading: Icon(
          Icons.west,
          color: Colors.green,
          size: 30.0,
        ),
        title: Text('ตัดใช้'),
        onTap: () {
          setState(() {
            currentWidget = ScreenOutSctockMenu();
            nameAppbar = 'ตัดใช้';
          });
          Navigator.pop(context);
        },
      );
  ListTile inout() => ListTile(
        leading: Icon(
          Icons.lock_clock,
          color: Colors.green,
          size: 30.0,
        ),
        title: Text('เวลาเข้า-ออก', style: TextStyle(fontFamily: 'Sarabun')),
        onTap: () {
          setState(() {
            currentWidget = ScreenInOutTime();
            nameAppbar = 'เวลาเข้า-ออก';
          });
          Navigator.pop(context);
        },
      );
  ListTile home() => ListTile(
        leading: Icon(
          Icons.home,
          color: Colors.green,
          size: 30.0,
        ),
        title: Text('หน้าหลัก'),
        onTap: () {
          setState(() {
            currentWidget = ScreenHomePage2();
            nameAppbar = 'หน้าหลัก';
          });
          Navigator.pop(context);
        },
        // onTap: () => Navigator.pop(context),
      );
  ListTile managestation() => ListTile(
        leading: Icon(
          Icons.add_business_sharp,
          color: Colors.green,
          size: 30.0,
        ),
        title: Text('จัดการสาขา'),
        // onTap: () => Navigator.pop(context),
        onTap: () {
          setState(() {
            currentWidget = ScreenStation();
            nameAppbar = 'จัดการสาขา';
          });
          Navigator.pop(context);
        },
      );
  ListTile managerepair() => ListTile(
        leading: Icon(
          Icons.print_rounded,
          color: Colors.green,
          size: 30.0,
        ),
        title: Text('งานซ่อม'),
        // onTap: () => Navigator.pop(context),
        onTap: () {
          setState(() {
            // currentWidget = ScreenRepairDashboard();
            currentWidget = ScreenWorkOrder();
            nameAppbar = 'งานซ่อม';
          });
          Navigator.pop(context);
        },
      );
  ListTile historywork() => ListTile(
        leading: Icon(
          Icons.list_alt,
          color: Colors.green,
          size: 30.0,
        ),
        title: Text('ประวัติการเปิดงาน'),
        // onTap: () => Navigator.pop(context),
        onTap: () {
          setState(() {
            currentWidget = ScreenHistoryWork();
            nameAppbar = 'ประวัติการเปิดงาน';
          });
          Navigator.pop(context);
        },
      );
  ListTile stockoutput() => ListTile(
        leading: Icon(
          Icons.east,
          color: Colors.green,
          size: 30.0,
        ),
        title: Text('จ่ายของผู้รับเหมา'),
        // onTap: () => Navigator.pop(context),
        onTap: () {
          setState(() {
            currentWidget = ScreenStockOutputDetail();
            nameAppbar = 'จ่ายของผู้รับเหมา';
          });
          Navigator.pop(context);
        },
      );
  ListTile stock() => ListTile(
        leading: Icon(
          Icons.storage_rounded,
          color: Colors.green,
          size: 30.0,
        ),
        title: Text('ยอดคลังคงเหลือ'),
        // onTap: () => Navigator.pop(context),
        onTap: () {
          setState(() {
            currentWidget = ScreenStockView();
            nameAppbar = 'ยอดคลังคงเหลือ';
          });
          Navigator.pop(context);
        },
      );
  Widget signout() {
    return Container(
      decoration: BoxDecoration(color: Colors.orange.shade700),
      child: ListTile(
        leading: Icon(
          Icons.exit_to_app,
          color: Colors.white,
          size: 30.0,
        ),
        title: Text(
          'ออกจากระบบ',
          style: TextStyle(color: Colors.white),
        ),
        onTap: () =>
            signoutprocess(context, 'คุณต้องการออกจากระบบ', 'ใช่', 'ไม่'),
      ),
    );
  }

  UserAccountsDrawerHeader showHead() {
    return UserAccountsDrawerHeader(
        // margin: EdgeInsets.all(20.0),
        // decoration: Mystyle().myboxdecoration('cover-shop.jpg'),
        currentAccountPicture: Mystyle().showLogo2(userCode),

        // accountName: Text('User : Admin Admin Login'),
        accountName: Text(userName == null
            ? 'Login : Admin Innoligent'
            : 'ผู้ใช้งาน : $userName'),
        accountEmail: Text('$userEmail'));
  }
}
