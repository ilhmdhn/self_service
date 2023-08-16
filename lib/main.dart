import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:self_service/page/category_list_room_page/category_and_room_page.dart';
import 'package:self_service/page/register_puppy_club/register_club_page.dart';
import 'package:self_service/page/room_detail_page/room_detail_page.dart';
import 'package:self_service/page/fnb_page.dart';
import 'package:self_service/page/login_member.dart';
import 'package:self_service/page/ask_reservation_page/reservation_page.dart';
import 'package:self_service/page/review_bill_page.dart';
import 'package:self_service/page/setting_page.dart';
import 'package:self_service/page/splash_page/splash_screen.dart';
import 'package:self_service/page/voucher_page.dart';
import 'package:flutter/services.dart';
import 'package:self_service/util/tools.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const SelfService());
}

class SelfService extends StatelessWidget {
  const SelfService({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [routeObserver],
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: SplashPage.nameRoute,
      routes: {
        SplashPage.nameRoute: (context) => const SplashPage(),
        ReservationPage.nameRoute: (context) => const ReservationPage(),
        CategoryAndRoomPage.nameRoute: (context) => CategoryAndRoomPage(),
        RoomDetailPage.nameRoute: (context) => const RoomDetailPage(),
        RegisterClubPage.nameRoute: (context) => const RegisterClubPage(),

        //asdadads
        LoginPage.nameRoute: (context) => LoginPage(),
        FnBPage.nameRoute: (context) => const FnBPage(),
        SettingPage.nameRoute: (context) => const SettingPage(),
        VoucherPage.nameRoute: (context) => VoucherPage(),
        ReviewBillPage.nameRoute: (context) => const ReviewBillPage()
      },
    );
  }
}
