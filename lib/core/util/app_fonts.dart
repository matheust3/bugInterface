import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppFonts {
  static TextStyle boxesTitle = TextStyle(
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
  );
  //
  // InputFild
  //
  static TextStyle inputTextFild = TextStyle(
    fontSize: 16,
    color: AppColors.inputTextFild,
    letterSpacing: 0.3,
    fontWeight: FontWeight.w100,
  );
  static TextStyle inputTextFildLabelText = TextStyle(
    fontSize: 16,
    color: AppColors.inputTextFild,
    letterSpacing: 0.3,
    fontWeight: FontWeight.w100,
  );
  static TextStyle sideBarMainItems = TextStyle(
    fontSize: 13,
    color: AppColors.inputTextFild,
    letterSpacing: 0.1,
    fontWeight: FontWeight.w200,
  );
}
