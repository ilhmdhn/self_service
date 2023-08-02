import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_service/page/category_list_room_page/category_and_room_page.dart';
import 'package:self_service/page/setting_page.dart';
import 'dart:async';
import 'package:self_service/page/splash_page/splash_screen.dart';
import '../style/button_style.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});
  static const nameRoute = '/reservation';

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  // Timer? _timerMoveSplash;

  @override
  void initState() {
    //     _timerMoveSplash = Timer(const Duration(seconds: 30), () {
    //   // _timerMoveSplash?.cancel();
    //   Navigator.pushNamedAndRemoveUntil(
    //       context, SplashPage.nameRoute, (route) => false);
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'assets/images/background_reservation_page.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            bottom: 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 125,
                  height: 36,
                  child: ElevatedButton(
                    onPressed: () {
                      // _timerMoveSplash?.cancel();
                      Navigator.pushNamed(
                          context, CategoryAndRoomPage.nameRoute);
                    },
                    style: CustomButtonStyle.styleLightBlueButton(),
                    child: Text(
                      'NO',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                          color: const Color(0xff3c7fb4)),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 35,
                ),
                SizedBox(
                  width: 125,
                  height: 36,
                  child: ElevatedButton(
                    onPressed: () {},
                    onLongPress: () {
                      // _timerMoveSplash?.cancel();
                      Navigator.pushNamed(context, SettingPage.nameRoute);
                    },
                    style: CustomButtonStyle.styleDarkBlueButton(),
                    child: Text(
                      'YES',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                          color: const Color(0xffF5FBFF)),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    // _timerMoveSplash?.cancel();
    super.dispose();
  }
}
