import 'package:flutter/material.dart';
import 'package:flutter_app_try/src/loginPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;



    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}