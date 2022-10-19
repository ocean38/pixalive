import 'dart:io';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pixalive/database/models/chat_model.dart';
import 'package:pixalive/database/models/user_model.dart';
import 'package:pixalive/utils/app_constants.dart';
import 'package:intl/intl.dart';
import 'package:pixalive/utils/app_prefrences.dart';
import 'package:pixalive/utils/utility.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireStoreHelperDB {
  //-------------------------Singleton Obj-------------------------------

  static final FireStoreHelperDB _socialAuth = FireStoreHelperDB._();
  factory FireStoreHelperDB() {
    return _socialAuth;
  }
  FireStoreHelperDB._();

  //------------------------Firebase function-----------------------------

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // create Account
  Future createUser(UserModel _user) async {
    try {
      await _db
          .collection(DatabaseConstants.userTbl)
          .doc(_user.userId)
          .set(_user.toJSON());

      await addUserToConversation(_user.name ?? "");
    } catch (error) {
      debugPrint("Create user Exception :- $error");
      return ExceptionConstants.exception;
    }
    return true;
  }

  // user login
  Future loginUser(String _email, String _passowrd) async {
    try {
      final _loginData = await _db
          .collection(DatabaseConstants.userTbl)
          .where(DatabaseConstants.email, isEqualTo: _email)
          .where(DatabaseConstants.password, isEqualTo: _passowrd)
          .get();
      _loginData.docs.first.data()[DatabaseConstants.password] = null;
      return UserModel.fromJson(_loginData.docs.first.data());
    } catch (error) {
      debugPrint("login Exception :- $error");
      return ExceptionConstants.exception;
    }
  }

  // Email exist or not
  Future isEmailExist(String _email) async {
    try {
      bool _flag = false;
      final Future<QuerySnapshot<Map<String, dynamic>>> _forgot = _db
          .collection(DatabaseConstants.userTbl)
          .where(DatabaseConstants.email, isEqualTo: _email)
          .get();

      await _forgot.then((value) {
        debugPrint(value.docs.first.data()[DatabaseConstants.email]);
        if (_email == value.docs.first.data()[DatabaseConstants.email]) {
          _flag = true;
        }
      });
      return _flag;
    } catch (error) {
      debugPrint("Forgot Password Exception :- $error");
      return false;
    }
  }

  // reset password
  Future resetPassword(String _email, String _newPassword) async {
    try {
      bool _flag = false;
      final Query<Map<String, dynamic>> _resetPasswordResult = _db
          .collection(DatabaseConstants.userTbl)
          .where(DatabaseConstants.email, isEqualTo: _email);

      _resetPasswordResult.get().then(
        (value) async {
          await _db
              .collection(DatabaseConstants.userTbl)
              .doc(value.docChanges.first.doc.id)
              .update({DatabaseConstants.password: _newPassword});
        },
      );
      _flag = true;
      return _flag;
    } catch (error) {
      debugPrint("Reset Password Exception :- $error");
      return ExceptionConstants.exception;
    }
  }

  // update profile
  Future updateUserProfile(
      String _name,
      String _userName,
      String _email,
      String _mob,
      String _gender,
      String _dob,
      String _aboutMe,
      String _photo) async {
    try {
      final UserModel _user = UserModel();
      final Future<QuerySnapshot<Map<String, dynamic>>> _updateProfileResult =
          _db
              .collection(DatabaseConstants.userTbl)
              .where(DatabaseConstants.email, isEqualTo: _email)
              .get();

      _updateProfileResult.then(
        (value) async {
          await _db
              .collection(DatabaseConstants.userTbl)
              .doc(value.docChanges.first.doc.id)
              .update(
            {
              DatabaseConstants.name: _name,
              DatabaseConstants.userName: _userName,
              DatabaseConstants.mob: _mob,
              DatabaseConstants.gender: _gender,
              DatabaseConstants.dob: _dob,
              DatabaseConstants.aboutMe: _aboutMe,
              DatabaseConstants.photo: _photo,
            },
          );
        },
      );

      _user.name = _name;
      _user.userName = _userName;
      _user.mobile = _mob;
      _user.gender = _gender;
      _user.dob = _dob;
      _user.aboutMe = _aboutMe;
      _user.photo = _photo;

      return _user;
    } catch (error) {
      debugPrint("Update Profile Exception :- $error");
      return ExceptionConstants.exception;
    }
  }

  ///
  ///------------------------CHAT---------------------------
  ///

  // add user
  Future addUserToConversation(String _toSend) async {
    if (_toSend == AppPrefrences.getName()) return;
    final String _currentUser = AppPrefrences.getEmail();

    final String? _chatRoomID =
        UtiltyChatID.getChatRoomId(_toSend, _currentUser);
    if (_chatRoomID == null) return;

    final List<String> _users = [_toSend, _currentUser];
    final Map<String, dynamic> _chatRoomMap = {
      DatabaseConstants.chatBetween: _users,
      DatabaseConstants.chatID: _chatRoomID,
    };

    try {
      _db
          .collection(DatabaseConstants.chatTbl)
          .doc(_chatRoomID)
          .set(_chatRoomMap);
    } catch (error) {
      debugPrint("Add user exception :- $error");
      return ExceptionConstants.exception;
    }
  }

  // send message
  Future addConversationMsg(String _toSend, String? _message) async {
    if (_message == null || _message.isEmpty) return;

    final String _currentUser = AppPrefrences.getEmail();
    final String? _chatRoomID =
        UtiltyChatID.getChatRoomId(_toSend, _currentUser);
    final DateTime _now = DateTime.now();
    final DateFormat _formatter = DateFormat("dd-MM-yyyy");

    final ChatModel _chatMessage = ChatModel(
      message: _message,
      sendBy: _currentUser,
      time: DateFormat.jms().format(_now),
      date: _formatter.format(_now).toString().replaceAll("-", ""),
    );

    try {
      _db
          .collection(DatabaseConstants.chatTbl)
          .doc(_chatRoomID)
          .collection(DatabaseConstants.chats)
          .add(_chatMessage.toJSON());
    } catch (error) {
      debugPrint("send msg exception :- $error");
      return ExceptionConstants.exception;
    }
  }

  // get conversation
  getConversation(String _chatRoomID) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> _messages = await _db
          .collection(DatabaseConstants.chatTbl)
          .doc(_chatRoomID)
          .collection(DatabaseConstants.chats)
          .orderBy(DatabaseConstants.chatDate)
          .orderBy(DatabaseConstants.chatTime)
          .get();

      return _messages.docs
          .map((chat) => ChatModel.fromJson(chat.data()))
          .toList();
    } catch (error) {
      debugPrint("get msg exception :- $error");
      return ExceptionConstants.exception;
    }
  }

  // get users
  Future getUsers(String _email) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> _allUsers =
          await _db.collection(DatabaseConstants.userTbl).get();

      if (_allUsers.docs.isNotEmpty) {
        return _allUsers.docs
            .map((user) => UserModel.fromJson(user.data()))
            .where((user) => user.email != _email)
            .toList();
      }
    } catch (error) {
      debugPrint("get users exception :- $error");
      return ExceptionConstants.exception;
    }
  }

  // upload image
  Future uploadImages(File? _image) async {
    try {
      final String _fileName = basename(_image?.path ?? "");
      final Reference _firebaseStorageRef =
          FirebaseStorage.instance.ref().child("images/$_fileName");
      final UploadTask _uploadTask = _firebaseStorageRef.putFile(_image!);
      final TaskSnapshot _taskSnapshot =
          await _uploadTask.whenComplete(() => null);
      final Future<String> _url = _taskSnapshot.ref.getDownloadURL();
      return _url;
    } catch (error) {
      debugPrint("Image upload exception :- $error");
      return ExceptionConstants.exception;
    }
  }
}
