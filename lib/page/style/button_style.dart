import 'package:flutter/material.dart' as flutter;
import 'package:flutter/material.dart';

class CustomButtonStyle {
  static flutter.ButtonStyle styleLightBlueButton() {
    return flutter.ElevatedButton.styleFrom(
        backgroundColor: const Color(0xffF5FBFF),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(225.0)),
        // shadowColor: const Color(0xff3c7fb4),
        side: const BorderSide(
            width: 2, // the thickness
            color: Color(0xff3c7fb4) // the color of the border
            ));
  }

  static flutter.ButtonStyle styleDarkBlueButton() {
    return flutter.ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff3c7fb4),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(225.0)));
  }
}
