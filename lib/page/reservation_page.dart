import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:self_service/page/splash_screen.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});
  static const nameRoute = '/reservation';

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  Timer? _timerMoveSplash;

  @override
  void initState() {
    super.initState();
    _timerMoveSplash = Timer(const Duration(seconds: 30), () {
      Navigator.pushNamedAndRemoveUntil(
          context, SplashPage.nameRoute, (route) => false);
    });
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
                  width: 145,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffF5FBFF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(225.0)),
                        // shadowColor: const Color(0xff3c7fb4),
                        side: const BorderSide(
                            width: 2, // the thickness
                            color: Color(0xff3c7fb4) // the color of the border
                            )),
                    child: Text(
                      'NO',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                          color: const Color(0xff3c7fb4)),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 95,
                ),
                SizedBox(
                  width: 145,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
          context, SplashPage.nameRoute, (route) => false);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff3c7fb4),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(225.0))),
                    child: Text(
                      'YES',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
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
    _timerMoveSplash?.cancel();
    super.dispose();
  }
}
