import 'package:flutter/material.dart';
import 'package:pixalive/utils/app_buttons.dart';
import 'package:pixalive/utils/app_colors.dart';
import 'package:pixalive/utils/app_routes.dart';
import 'package:pixalive/utils/app_snackbar.dart';
import 'package:pixalive/utils/app_textfromfield.dart';
import 'package:pixalive/utils/app_textstyles.dart';

class OtpPage extends StatefulWidget {
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController _otp1 = TextEditingController();
  final TextEditingController _otp2 = TextEditingController();
  final TextEditingController _otp3 = TextEditingController();
  final TextEditingController _otp4 = TextEditingController();
  final TextEditingController _finalOtp = TextEditingController();

  FocusNode? _f1;
  FocusNode? _f2;
  FocusNode? _f4;
  FocusNode? _f3;

  @override
  void initState() {
    super.initState();
    _f1 = FocusNode();
    _f2 = FocusNode();
    _f3 = FocusNode();
    _f4 = FocusNode();
  }

  @override
  void dispose() {
    // text controllers
    _otp1.dispose();
    _otp2.dispose();
    _otp3.dispose();
    _otp4.dispose();
    _finalOtp.dispose();

    // focus nodes
    _f1?.dispose();
    _f2?.dispose();
    _f3?.dispose();
    _f4?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: AppColor.gradientColor,
              stops: [0, 0.5, 1],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Enter OTP",
                  style: AppTextStyle.white22Bold,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                // otp text from field
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GetOtp(
                        focusNodeName: _f1, nextFocus: _f2, controller: _otp1),
                    SizedBox(width: 10),
                    GetOtp(
                        focusNodeName: _f2, nextFocus: _f3, controller: _otp2),
                    SizedBox(width: 10),
                    GetOtp(
                        focusNodeName: _f3, nextFocus: _f4, controller: _otp3),
                    SizedBox(width: 10),
                    GetOtp(
                        focusNodeName: _f4, nextFocus: null, controller: _otp4),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),

                // Verify button
                AppButtons.whiteBackgroundButton(
                  "Verify",
                  () {
                    _otpCheck();
                  },
                  AppColor.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Otp Check
  void _otpCheck() {
    _finalOtp.text = _otp1.text + _otp2.text + _otp3.text + _otp4.text;
    if (_finalOtp.text == "1234") {
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.forgotLinkSent,
      );
    } else {
      AppSnackbar.customSnackBar("Ok", context);
    }
  }
}
