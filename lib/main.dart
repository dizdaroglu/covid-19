import 'package:covid_19/UI/screens/home_screen.dart';
import 'package:covid_19/UI/screens/second_screen.dart';
import 'package:covid_19/UI/shared/constants/color_constants.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white, fontFamily: "NotoSans"),
        debugShowCheckedModeBanner: false,
        home: HomeScreen());
  }
}
