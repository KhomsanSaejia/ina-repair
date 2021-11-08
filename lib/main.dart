import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inapos/screen/screen_login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    Myapp(),
  );
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      title: 'INA REPAIR SYSTEM',
      home: ScreenLogin(),
      debugShowCheckedModeBanner: false,
    );
  }
}
