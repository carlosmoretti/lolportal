import 'package:flutter/material.dart';
import 'package:lolportal/view/config.view.dart';
import 'package:lolportal/view/dashboard.view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        fontFamily: 'Oxygen',
        brightness: Brightness.dark,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blue,
          shape: RoundedRectangleBorder(),
          textTheme: ButtonTextTheme.primary,
        )
        /* dark theme settings */
      ),
      title: 'LOL Portal',
      home: Config(),
      routes: {
        '/config': (context) => Config(),
        '/dashboard': (context) => Dashboard()
      }
    );
  }
}