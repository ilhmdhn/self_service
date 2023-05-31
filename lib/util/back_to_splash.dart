import 'package:flutter/material.dart';
import 'package:self_service/page/splash_screen.dart';

class BackToSplash {
  void backToSplash(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, SplashPage.nameRoute, (route) => false);
  }
}
