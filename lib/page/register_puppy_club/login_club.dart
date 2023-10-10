import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_service/page/splash_page/splash_screen.dart';
import 'package:self_service/page/style/color_style.dart';
import 'package:self_service/util/order_args.dart';

class ScanClubPage extends StatefulWidget {
  const ScanClubPage({super.key});

  static const nameRoute = '/scan-club-page';

  @override
  State<ScanClubPage> createState() => ScanClubPageState();
}

class ScanClubPageState extends State<ScanClubPage> {
  @override
  Widget build(BuildContext context) {
    OrderArgs orderArgs = OrderArgs();
    return Scaffold(
      backgroundColor: CustomColorStyle.lightBlue(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context, orderArgs);
                },
                icon: const Icon(Icons.arrow_back),
                iconSize: 29,
                color: Colors.black,
              ),
              SizedBox(
                width: 45,
                height: 45,
                child: IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Center(
                                child: Text('Batalkan Transaksi?')),
                            actions: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Tidak')),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            SplashPage.nameRoute,
                                            (route) => false);
                                      },
                                      child: const Text('Iya'))
                                ],
                              ),
                            ],
                          );
                        });
                  },
                  icon: Image.asset('assets/icon/home.png'),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                'SILAHKAN PINDAI\nKODE QR',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              Text(
                'MEMBER PUPPY CLUB',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, fontSize: 18),
              ),
              Text(
                'DI MESIN PEMINDAI',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Center(
                child: Image.asset(
                  'assets/icon/scan_qr_illustration.png',
                  width: 256,
                  height: 256,
                ),
              ),
              Text(
                'UNTUK CHECK-IN\nSEBEGAI MEMBER',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 19),
            child: Column(
              children: [
                Text(
                  'jika mengalami kesulitan dalam scan kode qr',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'dapat input manual ',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Center(
                                  child: Text(
                                    'Masukkan kode member',
                                    style: GoogleFonts.poppins(fontSize: 16),
                                  ),
                                ),
                                content: SizedBox(
                                  height: 120,
                                  child: Column(
                                    children: [
                                      TextField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        keyboardType: TextInputType.number,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {},
                                          child: const Text('LOGIN'))
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: Text(
                        'disini',
                        style: GoogleFonts.poppins(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                            fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
