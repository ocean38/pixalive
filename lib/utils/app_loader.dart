import 'package:flutter/material.dart';
import 'package:pixalive/utils/app_colors.dart';
import 'package:pixalive/utils/app_textstyles.dart';

class AppLoader {
  static BuildContext? _context;

  static Future start(BuildContext _context) {
    return showDialog(
      context: _context,
      builder: (BuildContext context) {
        _context = context;
        return Dialog(
            child: Container(
          height: MediaQuery.of(context).size.height / 12,
          width: double.minPositive,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CircularProgressIndicator(backgroundColor: AppColor.salmon),
              Text("Loading...", style: AppTextStyle.black24),
            ],
          ),
        ));
      },
    );
  }

  static void close() {
    if (_context != null) Navigator.of(_context!).pop();
  }
}
