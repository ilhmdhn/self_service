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


DateTime convertToEndTime(String startTime) {
  // Parsing waktu awal
  List<String> startTimeParts = startTime.split(':');
  int startHour = int.parse(startTimeParts[0]);
  int startMinute = int.parse(startTimeParts[1]);
  int startSecond = int.parse(startTimeParts[2]);

  // Membuat objek DateTime dari waktu awal
  DateTime startDateTime = DateTime(0, 1, 1, startHour, startMinute, startSecond);

  // Menambahkan durasi hingga pukul 23:59:59
  DateTime endDateTime = startDateTime.add(Duration(hours: 23 - startHour, minutes: 59 - startMinute, seconds: 59 - startSecond));

  return endDateTime;
}