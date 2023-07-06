import 'package:flutter/material.dart';
import 'package:self_service/page/ask_reservation_page/reservation_page.dart';
import 'package:video_player/video_player.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const nameRoute = '/splash';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with AutomaticKeepAliveClientMixin<SplashPage> {
  late VideoPlayerController _videoWelcomeController;

  @override
  void initState() {
    super.initState();
    _videoWelcomeController =
        VideoPlayerController.asset('assets/video/welcome.mp4')
          ..setLooping(true)
          ..initialize().then((_) => setState(() {}))
          ..play();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(ReservationPage.nameRoute);
            },
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[VideoPlayer(_videoWelcomeController)],
              ),
            )),
      ),
    );
  }

  @override
  void dispose() {
    _videoWelcomeController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
