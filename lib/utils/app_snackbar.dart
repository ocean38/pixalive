import 'package:flutter/material.dart';

class AppSnackbar {
  static customSnackBar(String _text, BuildContext _context) {
    return ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(
        content: Text(
          _text,
        ),
        action: SnackBarAction(
          label: "Ok",
          onPressed: () {},
        ),
      ),
    );
  }
}
