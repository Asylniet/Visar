import 'package:flutter/material.dart';
import 'colors.dart';
import 'package:visar/screens/homeScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: white,
        accentColor: blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: 15),
          headline1: TextStyle(fontSize: 26),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
