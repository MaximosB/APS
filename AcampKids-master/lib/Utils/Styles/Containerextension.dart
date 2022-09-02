import "package:flutter/material.dart";
import 'package:acamp_kids/Utils/style_login.dart';

Widget containerTextField(dynamic controller, TextInputType type,
    String hintText, IconData iconData) {
  return Container(
    alignment: Alignment.centerLeft,
    decoration: kBoxDecorationStyle,
    height: 51.0,
    width: 170,
    child: TextFormField(
      controller: controller,
      keyboardType: type,
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'OpenSans',
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.only(top: 14.0),
        prefixIcon: Icon(
          iconData,
          color: Color(0xFFCDCDE3),
        ),
        hintText: hintText,
        hintStyle: kHintTextStyle,
      ),
    ),
  );
}
