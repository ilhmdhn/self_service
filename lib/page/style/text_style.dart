import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontBilling {
  static TextStyle textBilling() {
    return GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 11);
  }
}

class CustomTextStyle{
  
  static TextStyle titleAlertDialog(){
     return GoogleFonts.poppins(fontSize: 18, color: Colors.black);
  }
  
  static TextStyle confirm(){
     return  GoogleFonts.poppins(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500);
  }

  static TextStyle cancel(){
    return GoogleFonts.poppins(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500);
  }
}