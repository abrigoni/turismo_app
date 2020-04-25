import 'package:flutter/material.dart';
import 'package:turismoapp/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Turismo App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: HomePage.ROUTENAME,
        routes: {
          HomePage.ROUTENAME: (BuildContext context) => HomePage(),
        }
        );
  }
}
