import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_service/bloc/universal_bloc.dart';
import 'package:self_service/page/reservation_code_page/reservation_input_page.dart';
import 'package:self_service/page/style/color_style.dart';

class ReservationScanPage extends StatefulWidget {
  const ReservationScanPage({super.key});
  static const nameRoute = '/reservation-scan';

  @override
  State<ReservationScanPage> createState() => _ReservationScanPageState();
}

class _ReservationScanPageState extends State<ReservationScanPage> {
  final FocusNode _focusNode = FocusNode();
  final InputCubit reservationCodeCubit = InputCubit();

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    reservationCodeCubit.getData("");
    return Stack(
      children: [
        BlocBuilder<InputCubit, String>(
          bloc: reservationCodeCubit,
          builder: (context, reservationCodeState) {
            return Container(
              child: reservationCodeState != ""
                  ? Text(reservationCodeState)
                  : const SizedBox(),
            );
          },
        ),
        RawKeyboardListener(
            focusNode: _focusNode,
            onKey: (RawKeyEvent event) {
              if (event.runtimeType == RawKeyUpEvent) {
                final keyData = event.data;
                if (keyData is RawKeyEventDataAndroid) {
                  setState(() {
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                    reservationCodeCubit.getData(event.logicalKey.keyLabel);
                  });
                }
              }
            },
            child: const SizedBox(
              height: 0,
              width: 0,
            )),
        Positioned(
            left: 0,
            top: 0,
            right: 0,
            bottom: 0,
            child: Image.asset(
              'assets/images/background_reservation_scan.jpg',
              width: double.infinity,
              height: double.infinity,
            )),
        Positioned(
          bottom: 84,
          right: 125,
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ReservationInputPage.nameRoute);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                'BANTUAN',
                style: GoogleFonts.poppins(
                    color: CustomColorStyle.darkRed(),
                    fontWeight: FontWeight.bold,
                    fontSize: 9),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
