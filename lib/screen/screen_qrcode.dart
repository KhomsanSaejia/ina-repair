import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ScreenQRcode extends StatefulWidget {
  // const ScreenQRcode({ Key? key }) : super(key: key);

  @override
  _ScreenQRcodeState createState() => _ScreenQRcodeState();
}

class _ScreenQRcodeState extends State<ScreenQRcode> {
  DateTime dateTime = DateTime.now();
  Timer timer;
  String date;
  String _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
    startTimer();
    dateTime = DateTime.now();
    date =
        "${dateTime.year}/${dateTime.month}/${dateTime.day} - ${dateTime.hour}:${dateTime.minute}:${dateTime.second}";
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          dateTime = DateTime.now();
          date =
              "${dateTime.year}/${dateTime.month}/${dateTime.day} - ${dateTime.hour}:${dateTime.minute}:${dateTime.second}";
          print(date);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: Colors.red.shade200,
        child: Center(
          child: Container(
            // color: Colors.green.shade200,
            width: 300,
            height: 400,
            child: Column(
              children: [
                Container(
                  width: 280,
                  child: QrImage(
                    data: date,
                    version: QrVersions.auto,
                    size: 280.0,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Text(
                  'Scan result : $_scanBarcode\n',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.qr_code_scanner),
      ),
    );
  }
}
