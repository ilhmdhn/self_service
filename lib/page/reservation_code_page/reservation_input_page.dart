import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_service/page/style/button_style.dart';
import 'package:self_service/page/style/color_style.dart';
import 'package:self_service/page/splash_page/splash_screen.dart';

class ReservationInputPage extends StatefulWidget {
  const ReservationInputPage({super.key});
  static const nameRoute = '/reservation-input-page';

  @override
  State<ReservationInputPage> createState() => _ReservationInputPageState();
}

class _ReservationInputPageState extends State<ReservationInputPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(color: CustomColorStyle.lightBlue()),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 35,
                      height: 35,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                        iconSize: 30,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 44,
                      height: 44,
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
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          'NOMOR HANDPHONE',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      SizedBox(
                        height: 39,
                        child: TextField(
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: CustomColorStyle
                                .darkGrey(), // Latar belakang abu-abu
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  20.0), // Sudut melengkung
                              borderSide: const BorderSide(
                                color: Colors.red, // Warna garis tepi
                                width: 0.4, // Ketebalan garis tepi
                              ), // Tidak ada garis tepi
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          'KODE RESERVASI',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                      ),
                      SizedBox(
                        height: 39,
                        child: TextField(
                          onTap: () {
                            SystemChrome.setEnabledSystemUIMode(
                                SystemUiMode.immersiveSticky);
                          },
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: CustomColorStyle
                                .darkGrey(), // Latar belakang abu-abu
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  20.0), // Sudut melengkung
                              borderSide: const BorderSide(
                                color: Colors.red, // Warna garis tepi
                                width: 0.4, // Ketebalan garis tepi
                              ), // Tidak ada garis tepi
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 68, bottom: 99),
                child: ElevatedButton(
                  onPressed: () {
                    SystemChrome.setEnabledSystemUIMode(
                        SystemUiMode.immersiveSticky);
                  },
                  style: CustomButtonStyle.styleDarkBlueButton(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: Text(
                      'LANJUT',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600, fontSize: 19),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
