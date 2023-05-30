import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:self_service/page/fnb_page.dart';
import 'package:self_service/page/login_member.dart';
import 'package:self_service/page/reservation_page.dart';
import 'package:self_service/page/review_bill_page.dart';
import 'package:self_service/page/room_category_page.dart';
import 'package:self_service/page/room_detail_page.dart';
import 'package:self_service/page/room_list_page.dart';
import 'package:self_service/page/setting_page.dart';
import 'package:self_service/page/splash_screen.dart';
import 'package:self_service/page/voucher_page.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const SelfService());
}

class SelfService extends StatelessWidget {
  const SelfService({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
      initialRoute: SplashPage.nameRoute,
      routes: {
        SplashPage.nameRoute: (context) => const SplashPage(),
        ReservationPage.nameRoute: (context) => const ReservationPage(),
        LoginPage.nameRoute: (context) => LoginPage(),
        RoomCategoryPage.nameRoute: (context) => RoomCategoryPage(),
        RoomListPage.nameRoute: (context) => RoomListPage(),
        RoomDetailPage.nameRoute: (context) => RoomDetailPage(),
        FnBPage.nameRoute: (context) => const FnBPage(),
        SettingPage.nameRoute: (context) => const SettingPage(),
        VoucherPage.nameRoute: (context) => VoucherPage(),
        ReviewBillPage.nameRoute: (context) => const ReviewBillPage()
      },
    );
  }
}
