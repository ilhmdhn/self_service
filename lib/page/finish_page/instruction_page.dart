import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_service/page/splash_page/splash_screen.dart';
import 'package:self_service/page/style/color_style.dart';

class InstructionPage extends StatefulWidget {
  const InstructionPage({super.key});

  static const nameRoute = '/instruction';

  @override
  State<InstructionPage> createState() => _InstructionPageState();
}

class _InstructionPageState extends State<InstructionPage> {
  Timer? _timerMoveSplash;
  @override
  Widget build(BuildContext context) {
    _timerMoveSplash = Timer(const Duration(seconds: 10), (){
      Navigator.pushNamedAndRemoveUntil(context, SplashPage.nameRoute, (route) => false);
    });
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: CustomColorStyle.lightBlue(),
        body: 
        SizedBox(
          width: double.infinity,
          child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('AMBIL SLIP\nKEMUDIAN SEGERA MENUJU\nROOM', 
            style: GoogleFonts.poppins(
              fontSize: 19, 
              fontWeight: FontWeight.w600), 
              textAlign: TextAlign.center,),
            SizedBox(
              width: 316,
              child: Image.asset('assets/icon/slip.png'),
            ),
            Text('DAN SILAHKAN MENIKMATI\nBERKARAOKE di', 
            style: GoogleFonts.poppins(
              fontSize: 19, 
              fontWeight: FontWeight.w600), 
              textAlign: TextAlign.center,),
            const SizedBox(height: 6,),
            SizedBox(
              width: 190,
              child: Image.asset('assets/icon/happy_puppy.png'),
            )
          ],
        ),
       
        )
        ),
    );
  }

  @override
  void dispose() {
    _timerMoveSplash?.cancel();
    // TODO: implement dispose
    super.dispose();
  }
}