import 'package:flutter/material.dart';
import 'package:pixalive/utils/app_buttons.dart';
import 'package:pixalive/utils/app_colors.dart';
import 'package:pixalive/utils/app_images.dart';
import 'package:pixalive/utils/app_textstyles.dart';

class ResetCongrats extends StatefulWidget {
  const ResetCongrats({Key? key}) : super(key: key);

  @override
  _ResetCongratsState createState() => _ResetCongratsState();
}

class _ResetCongratsState extends State<ResetCongrats> {
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
                      AppImages.resetRightTick,
                    ),
                  ),
                ],
              ),

              SizedBox(height: _screensize.height * 0.10),

              // Text
              Text(
                "Congratulations!!",
                style: AppTextStyle.white22Bold,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: _screensize.height * 0.025),

              // Text
              Text(
                "You have successfully changed",
                style: AppTextStyle.white18,
                textAlign: TextAlign.center,
              ),
              Text(
                "your password.",
                style: AppTextStyle.white18,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: _screensize.height * 0.12),

              // Button
              AppButtons.whiteBackgroundButton(
                "Ok",
                () {
                  Navigator.pop(context);
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
