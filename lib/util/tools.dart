import 'package:flutter/material.dart';

RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

Future<void> delay(Duration duration) async {
  await Future.delayed(duration);
}
