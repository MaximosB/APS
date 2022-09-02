// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
//
// import 'package:acamp_kids/main.dart';
import 'package:intl/intl.dart';

void main() {
  int qtd = 120;
  var now = new DateTime.utc(
      0001, DateTime.november, 1, (qtd / 60).round(), qtd % 60, 0);

  var formatter = new DateFormat('kk:mm');
  String formattedDate = formatter.format(now);
  print(formattedDate);
}
