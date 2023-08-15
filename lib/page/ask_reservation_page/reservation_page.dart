import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_service/page/category_list_room_page/category_and_room_page.dart';
import 'package:self_service/page/setting_page.dart';
import 'dart:async';
import 'package:self_service/page/splash_page/splash_screen.dart';
import '../style/button_style.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({Key? key}) : super(key: key);
  static const nameRoute = '/reservation';

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> with RouteAware {
  final RouteObserver<Route> routeObserver = RouteObserver<Route>();
  Timer? _timerMoveSplash;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void initState() {
    _timerMoveSplash = Timer(const Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(
          context, SplashPage.nameRoute, (route) => false);
    });
    super.initState();
  }

  @override
  void dispose() {
    _timerMoveSplash?.cancel();
    routeObserver.unsubscribe(this);
    super.dispose();
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
                      _timerMoveSplash?.cancel();
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
  void didPush() {
    print('manggil 1');
    super.didPush();
    // Action to perform when this page is pushed onto the route stack.
  }

  @override
  void didPopNext() {
        print('manggil 2');
    super.didPopNext();
    // Action to perform when the user returns to this page from another page.
  }

  @override
  void didPop() {
        print('manggil 3');
    super.didPop();
    // Action to perform when the user goes back from this page to the previous page.
  }
}
