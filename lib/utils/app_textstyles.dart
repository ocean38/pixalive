// This file contains all the text styles of the application

import 'package:flutter/material.dart';
import 'package:pixalive/utils/app_colors.dart';

class AppTextStyle {
  static TextStyle get black24W700 {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    );
  }

  static TextStyle get black16W300 {
    return TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w300,
    );
  }

  static TextStyle get black24 {
    return TextStyle(
      fontSize: 24,
      color: Colors.black,
    );
  }

  static TextStyle get black28W700 {
    return TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    );
  }

  static TextStyle get grey18Shade700 {
    return TextStyle(
      fontSize: 18,
      color: Colors.grey.shade700,
    );
  }

  static TextStyle get grey16W700 {
    return TextStyle(
      fontSize: 16,
      color: Colors.grey[700],
    );
  }

  static TextStyle get grey13Bold {
    return TextStyle(
      fontSize: 13,
      color: Colors.grey,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle get grey13 {
    return TextStyle(
      fontSize: 13,
      color: Colors.grey[800],
    );
  }

  static TextStyle get grey20Shade700 {
    return TextStyle(
      fontSize: 20,
      color: Colors.grey.shade700,
    );
  }

  static TextStyle get orange18W400 {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: AppColor.salmon,
    );
  }

  static TextStyle get white18W400 {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    );
  }

  static TextStyle get white18 {
    return TextStyle(
      fontSize: 17,
      color: Colors.white,
    );
  }

  static TextStyle get white22Bold {
    return TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  static TextStyle get white24 {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    );
  }

  static TextStyle get white14 {
    return TextStyle(
      fontSize: 14,
      color: Colors.white,
    );
  }

  static TextStyle get salmon14 {
    return TextStyle(
      fontSize: 14,
      color: AppColor.salmon,
    );
  }

  static TextStyle get blue18W400 {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: Colors.blue,
    );
  }

  static TextStyle get white16 {
    return TextStyle(
      color: Colors.white,
      fontSize: 16,
    );
  }

  static TextStyle get black16 {
    return TextStyle(
      color: Colors.black,
      fontSize: 16,
    );
  }

  static TextStyle get white20 {
    return TextStyle(
      color: Colors.white,
      fontSize: 20,
    );
  }

  static TextStyle get blueGrey16 {
    return TextStyle(
      color: Colors.blueGrey,
      fontSize: 12,
    );
  }
}
