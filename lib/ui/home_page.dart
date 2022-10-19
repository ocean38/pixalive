import 'package:flutter/material.dart';
import 'package:pixalive/utils/app_bottom_navbar.dart';
import 'package:pixalive/utils/app_buttons.dart';
import 'package:pixalive/utils/app_colors.dart';
import 'package:pixalive/utils/app_textstyles.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // Geting Signin data from shared prefrences
    // final String _name = AppPrefrences.getDisplayName();
    // final String _email = AppPrefrences.getEmail();
    // final String _photo = AppPrefrences.getPhotoUrl();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: AppColor.gradientColor,
            ),
          ),
        ),
      ),
      body: Center(child: Text("Home Page", style: AppTextStyle.black28W700)),

      // Bottom Nav Bar
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavBar.homeNavBar(context),
      floatingActionButton: AppButtons.floatingGradientButton(context),
    );
  }
}
