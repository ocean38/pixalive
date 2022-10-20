// This file contains all the button of the application

import 'package:flutter/material.dart';
import 'package:pixalive/utils/app_colors.dart';
import 'package:pixalive/utils/app_images.dart';
import 'package:pixalive/utils/app_textstyles.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';

class AppButtons {
  //
  //
  //------------------------Gradient Button------------------------

  static Widget appGradientButton({
    required String buttonName,
    required Function onTap,
    required TextStyle buttonTextStyle,
  }) {
    return ElevatedButton(
      onPressed: onTap(),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
              colors: AppColor.gradientColor,
              begin: Alignment.topLeft, //starting of the gradient color
              end: Alignment.bottomRight, //end of the gradient color
              stops: <double>[
                0,
                0.5,
                1,
              ] //stops for individual color
              ),
        ),
        width: double.infinity,
        height: 55,
        alignment: Alignment.center,
        child: Text(
          buttonName,
          style: buttonTextStyle,
        ),
      ),
    );
  }

  //
  //
  //------------------------Transperent Button------------------------

  static Widget appTransperentButton({
    required String buttonName,
    required Function onTap,
    required TextStyle buttonTextStyle,
  }) {
    return OutlineGradientButton(
      strokeWidth: 3,
      radius: Radius.circular(50),
      child: Container(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onTap(),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: Text(
            buttonName,
            style: buttonTextStyle,
          ),
        ),
      ),
      gradient: LinearGradient(
        // Gradient Border
        colors: AppColor.gradientColor,
      ),
    );
  }

  //
  //
  //------------------------Social Button------------------------

  static Widget socialAccountButton({
    required String image,
    required Color color,
    required Function onTap,
  }) {
    return Container(
      height: 65,
      width: 65,
      child: ElevatedButton(
        onPressed: onTap(),
        child: Image.asset(image),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(vertical: 10.0),
          ),
          shape: MaterialStateProperty.all(CircleBorder()),
          backgroundColor: MaterialStateProperty.all<Color>(color),
        ),
      ),
    );
  }

  //
  //
  //------------------------White Background Button------------------------

  static Widget whiteBackgroundButton(
      String _buttonName, Function _onTap, Color _buttonColor) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _onTap(),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(_buttonColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
        child: Text(
          _buttonName,
          style: AppTextStyle.orange18W400,
        ),
      ),
    );
  }

  //
  //
  //------------------Floating Gradient Button--------------------

  static Widget floatingGradientButton(BuildContext _context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(AppImages.homePageAddIcon),
            fit: BoxFit.cover,
          ),
        ),
        height: MediaQuery.of(_context).size.height * 0.14,
        width: MediaQuery.of(_context).size.height * 0.09,
      ),
    );
  }

  // messageSentButtom
  static Widget messageSentButtom(BuildContext _context, Function _onTap) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: AppColor.gradientColor,
        ),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(
          Icons.send,
          color: AppColor.white,
          size: MediaQuery.of(_context).size.height * 0.03,
        ),
        onPressed: () {
          _onTap();
        },
      ),
    );
  }

  //
  //
  //------------------AppBAR Button--------------------

  static Widget appBarButton(
      BuildContext _context, String _image, Function _onTap) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.zero,
        shadowColor: Colors.transparent,
        elevation: 0,
      ),
      onPressed: () => _onTap(),
      child: Image.asset(
        _image,
        width: MediaQuery.of(_context).size.width / 10,
        height: MediaQuery.of(_context).size.height,
      ),
    );
  }
  //
  //
  //------------------TextFromField Button--------------------

  static Widget textFromFieldButton(
      BuildContext _context, String _image, Function _onTap) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        padding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
      ),
      onPressed: () {
        _onTap();
      },
      child: Image.asset(
        _image,
        fit: BoxFit.contain,
        width: MediaQuery.of(_context).size.width / 14,
        height: MediaQuery.of(_context).size.height / 19,
      ),
    );
  }

  //
  //------------------back Button--------------------
  //

  static Widget backButton(BuildContext _context, Color _color) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        padding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
      ),
      onPressed: () => Navigator.pop(_context),
      child: Image.asset(
        AppImages.backButton,
        color: _color,
        width: MediaQuery.of(_context).size.width / 15,
        height: MediaQuery.of(_context).size.height / 45,
      ),
    );
  }
}
