import 'package:flutter/material.dart';

class CustomColorStyle {
  static Color bluePrimary() {
    return const Color(0xff56a2de);
  }

  static Color lightBlue() {
    return const Color(0xfff6fbff);
  }

  static Color darkBlue() {
    return const Color(0xff3c7fb4);
  }

  static Color blackText() {
    return const Color(0xff36343f);
  }

  static Color blueText() {
    return CustomColorStyle().hexToColor('#3A5CA1');
  }

  static Color blueLight() {
    return CustomColorStyle().hexToColor('#3C7FB4');
  }

  Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
