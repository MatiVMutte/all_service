import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  bool claro;

  AppTheme({
    required this.claro
  });
  
  ThemeData getTheme() {
    return ThemeData(
      brightness: (claro) ? Brightness.light : Brightness.dark,
      colorSchemeSeed: Colors.blue,
      textTheme: TextTheme( bodyMedium: GoogleFonts.lato(), titleMedium: GoogleFonts.montserrat() ),
      primaryColorLight: Colors.blue.shade400,
      primaryColorDark: Colors.blue.shade900
    );
  }

}