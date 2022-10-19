import 'package:flutter/foundation.dart';
import 'package:pixalive/database/helper/firestore_helper.dart';
import 'package:pixalive/database/models/chat_model.dart';
import 'package:pixalive/database/models/user_model.dart';

class ChatProvider extends ChangeNotifier {
  static final FireStoreHelperDB _fireStoreHelperObj = FireStoreHelperDB();

  // list data of users and chat
  List<UserModel> users = [];
  List<ChatModel> conversation = [];

  //---------------------------Firestore chat provider-------------------------

  // get users provider
  Future getUserProvider(String _email) async {
    users = await _fireStoreHelperObj.getUsers(_email);
    notifyListeners();
    return users;
  }

  // get conversation provider
  Future getConversationProvider(String? _chatRoomID) async {
    conversation = await _fireStoreHelperObj.getConversation(_chatRoomID ?? "");
    notifyListeners();
    return conversation;
  }

  // Add conversation provider
  Future addConversationMsgProvider(String _chatRoomID, String _message) {
    final Future _result =
        _fireStoreHelperObj.addConversationMsg(_chatRoomID, _message);
    notifyListeners();
    return _result;
  }

  // Add user provider
  Future addUserToConversationProvider(String _sender) {
    final Future _result = _fireStoreHelperObj.addUserToConversation(_sender);
    notifyListeners();
    return _result;
  }
}
