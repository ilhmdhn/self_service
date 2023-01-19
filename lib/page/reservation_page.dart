import 'package:flutter/material.dart';
import 'package:self_service/page/login_member.dart';
import 'package:self_service/page/setting_page.dart';

class ReservationPage extends StatelessWidget {
  const ReservationPage({super.key});
  static const nameRoute = '/reservation';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              // children: [],
            ),
            ElevatedButton.icon(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.fromLTRB(10, 20, 10, 20)),
              ),
              icon: const Icon(Icons.check),
              label: const Text(
                'Sudah Reservasi',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 5),
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed(LoginPage.nameRoute);
                },
                onLongPress: () {
                  Navigator.of(context).pushNamed(SettingPage.nameRoute);
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blueAccent),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.fromLTRB(10, 20, 10, 20)),
                ),
                icon: const Icon(Icons.input_sharp),
                label: const Text(
                  'Belum Reservasi',
                  style: TextStyle(fontSize: 18),
                ))
          ],
        ),
      ),
    );
  }
}
