// chat model

import 'package:pixalive/utils/app_constants.dart';

class ChatModel {
  // chat data fields
  String? message;
  String? sendBy;
  String? time;
  String? date;

  // constructor
  ChatModel({
    this.sendBy,
    this.time,
    this.date,
    this.message,
  });

  Map<String, dynamic> toJSON() => {
        DatabaseConstants.chatMessage: message,
        DatabaseConstants.chatSendBy: sendBy,
        DatabaseConstants.chatTime: time,
        DatabaseConstants.chatDate: date,
      };

  ChatModel.fromJson(Map<String, dynamic> map)
      : sendBy = map[DatabaseConstants.chatSendBy],
        message = map[DatabaseConstants.chatMessage],
        time = map[DatabaseConstants.chatTime],
        date = map[DatabaseConstants.chatDate];
}
