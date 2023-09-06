import 'package:flutter/material.dart';

class FnBOrderOfferingPage extends StatelessWidget {
  const FnBOrderOfferingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            bottom: 0,
            child: Image.asset('assets/images/background_reservation_scan.jpg',
              width: double.infinity,
              height: double.infinity,))
        ],
      ),
    );
  }
}