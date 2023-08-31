import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_service/bloc/universal_bloc.dart';
import 'package:self_service/page/style/button_style.dart';
import 'package:self_service/page/style/color_style.dart';

class ReservationInputPage extends StatelessWidget {
  const ReservationInputPage({super.key});
  static const nameRoute = '/reservation-input-page';

  @override
  Widget build(BuildContext context) {
    final InputCubit noHpCubit = InputCubit();
    final InputCubit reservationCodeCubit = InputCubit();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: CustomColorStyle.lightBlue()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(flex: 1, child: Row()),
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
                            fontWeight: FontWeight.w600, fontSize: 17),
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    SizedBox(
                      height: 39,
                      child: TextField(
                        style:
                            const TextStyle(fontSize: 15, color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: CustomColorStyle
                              .darkGrey(), // Latar belakang abu-abu
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(20.0), // Sudut melengkung
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
                            fontWeight: FontWeight.w600, fontSize: 17),
                      ),
                    ),
                    SizedBox(
                      height: 39,
                      child: TextField(
                        style:
                            const TextStyle(fontSize: 15, color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: CustomColorStyle
                              .darkGrey(), // Latar belakang abu-abu
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(20.0), // Sudut melengkung
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
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 10,
                width: 320,
                child: Container(
                  height: 10,
                  width: 320,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: CustomButtonStyle.styleDarkBlueButton(),
                    child: const Text('LANJUT'),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
