import 'package:flutter/material.dart';

class CustomColorStyle {
  static Color bluePrimary() {
    return CustomColorStyle().hexToColor('#56a2de');
  }

  static Color lightBlue() {
    return CustomColorStyle().hexToColor('#F5FBFF');
  }

  static Color lightBlue2() {
    return CustomColorStyle().hexToColor('#e6f2ff');
  }

  static Color lightBlue3() {
    return CustomColorStyle().hexToColor('#e6f2ff');
  }

  static Color darkBlue() {
    return CustomColorStyle().hexToColor('#3C7FB4');
  }

  static Color blueQrisBg() {
    return CustomColorStyle().hexToColor('#0577fe');
  }

  static Color lightGrey() {
    return CustomColorStyle().hexToColor('#e9e9e9');
  }

  static Color blackText() {
    return const Color(0xff36343f);
  }

  static Color transparent() {
    return const Color.fromRGBO(225, 255, 255, 0);
  }

  static Color blueText() {
    return CustomColorStyle().hexToColor('#3A5CA1');
  }

  static Color darkRed() {
    return CustomColorStyle().hexToColor('#AD0000');
  }

  static Color darkGrey() {
    return CustomColorStyle().hexToColor('#9DA2B0');
  }

  static Color blueLight() {
    return CustomColorStyle().hexToColor('#3C7FB4');
  }

  Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
