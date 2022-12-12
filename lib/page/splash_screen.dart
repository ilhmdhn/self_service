import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed('/reservation');
          },
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(2, 60, 194, 1.000),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      'images/happy_puppy_text.png',
                      width: 250,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'GROUP',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'SELF SERVICE',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const Text(
                  'SELAMAT DATANG',
                  style: TextStyle(fontSize: 45, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                Image.asset('images/image_singing.png')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
