// This file contains all the colors of the application

import 'package:flutter/material.dart';

class AppColor {
  static const Color facebookBlue = Color.fromRGBO(59, 89, 152, 1);
  static const Color googleRed = Color.fromRGBO(221, 75, 57, 1);
  static const Color salmon = Color.fromRGBO(255, 109, 99, 1);
  static const Color yellow = Color.fromRGBO(254, 194, 82, 1);
  static const Color darkPink = Color.fromRGBO(254, 49, 108, 1);
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static final Color grey200 = Colors.grey.shade200;

  static const List<Color> gradientColor = <Color>[
    AppColor.darkPink,
    AppColor.salmon,
    AppColor.yellow,
  ];
}
