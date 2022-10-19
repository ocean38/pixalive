import 'package:flutter/material.dart';
import 'package:pixalive/utils/app_buttons.dart';
import 'package:pixalive/utils/app_colors.dart';
import 'package:pixalive/utils/app_images.dart';
import 'package:pixalive/utils/app_routes.dart';
import 'package:pixalive/utils/app_textstyles.dart';

class ForgotLinkSent extends StatefulWidget {
  const ForgotLinkSent({Key? key}) : super(key: key);

  @override
  _ForgotLinkSentState createState() => _ForgotLinkSentState();
}

class _ForgotLinkSentState extends State<ForgotLinkSent> {
  @override
  Widget build(BuildContext context) {
    final Size _screensize = MediaQuery.of(context).size;
    return Scaffold(
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
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: ListView(
            children: [
              SizedBox(height: _screensize.height * 0.09),
              Stack(
                children: [
                  Image.asset(
                    AppImages.gradientCircle,
                  ),
                  Positioned(
                    left: 110,
                    top: 110,
                    height: _screensize.height * 0.15,
                    child: Image.asset(
                      AppImages.resetIcon,
                    ),
                  ),
                ],
              ),

              SizedBox(height: _screensize.height * 0.10),

              // Text
              Text(
                "We've sent you a reset link",
                style: AppTextStyle.white22Bold,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: _screensize.height * 0.025),

              // Text
              Text(
                "A reset link has been sent to your",
                style: AppTextStyle.white18,
                textAlign: TextAlign.center,
              ),
              Text(
                "registered email address successfully.",
                style: AppTextStyle.white18,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: _screensize.height * 0.12),

              // Button
              AppButtons.whiteBackgroundButton(
                "Ok",
                () {
                  Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.resetPage,
                  );
                },
                Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
