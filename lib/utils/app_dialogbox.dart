import 'package:flutter/material.dart';
import 'package:pixalive/ui/login_page.dart';
import 'package:pixalive/utils/app_colors.dart';
import 'package:pixalive/utils/app_textstyles.dart';

class AppDialogBox {
  static Future createAccountSuccessfully(BuildContext _context) {
    return showDialog(
      context: _context,
      builder: (context) {
        return Dialog(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: AppColor.gradientColor,
                begin: Alignment.topLeft, //starting of the gradient color
                end: Alignment.bottomRight, //end of the gradient color
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.20,
            child: Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Icon(
                  Icons.done_outline_rounded,
                  color: Colors.white,
                  size: MediaQuery.of(context).size.height * 0.055,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                Text(
                  "Account Created Successfully",
                  style: AppTextStyle.white18W400,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                TextButton(
                  child: Text(
                    "Ok",
                    style: AppTextStyle.white18W400,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
