import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InstructionPage extends StatefulWidget {
  const InstructionPage({super.key});

  static const nameRoute = '/instruction';

  @override
  State<InstructionPage> createState() => _InstructionPageState();
}

class _InstructionPageState extends State<InstructionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      SizedBox(
        width: double.infinity,
        child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('AMBIL SLIP\nKEMUDIAN SEGERA MENUJU\nROOM', style: GoogleFonts.poppins(fontSize: 19, fontWeight: FontWeight.w500), textAlign: TextAlign.center,)
        ],
      ),
     
      )
      );
  }
}