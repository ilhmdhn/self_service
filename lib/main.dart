import 'package:flutter/material.dart';
import 'package:self_service/page/reservation_page.dart';
import 'package:self_service/page/room_category_page.dart';
import 'package:self_service/page/room_list_page.dart';
import 'package:self_service/page/splash_screen.dart';

void main() {
  runApp(const SelfService());
}

class SelfService extends StatelessWidget {
  const SelfService({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashPage(),
        '/reservation': (context) => const ReservationPage(),
        '/room-category': (context) => const RoomCategoryPage(),
        '/room-list': (context) => const RoomListPage(),
      },
    );
  }
}
