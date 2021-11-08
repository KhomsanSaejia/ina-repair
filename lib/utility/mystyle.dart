import 'package:flutter/material.dart';

class Mystyle {
  Color darkcolor = Colors.blue.shade900;
  Color primarycolor = Colors.green.shade300;
  Color searchbox = Colors.grey.shade300;

  SizedBox mySizeBox() => SizedBox(
        width: 10.0,
        height: 10.0,
      );
  Widget titleCenter(BuildContext context, String string) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Text(
          string,
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Text showTitle(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.blue.shade900,
          fontWeight: FontWeight.bold,
        ),
      );

  Text showTitleH2(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 15,
          color: Colors.blue.shade900,
          fontWeight: FontWeight.bold,
          fontFamily: 'Sarabun',
        ),
      );
  Text sarabun(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 15,
          // color: Colors.blue.shade900,
          fontWeight: FontWeight.bold,
          fontFamily: 'Sarabun',
        ),
      );
  Text sarabuntext(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 20,
          color: Colors.green.shade900,
          fontWeight: FontWeight.bold,
          fontFamily: 'Sarabun',
        ),
      );
  Text sarabunTitle(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 15,
          color: Colors.red.shade400,
          fontWeight: FontWeight.bold,
          fontFamily: 'Sarabun',
        ),
      );
  Widget sarabunBody(String title) => Flexible(
        child: Text(
          title,
          maxLines: 10,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 15,
            color: Colors.green.shade800,
            fontWeight: FontWeight.bold,
            fontFamily: 'Sarabun',
          ),
        ),
      );
  Text showTitleCustom(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 18,
            color: Colors.blue.shade900,
            fontWeight: FontWeight.bold,
            fontFamily: 'Sarabun'),
      );
  Text showTitleCustom2(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 15,
            color: Colors.blue.shade900,
            fontWeight: FontWeight.bold,
            fontFamily: 'Sarabun'),
      );
  Text showTitleH3(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.blue.shade900,
          fontWeight: FontWeight.bold,
        ),
      );

  Container showLogo() {
    return Container(
      width: 100.0,
      child: Image.asset('images/INA-LOGO.png'),
    );
  }

  Container showLogo2(String pathimage) {
    return Container(
      width: 100.0,
      child: Image.asset('images/emp/$pathimage.png'),
    );
  }
  Text textHeader(String data) {
    return Text(
      data,
      style: const TextStyle(
          fontFamily: "Sarabun", fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
  Widget textCustom(String _data, double _size, Color _color) {
    return Text(
      _data,
      style: TextStyle(
          fontFamily: "Sarabun",
          fontSize: _size,
          fontWeight: FontWeight.bold,
          color: _color),
    );
  }

  BoxDecoration myboxdecoration(String pathimage) {
    return BoxDecoration(
      image: DecorationImage(
          image: AssetImage('images/$pathimage'), fit: BoxFit.cover),
    );
  }

  Widget showprogress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Mystyle();
}
