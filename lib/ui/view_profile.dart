import 'package:flutter/material.dart';
import 'package:pixalive/providers/social_auth_provider.dart';
import 'package:pixalive/utils/app_bottom_navbar.dart';
import 'package:pixalive/utils/app_buttons.dart';
import 'package:pixalive/utils/app_colors.dart';
import 'package:pixalive/utils/app_loader.dart';
import 'package:pixalive/utils/app_prefrences.dart';
import 'package:pixalive/utils/app_routes.dart';
import 'package:pixalive/utils/app_textstyles.dart';

class ViewProfile extends StatefulWidget {
  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  final SocialAuthProvider _socialAuthProvider = SocialAuthProvider();

  @override
  Widget build(BuildContext context) {
    final Size _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: AppTextStyle.white24,
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.person_add_outlined,
            size: MediaQuery.of(context).size.height * 0.043,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings_outlined,
              size: MediaQuery.of(context).size.height * 0.043,
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.02),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.editProfile,
              );
            },
            icon: Icon(
              Icons.edit_outlined,
              size: MediaQuery.of(context).size.height * 0.043,
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.02),
        ],
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
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: <Widget>[
                // user profile pic
                Container(
                  height: MediaQuery.of(context).size.height * 0.22,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                    // image: DecorationImage(
                    //   image: AppPrefrences.getPhotoUrl() == null
                    //       ? AssetImage(AppImages.defaultProfilePic)
                    //       : NetworkImage(AppPrefrences.getPhotoUrl()),
                    //   fit: BoxFit.contain,
                    // ),
                    border: Border.all(),
                    shape: BoxShape.circle,
                  ),
                ),

                SizedBox(width: MediaQuery.of(context).size.width * 0.06),

                // user data
                Column(
                  children: <Widget>[
                    // name
                    Text(
                      "${AppPrefrences.getName()}",
                      style: AppTextStyle.black28W700,
                    ),

                    // email
                    Text(
                      "${AppPrefrences.getEmail()}",
                      // style: AppTextStyle.grey16W700,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Lorem Ipsum, giving information on its origins, as well as a random Lipsum generator.",
              style: AppTextStyle.grey16W700,
            ),
          ),

          Divider(color: AppColor.black),

          //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _boxes("500", "Posts"),
              Container(
                  height: _screenSize.height * 0.1,
                  child: VerticalDivider(color: AppColor.black)),
              _boxes("400", "Star People"),
              Container(
                  height: _screenSize.height * 0.1,
                  child: VerticalDivider(color: AppColor.black)),
              _boxes("2K", "Views"),
            ],
          ),

          Divider(color: AppColor.black),

          //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _boxes("4K", "Folow"),
              Container(
                  height: _screenSize.height * 0.1,
                  child: VerticalDivider(color: AppColor.black)),
              _boxes("685", "Star People"),
              Container(
                  height: _screenSize.height * 0.1,
                  child: VerticalDivider(color: AppColor.black)),
              _boxes("256", "Share"),
            ],
          ),
          Divider(color: AppColor.black),

          Padding(
            padding: const EdgeInsets.all(30.0),
            child: AppButtons.appGradientButton(
              buttonName: "Logout",
              onTap: () async {
                AppLoader.start(context);
                await _socialAuthProvider.signOut();
                AppLoader.close();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.welcomePage,
                  (Route<dynamic> route) => false,
                );
              },
              buttonTextStyle: AppTextStyle.white18W400,
            ),
          ),
        ],
      ),

      // Bottom Nav Bar
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavBar.profileNavBar(context),
      floatingActionButton: AppButtons.floatingGradientButton(context),
    );
  }

  Widget _boxes(String _data, String _dataName) {
    return Column(
      children: <Widget>[
        Text(
          _data,
          style: AppTextStyle.black24W700,
        ),
        Text(
          _dataName,
          style: AppTextStyle.grey16W700,
        ),
      ],
    );
  }
}
