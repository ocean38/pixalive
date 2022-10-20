// Class for image encoding and decoding in Base64

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class UtilityImage {
  static Image imageFromBase64String(String _base64String) {
    return Image.memory(
      base64Decode(_base64String),
      fit: BoxFit.fill,
    );
  }

  static Uint8List dataFromBase64String(String _base64String) =>
      base64Decode(_base64String);

  static String base64String(Uint8List _data) => base64Encode(_data);
}

class UtiltyChatID {
  static String? getChatRoomId(String? _toSend, String? _currentUser) {
    if (_toSend == _currentUser || _toSend == null || _currentUser == null)
      return null;
    return _toSend.hashCode <= _currentUser.hashCode
        ? "PIX@\$" + "${_toSend.hashCode}" + "@\$" + "${_currentUser.hashCode}"
        : "PIX@\$" + "${_currentUser.hashCode}" + "@\$" + "${_toSend.hashCode}";
  }
}
