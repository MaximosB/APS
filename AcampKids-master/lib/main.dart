import 'package:acamp_kids/config.dart';
import 'package:flutter/material.dart';
import 'checkOut.dart';

void main() async {
  await initConfigurations();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Login UI',
        debugShowCheckedModeBanner: false,
        home: CheckAuth());
  }
}


