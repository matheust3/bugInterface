import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppFonts {
  static TextStyle boxesTitle = GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: 16,
      color: AppColors.boxesTitle,
      letterSpacing: 0.3,
      fontWeight: FontWeight.w100,
      shadows: [
        Shadow(
          offset: Offset(-0.3, -0.3),
          blurRadius: 0.2,
          color: Colors.grey,
        ),
        Shadow(
          offset: Offset(-0.3, 0.3),
          blurRadius: 0.2,
          color: Colors.grey,
        ),
        Shadow(
          offset: Offset(0.3, -0.3),
          blurRadius: 0.2,
          color: Colors.grey,
        ),
        Shadow(
          offset: Offset(0.3, 0.3),
          blurRadius: .2,
          color: Colors.grey,
        ),
      ],
    ),
  );
  //
  // InputFild
  //
  static TextStyle inputTextFild = GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: 16,
      color: AppColors.inputTextFild,
      letterSpacing: 0.3,
      fontWeight: FontWeight.w100,
    ),
  );
  static TextStyle inputTextFildLabelText = GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: 16,
      color: AppColors.inputTextFild,
      letterSpacing: 0.3,
      fontWeight: FontWeight.w100,
    ),
  );
  static TextStyle sideBarMainItems = GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: 13,
      color: AppColors.inputTextFild,
      letterSpacing: 0.1,
      fontWeight: FontWeight.w200,
    ),
  );
}
