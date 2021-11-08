import 'package:flutter/material.dart';
import 'package:inapos/screen/screen_lading.dart';
import 'package:inapos/screen/screen_lightpipe.dart';
import 'package:inapos/screen/screen_out_stock_pos_detail.dart';
import 'package:inapos/screen/screen_pm.dart';
import 'package:inapos/utility/mystyle.dart';

class ScreenOutSctockMenu extends StatefulWidget {
  @override
  _ScreenOutSctockMenuState createState() => _ScreenOutSctockMenuState();
}

class _ScreenOutSctockMenuState extends State<ScreenOutSctockMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            menupipe(),
            Mystyle().mySizeBox(),
            menupos(),
            Mystyle().mySizeBox(),
            menucutstock(),
            Mystyle().mySizeBox(),
            menupm()
            // Text('data'),
          ],
        ),
      ),
    );
  }

  Widget menupipe() => Container(
        alignment: Alignment.center,
        // color: Colors.amber.shade300,
        child: Card(
          color: Colors.amber,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 20,
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              MaterialPageRoute route =
                  MaterialPageRoute(builder: (context) => ScreenLightPipe());
              Navigator.push(context, route).then((value) {});
            },
            child: Container(
              alignment: Alignment.center,
              height: 60,
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                'งาน เดินท่อไฟ',
                style: TextStyle(
                  color: Colors.indigo,
                  fontFamily: 'Sarabun',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      );
  Widget menupos() => Container(
        alignment: Alignment.center,
        // color: Colors.amber.shade300,
        child: Card(
          color: Colors.amber,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 20,
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              MaterialPageRoute route = MaterialPageRoute(
                  builder: (context) => ScreenOutStockPosDetail());
              Navigator.push(context, route).then((value) {});
            },
            child: Container(
              alignment: Alignment.center,
              height: 60,
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                'งาน ติดตั้ง POS',
                style: TextStyle(
                  color: Colors.indigo,
                  fontFamily: 'Sarabun',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      );
  Widget menucutstock() => Container(
        alignment: Alignment.center,
        // color: Colors.amber.shade300,
        child: Card(
          color: Colors.amber,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 20,
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              MaterialPageRoute route =
                  MaterialPageRoute(builder: (context) => ScreenLading());
              Navigator.push(context, route).then((value) {});
            },
            child: Container(
              alignment: Alignment.center,
              height: 60,
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                'งาน เบิกใช้',
                style: TextStyle(
                  color: Colors.indigo,
                  fontFamily: 'Sarabun',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      );
  Widget menupm() => Container(
        alignment: Alignment.center,
        // color: Colors.amber.shade300,
        child: Card(
          color: Colors.amber,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 20,
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              MaterialPageRoute route =
                  MaterialPageRoute(builder: (context) => ScreenPmDetail());
              Navigator.push(context, route).then((value) {});
            },
            child: Container(
              alignment: Alignment.center,
              height: 60,
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                'งาน PM',
                style: TextStyle(
                  color: Colors.indigo,
                  fontFamily: 'Sarabun',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      );
}
