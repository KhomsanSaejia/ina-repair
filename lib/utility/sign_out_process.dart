import 'package:flutter/material.dart';
import 'package:inapos/screen/screen_login.dart';
import 'package:inapos/utility/mystyle.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Null> signoutprocess(
    BuildContext context, String header, String confirm, String cancel) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: Mystyle().showTitleH2(header),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.clear();
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (context) => ScreenLogin(),
                );
                Navigator.pushAndRemoveUntil(context, route, (route) => false);
              },
              child: Text(confirm),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text(cancel),
            ),
          ],
        )
      ],
    ),
  );
}
