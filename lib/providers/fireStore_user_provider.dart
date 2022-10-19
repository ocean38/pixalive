import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:pixalive/database/helper/firestore_helper.dart';
import 'package:pixalive/database/models/user_model.dart';
import 'package:pixalive/services/social_services/set_edit_profile.dart.dart';
import 'package:pixalive/utils/app_constants.dart';

class UserProvider extends ChangeNotifier {
  static final FireStoreHelperDB _fireStoreHelperObj = FireStoreHelperDB();

  //---------------------------Firestore provider-------------------------

  // Custom Sign in || Login Account
  Future loginUserProvider(String _email, String _password) async {
    final _customUser = await _fireStoreHelperObj.loginUser(_email, _password);
    if (_customUser == ExceptionConstants.exception) {
      return ExceptionConstants.exception;
    }
    SetProfile.loginSharedPrefrences(_customUser);
    notifyListeners();
    return _customUser;
    // await SocialAuthentication().customSignIn(_email, _password);
  }

  // Custom Sign UP || Create Account
  Future createUserProvider(UserModel _user) async {
    final _result = await _fireStoreHelperObj.createUser(_user);
    if (_result == ExceptionConstants.exception) {
      return ExceptionConstants.exception;
    }
    notifyListeners();
    return _result;
  }

  // forgot Password
  Future<bool> forgotPasswordProvider(String _email) async {
    AppConstansts.tempEmail = _email;
    final _result = await _fireStoreHelperObj.isEmailExist(_email);
    notifyListeners();
    return _result;
  }

  // reset Password
  Future resetPasswordProvider(String _newPassword) async {
    final _result = await _fireStoreHelperObj.resetPassword(
        AppConstansts.tempEmail, _newPassword);
    if (_result == ExceptionConstants.exception) {
      return ExceptionConstants.exception;
    }
    notifyListeners();
    return _result;
  }

  // edit profile
  Future updateUserProfileProvider(
    String _name,
    String _userName,
    String _email,
    String _mob,
    String _gender,
    String _dob,
    String _aboutMe,
    String _photo,
  ) async {
    final _result = await _fireStoreHelperObj.updateUserProfile(
        _name, _userName, _email, _mob, _gender, _dob, _aboutMe, _photo);
    if (_result == ExceptionConstants.exception) {
      return ExceptionConstants.exception;
    }
    SetProfile.loginSharedPrefrences(_result);
    notifyListeners();
    return _result;
  }

  // upload images
  Future updateProfileImage(File? _image) async {
    final _url = await _fireStoreHelperObj.uploadImages(_image);
    notifyListeners();
    return _url;
  }
}
