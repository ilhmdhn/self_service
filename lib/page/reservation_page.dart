import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ReservationPage extends StatelessWidget {
  const ReservationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [],
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.check),
            label: Text('Sudah Reservasi'),
          ),
          ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.arrow_circle_right_rounded),
              label: Text('Belum Reservasi'))
        ],
      ),
    );
  }
}
