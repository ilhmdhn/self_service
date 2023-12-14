import 'package:flutter/material.dart' as flutter;
import 'package:flutter/material.dart';
import 'package:self_service/page/style/color_style.dart';

class CustomButtonStyle {
  static flutter.ButtonStyle styleLightBlueButton() {
    return flutter.ElevatedButton.styleFrom(
        backgroundColor: const Color(0xffF5FBFF),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(225.0)),
        // shadowColor: const Color(0xff3c7fb4),
        side: const BorderSide(
            width: 1.2, // the thickness
            color: Color(0xff3c7fb4) // the color of the border
            ));
  }

  static flutter.ButtonStyle styleDarkBlueButton() {
    return flutter.ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff3c7fb4),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(225.0)));
  }

  static flutter.ButtonStyle buttonStyleRoundedBlueTrans() {
    return flutter.ElevatedButton.styleFrom(
        backgroundColor: CustomColorStyle.lightBlue(),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(225.0)),
        side: BorderSide(color: CustomColorStyle.blueLight(), width: 1.3));
  }

  static flutter.ButtonStyle buttonStyleDarkBlue() {
    return flutter.ElevatedButton.styleFrom(
        backgroundColor: CustomColorStyle.darkBlue(),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(225.0)),
        side: BorderSide(color: CustomColorStyle.blueLight(), width: 2.0));
  }

  static flutter.ButtonStyle buttonBlueLight() {
    return flutter.ElevatedButton.styleFrom(
        backgroundColor: CustomColorStyle.lightBlue3(),
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(225.0)),
        side: BorderSide(width: 0, color: CustomColorStyle.lightBlue3())
        // side: BorderSide(color: CustomColorStyle.blueLight(), width: 2.0)
        );
  }

  static flutter.ButtonStyle buttonStyleDarkBlueDisable() {
    return flutter.ElevatedButton.styleFrom(
        backgroundColor: Colors.grey.shade400,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(225.0)),
        side: BorderSide(color: Colors.grey.shade500, width: 2.0));
  }

  static flutter.ButtonStyle confirm() {
    return flutter.ElevatedButton.styleFrom(
        backgroundColor: CustomColorStyle.darkBlue(),
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(125.0)),
        side: BorderSide(color: CustomColorStyle.blueLight(), width: 2.0));
  }

  static flutter.ButtonStyle cancel() {
    return flutter.ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(125.0)),);
  }

  static flutter.ButtonStyle white() {
    return flutter.ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(125.0)),
        side: BorderSide(color: CustomColorStyle.blueLight(), width: 1.3));
  }
}