import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

Future<void> delay(Duration duration) async {
  await Future.delayed(duration);
}

void showToastWarning(String text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.yellow.shade800,
      textColor: Colors.white,
      fontSize: 16.0);
}
