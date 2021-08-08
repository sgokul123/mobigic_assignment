import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomColor {
  static Color colorWhite = Color(0xFFFFFFFF);
  static Color redDark = Color(0xFFFF0000);
  static Color colorAppBG = Color(0xFFE4E4E4);
  static Color labelBlack = Color(0xFF000000);
  static Color textColorPrimary = Color(0xFF000000);
  static Color borderGrey = Color(0xFFa8a8a8);
  static Color borderDarkGrey = Color(0xFF696969);
  static Color btnDisableColor = Color(0xFFD2D7DD);
  static Color darkGrey = Colors.grey[500];
  static Color fieldErrorTextColor = Colors.red[800];
  static Color screenBackgroundColor = Colors.grey[300];
  static Color tabUnselectedColor = Colors.white60;
  static Color lightGreyColor = Color(0xFFE4E4E4);
  static Color appPrimaryColor = Colors.blueAccent[200];
  static Color appSecondaryColor = Colors.blueAccent[100];
  static Color deepPurple = Color(0xFF0740E8);
  static Color deepGreen = Color(0xFF56E807);
  static Color orange = Color(0xFFEEB036);
  static Color redOrange = Color(0xD0C6560D);


  static  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

}
