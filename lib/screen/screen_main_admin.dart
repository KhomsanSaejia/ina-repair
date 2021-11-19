import 'package:flutter/material.dart';
import 'package:inapos/screen/screen_history_work2.dart';
import 'package:inapos/utility/mystyle.dart';
import 'package:inapos/utility/sign_out_process.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screen_employee.dart';
import 'screen_history_work.dart';
import 'screen_homepage_2.dart';
import 'screen_in_out_patui.dart';
import 'screen_in_out_patui_mobile.dart';
import 'screen_in_out_stamp.dart';
import 'screen_out_stock.dart';
import 'screen_station.dart';
import 'screen_stock.dart';
import 'screen_stock_contactor_detail.dart';
import 'screen_stock_output_detail.dart';
import 'screen_stock_recieve_detail.dart';
import 'screen_stock_view2.dart';
import 'screen_workorder.dart';

class ScreenMainAdmin extends StatefulWidget {
  @override
  _ScreenMainAdminState createState() => _ScreenMainAdminState();
}

class _ScreenMainAdminState extends State<ScreenMainAdmin> {
  Widget currentWidget = ScreenHomePage2();
  // Widget currentWidget = ScreenHome();
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
                // currentWidget = ScreenHome();
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
                manageuser(),
                historywork(),
                stock(),
                invertory(),
                stockrecieve(),
                stockrecievecontractor(),
                stockoutput(),
                stockout(),
                inout(),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                signout(),
              ],
            ),
          ],
        ),
      );

  ListTile home() => ListTile(
        leading: Icon(
          Icons.home,
          color: Colors.green,
          size: 30.0,
        ),
        title: Text(
          'หน้าหลัก',
          style: TextStyle(fontFamily: 'Sarabun'),
        ),
        onTap: () {
          setState(() {
            // currentWidget = ScreenHome();
            currentWidget = ScreenHomePage2();
            nameAppbar = 'หน้าหลัก';
          });
          Navigator.pop(context);
        },
        // onTap: () => Navigator.pop(context),
      );
  ListTile managestation() => ListTile(
        leading: Icon(
          Icons.add_location_alt_outlined,
          color: Colors.green,
          size: 30.0,
        ),
        title: Text('จัดการสาขา', style: TextStyle(fontFamily: 'Sarabun')),
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
        title: Text('งานซ่อม', style: TextStyle(fontFamily: 'Sarabun')),
        // onTap: () => Navigator.pop(context),
        onTap: () {
          setState(() {
            currentWidget = ScreenWorkOrder();
            nameAppbar = 'งานซ่อม';
          });
          Navigator.pop(context);
        },
      );
  ListTile manageuser() => ListTile(
        leading: Icon(
          Icons.people_alt_rounded,
          color: Colors.green,
          size: 30.0,
        ),
        title: Text('จัดการพนักงาน', style: TextStyle(fontFamily: 'Sarabun')),
        onTap: () {
          setState(() {
            currentWidget = ScreenEmployee();
            nameAppbar = 'จัดการพนักงาน';
          });
          Navigator.pop(context);
        },
        // onTap: () => Navigator.pop(context),
      );
  ListTile historywork() => ListTile(
        leading: Icon(
          Icons.list_alt,
          color: Colors.green,
          size: 30.0,
        ),
        title:
            Text('ประวัติการเปิดงาน', style: TextStyle(fontFamily: 'Sarabun')),
        // onTap: () => Navigator.pop(context),
        onTap: () {
          setState(() {
            currentWidget = ScreenHistoryWork();
            // currentWidget = ScreenHistoryWork2();
            nameAppbar = 'ประวัติการเปิดงาน';
          });
          Navigator.pop(context);
        },
      );
  ListTile stock() => ListTile(
        leading: Icon(
          Icons.store,
          color: Colors.green,
          size: 30.0,
        ),
        title:
            Text('เพิ่มข้อมูลอุปกรณ์', style: TextStyle(fontFamily: 'Sarabun')),
        // onTap: () => Navigator.pop(context),
        onTap: () {
          setState(() {
            currentWidget = ScreenStock();
            nameAppbar = 'เพิ่มข้อมูลอุปกรณ์';
          });
          Navigator.pop(context);
        },
      );
  ListTile invertory() => ListTile(
        leading: Icon(
          Icons.storage_rounded,
          color: Colors.green,
          size: 30.0,
        ),
        title: Text('ยอดคลังคงเหลือ', style: TextStyle(fontFamily: 'Sarabun')),
        // onTap: () => Navigator.pop(context),
        onTap: () {
          setState(() {
            // currentWidget = ScreenStockView();
            currentWidget = ScreenStockView2();
            nameAppbar = 'ยอดคลังคงเหลือ';
          });
          Navigator.pop(context);
        },
      );
  ListTile stockrecieve() => ListTile(
        leading: Icon(
          Icons.west,
          color: Colors.green,
          size: 30.0,
        ),
        title: Text('รับของเข้า', style: TextStyle(fontFamily: 'Sarabun')),
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
        title: Text('ของคืนจากผู้รับเหมา',
            style: TextStyle(fontFamily: 'Sarabun')),
        onTap: () {
          setState(() {
            currentWidget = ScreenStockInputContactorDetail();
            nameAppbar = 'ของคืนจากผู้รับเหมา';
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
        title:
            Text('จ่ายของผู้รับเหมา', style: TextStyle(fontFamily: 'Sarabun')),
        // onTap: () => Navigator.pop(context),
        onTap: () {
          setState(() {
            currentWidget = ScreenStockOutputDetail();
            nameAppbar = 'จ่ายของผู้รับเหมา';
          });
          Navigator.pop(context);
        },
      );
  ListTile stockout() => ListTile(
        leading: Icon(
          Icons.east,
          color: Colors.green,
          size: 30.0,
        ),
        title: Text('ตัดใช้', style: TextStyle(fontFamily: 'Sarabun')),
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
            if (userCode == "62000611" &&
                MediaQuery.of(context).size.width > 700) {
              currentWidget = ScreenInOutPatui();
            } else if (userCode == "62000611" &&
                MediaQuery.of(context).size.width < 700) {
              currentWidget = ScreenInOutPatuiMobile();
            } else {
              currentWidget = ScreenInOutTime();
            }
            nameAppbar = 'เวลาเข้า-ออก';
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
          style: TextStyle(color: Colors.white, fontFamily: 'Sarabun'),
        ),
        onTap: () =>
            signoutprocess(context, 'คุณต้องการออกจากระบบ', 'ใช่', 'ไม่'),
      ),
    );
  }

  UserAccountsDrawerHeader showHead() {
    return UserAccountsDrawerHeader(
        currentAccountPicture: Mystyle().showLogo2(userCode),
        accountName: Text(
            userName == null
                ? 'Login : Admin Innoligent'
                : 'ผู้ใช้งาน : $userName',
            style: TextStyle(fontFamily: 'Sarabun')),
        accountEmail:
            Text('$userEmail', style: TextStyle(fontFamily: 'Sarabun')));
  }
}
