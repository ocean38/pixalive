import 'package:flutter/material.dart';
import 'package:pixalive/utils/app_colors.dart';
import 'package:pixalive/utils/app_images.dart';
import 'package:pixalive/utils/app_routes.dart';
import 'package:pixalive/utils/app_textstyles.dart';

class BottomNavBar {
  // home nav bar
  static Widget homeNavBar(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.white,
          boxShadow: [
            BoxShadow(color: AppColor.black),
          ],
        ),
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.03),
        height: MediaQuery.of(context).size.height * 0.09,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _navBar("World", AppImages.navbarWorldIconGradient, context, () {}),
            _navBar("Trending", AppImages.fireIcon, context, () {}),
            Container(),
            _navBar("Chat", AppImages.chatIcon, context, () {
              Navigator.pushNamed(
                context,
                AppRoutes.chatUserPage,
              );
            }),
            _navBar("Profile", AppImages.navbarProfileIcon, context, () {
              Navigator.pushNamed(
                context,
                AppRoutes.viewProfile,
              );
            }),
          ],
        ),
      ),
    );
  }

  // profile nav bar
  static Widget profileNavBar(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.white,
          boxShadow: [
            BoxShadow(color: AppColor.black),
          ],
        ),
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.03),
        height: MediaQuery.of(context).size.height * 0.09,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _navBar("World", AppImages.navbarWorldIcon, context, () {
              Navigator.pop(context);
            }),
            _navBar("Trending", AppImages.fireIcon, context, () {}),
            Container(),
            _navBar("Chat", AppImages.chatIcon, context, () {
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.chatUserPage,
              );
            }),
            _navBar("Profile", AppImages.navbarProfileGradient, context, () {}),
          ],
        ),
      ),
    );
  }

  // chat nav bar
  static Widget chatNavBar(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.white,
          boxShadow: [
            BoxShadow(color: AppColor.black),
          ],
        ),
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.03),
        height: MediaQuery.of(context).size.height * 0.09,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _navBar("World", AppImages.navbarWorldIcon, context, () {
              Navigator.pop(context);
            }),
            _navBar("Trending", AppImages.fireIcon, context, () {}),
            Container(),
            _navBar("Chat", AppImages.chatGradientIcon, context, () {}),
            _navBar("Profile", AppImages.navbarProfileIcon, context, () {
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.viewProfile,
              );
            }),
          ],
        ),
      ),
    );
  }

  // NAV BAR columns
  static Widget _navBar(
      String text, String image, BuildContext context, Function function) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.065,
            width: MediaQuery.of(context).size.width * 0.08,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            "$text",
            style: AppTextStyle.grey13Bold,
          ),
        ],
      ),
    );
  }
}
