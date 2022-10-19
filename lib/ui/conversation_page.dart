import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pixalive/providers/firestore_chat_provider.dart';
import 'package:pixalive/utils/app_buttons.dart';
import 'package:pixalive/utils/app_chat_messages.dart';
import 'package:pixalive/utils/app_colors.dart';
import 'package:pixalive/utils/app_prefrences.dart';
import 'package:pixalive/utils/app_textfromfield.dart';
import 'package:pixalive/utils/app_textstyles.dart';
import 'package:pixalive/utils/utility.dart';
import 'package:provider/provider.dart';

class ConversationPage extends StatefulWidget {
  final String chatUserName;
  final String userPhoto;
  final String chatEmail;

  const ConversationPage({
    Key? key,
    required this.chatUserName,
    required this.userPhoto,
    required this.chatEmail,
  }) : super(key: key);

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final TextEditingController _message = TextEditingController();
  final ChatProvider _chatProvider = ChatProvider();
  final ScrollController _scrollController = ScrollController();
  final String _currentUser = AppPrefrences.getEmail();

  @override
  void dispose() {
    _message.dispose();
    _chatProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size _screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          titleSpacing: -2,
          leading: AppButtons.backButton(context, AppColor.white),
          title: Row(
            children: <Widget>[
              /// image
              Container(
                height: _screenSize.height * 0.1,
                width: _screenSize.width * 0.09,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  // image: DecorationImage(
                  //   image: widget.userPhoto == null
                  //       ? AssetImage(AppImages.defaultProfilePic)
                  //       : NetworkImage(widget.userPhoto),
                  //   fit: BoxFit.cover,
                  // ),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 14),

              /// username
              Text(
                widget.chatUserName,
                style: AppTextStyle.white20,
              ),
            ],
          ),
          elevation: 0,
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_horiz_outlined,
                size: _screenSize.height * 0.040,
              ),
            ),
            SizedBox(width: _screenSize.width * 0.025),
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
        body: Consumer<ChatProvider>(
            builder: (BuildContext context, ChatProvider _provider, _) {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: _screenSize.height / 1.25,
                  width: _screenSize.width,
                  child: FutureBuilder(
                    future: _provider.getConversationProvider(
                        UtiltyChatID.getChatRoomId(
                            widget.chatEmail, _currentUser)),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      Timer(
                        Duration(milliseconds: 100),
                        () => _scrollController
                            .jumpTo(_scrollController.position.maxScrollExtent),
                      );
                      if (snapshot.hasData) {
                        return ListView.builder(
                          controller: _scrollController,
                          itemCount: _provider.conversation.length,
                          itemBuilder: (context, index) {
                            final _chatData = _provider.conversation[index];
                            return Container(
                              child: Column(
                                crossAxisAlignment:
                                    _chatData.sendBy == _currentUser
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                children: <Widget>[
                                  Center(
                                    child: !_alreadyRetured
                                            .contains(_chatData.date)
                                        ? Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade300,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 8),
                                            child: Text(
                                              _setDate(_chatData.date),
                                              style: AppTextStyle.grey13,
                                            ),
                                          )
                                        : null,
                                  ),

                                  // chat message
                                  Message(
                                    message: _chatData.message,
                                    time: _chatData.time,
                                    isMe: _chatData.sendBy == _currentUser,
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else
                        return Center(
                          child: CircularProgressIndicator(
                              backgroundColor: AppColor.salmon),
                        );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: <Widget>[
                      // chat text From Field
                      ChatTextFromField(messageController: _message),
                      SizedBox(width: _screenSize.width * 0.03),
                      // messageSentButtom
                      AppButtons.messageSentButtom(context, () {
                        _chatProvider.addConversationMsgProvider(
                          widget.chatEmail,
                          _message.text.trim(),
                        );
                        _message.clear();
                      }),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  static final Set<String> _alreadyRetured = {};
  _setDate(String? _date) {
    final DateTime _now = DateTime.now();
    final DateFormat _formatter = DateFormat("dd-MM-yyyy");
    final String _todayDate =
        _formatter.format(_now).toString().replaceAll("-", "");
    if (_date == _todayDate) {
      _alreadyRetured.add("Today");
      return "Today";
    } else if (int.parse(_date!.substring(0, 2)).toString() ==
            (int.parse(_todayDate.substring(0, 2)) - 1).toString() &&
        _date.substring(3) == _todayDate.substring(3)) {
      _alreadyRetured.add("Yesterday");
      return "Yesterday";
    }
    final String _otherDates = _date.substring(0, 2) +
        "-" +
        _date.substring(2, 4) +
        "-" +
        _date.substring(4, 8);

    return _otherDates;
  }
}
