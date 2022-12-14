import 'package:flutter/material.dart';
import 'package:self_service/page/reservation_page.dart';
import 'package:self_service/page/room_category_page.dart';
import 'package:self_service/page/room_detail_page.dart';
import 'package:self_service/page/room_list_page.dart';
import 'package:self_service/page/splash_screen.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
      size: Size(1366, 768),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
      fullScreen: true);
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

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
        '/room-category': (context) => RoomCategoryPage(),
        '/room-list': (context) => RoomListPage(),
        '/room-detail': (context) => RoomDetailPage(),
      },
    );
  }
}
