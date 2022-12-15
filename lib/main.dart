import 'package:flutter/material.dart';
import 'package:self_service/page/fnb_category_page.dart';
import 'package:self_service/page/reservation_page.dart';
import 'package:self_service/page/room_category_page.dart';
import 'package:self_service/page/room_detail_page.dart';
import 'package:self_service/page/room_list_page.dart';
import 'package:self_service/page/splash_screen.dart';
import 'package:flutter/services.dart';

void main() async {
  runApp(const SelfService());
}

class SelfService extends StatelessWidget {
  const SelfService({super.key});

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return MaterialApp(
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashPage(),
        '/reservation': (context) => const ReservationPage(),
        '/room-category': (context) => RoomCategoryPage(),
        '/room-list': (context) => RoomListPage(),
        '/room-detail': (context) => RoomDetailPage(),
        '/fnb-category': (context) => const FnbCategoryPage(),
      },
    );
  }
}
