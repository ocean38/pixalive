import 'package:flutter/material.dart';
import 'package:pixalive/utils/app_buttons.dart';
import 'package:pixalive/utils/app_images.dart';
import 'package:pixalive/utils/app_routes.dart';
import 'package:pixalive/utils/app_textstyles.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    final Size _screensize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AppImages.welcomeScreenBackground,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Play Button Icon
                Image.asset(
                  AppImages.welcomeScreenPlayIcon,
                  height: _screensize.height * 0.10,
                ),

                SizedBox(height: _screensize.height * 0.06),

                // Pixalive logo text
                Image.asset(
                  AppImages.welcomeScreenLogoText,
                  height: _screensize.height * 0.07,
                ),

                SizedBox(height: _screensize.height * 0.09),

                // Create Account Button
                AppButtons.appGradientButton(
                  "Create Account",
                  () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.createAccountPage,
                    );
                  },
                  AppTextStyle.white18W400,
                ),

                SizedBox(height: _screensize.height * 0.02),

                // Login Button
                AppButtons.appTransperentButton(
                  "Log In",
                  () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.loginPage,
                    );
                  },
                  AppTextStyle.white18W400,
                ),

                SizedBox(height: _screensize.height * 0.03),

                // terms and condition text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: RichText(
                    text: TextSpan(
                      text: "By Signing up, you agree to the ",
                      style: AppTextStyle.white14,
                      children: <TextSpan>[
                        TextSpan(
                          text: "Terms of Use ",
                          style: AppTextStyle.salmon14,
                        ),
                        TextSpan(
                          text: "& ",
                          style: AppTextStyle.white14,
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  "Privacy Policy",
                  style: AppTextStyle.salmon14,
                ),

                SizedBox(height: _screensize.height * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
