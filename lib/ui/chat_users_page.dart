import 'package:flutter/material.dart';
import 'package:pixalive/providers/firestore_chat_provider.dart';
import 'package:pixalive/ui/conversation_page.dart';
import 'package:pixalive/utils/app_bottom_navbar.dart';
import 'package:pixalive/utils/app_buttons.dart';
import 'package:pixalive/utils/app_colors.dart';
import 'package:pixalive/utils/app_images.dart';
import 'package:pixalive/utils/app_prefrences.dart';
import 'package:pixalive/utils/app_textstyles.dart';
import 'package:provider/provider.dart';

class ChatUsersPage extends StatefulWidget {
  @override
  _ChatUsersPageState createState() => _ChatUsersPageState();
}

class _ChatUsersPageState extends State<ChatUsersPage> {
  final String _currentUser = AppPrefrences.getEmail();
  final ChatProvider _chatProvider = ChatProvider();

  @override
  void dispose() {
    _chatProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size _screenSize = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Chats",
            style: AppTextStyle.white24,
          ),
          centerTitle: true,
          elevation: 0,
          leading: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              padding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 0,
            ),
            onPressed: () {},
            child: Image.asset(
              AppImages.searchIcon,
              width: MediaQuery.of(context).size.width / 15,
              height: MediaQuery.of(context).size.height / 35,
            ),
          ),
          actions: <Widget>[
            AppButtons.appBarButton(context, AppImages.addChat, () {}),
            SizedBox(width: MediaQuery.of(context).size.width * 0.01),
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
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(_screenSize.height * 0.075),
            child: Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: AppColor.gradientColor,
                  ),
                ),
                child: TabBar(
                  unselectedLabelColor: AppColor.white,
                  labelStyle: AppTextStyle.white18W400,
                  labelColor: AppColor.salmon,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColor.white,
                  ),
                  tabs: <Widget>[
                    _tabs("Friends"),
                    _tabs("Contacts"),
                    _tabs("Anoymous"),
                  ],
                ),
              ),
            ),
          ),
        ),

        body: TabBarView(
          children: <Widget>[
            _friendsTab(context),
            Center(child: Text("Contacts", style: AppTextStyle.black28W700)),
            Center(child: Text("Anoymous", style: AppTextStyle.black28W700)),
          ],
        ),

        // Bottom Nav Bar
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavBar.chatNavBar(context),
        floatingActionButton: AppButtons.floatingGradientButton(context),
      ),
    );
  }

  Widget _tabs(String _text) {
    return Tab(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(_text, style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }

  Widget _friendsTab(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (BuildContext context, ChatProvider _provider, Widget? __) {
        return FutureBuilder(
          future: _provider.getUserProvider(_currentUser),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                separatorBuilder: (BuildContext _context, int _index) {
                  return Divider(
                      color: AppColor.black, indent: 12, endIndent: 12);
                },
                itemCount: _provider.users.length,
                itemBuilder: (context, index) {
                  final _chatData = _provider.users[index];
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => ConversationPage(
                            chatUserName: _chatData.name ?? "",
                            chatEmail: _chatData.email ?? "",
                            userPhoto: _chatData.photo ?? "",
                          ),
                        ),
                      );
                    },
                    leading: Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      decoration: BoxDecoration(
                        // image: DecorationImage(
                        //   image: _chatData.photo == null
                        //       ? AssetImage(AppImages.defaultProfilePic)
                        //       : NetworkImage(_chatData.photo),
                        //   fit: BoxFit.cover,
                        // ),
                        border: Border.all(),
                        shape: BoxShape.circle,
                      ),
                    ),
                    title: Text(
                      _chatData.name ?? "",
                      style: AppTextStyle.black24,
                    ),
                    subtitle: Container(color: AppColor.black),
                  );
                },
              );
            } else
              return Center(
                child:
                    CircularProgressIndicator(backgroundColor: AppColor.salmon),
              );
          },
        );
      },
    );
  }
}
