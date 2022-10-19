/// This file contains all social auth providers

import 'package:flutter/cupertino.dart';
import 'package:pixalive/services/social_services/set_edit_profile.dart.dart';
import 'package:pixalive/services/social_services/social_authentications.dart';
import 'package:pixalive/utils/app_constants.dart';

class SocialAuthProvider extends ChangeNotifier {
  final SocialAuthentication _socialAuthentication = SocialAuthentication();

  // Google Sign in
  Future googleSignInProvider() async {
    final _googleUser = await _socialAuthentication.googleSignIn();
    if (_googleUser == ExceptionConstants.exception) {
      return ExceptionConstants.exception;
    }
    SetProfile.setUserOnFireBase(_googleUser);
    SetProfile.setProfileSharedPrefrences(_googleUser);
    notifyListeners();
  }

  // Fb Sign in
  Future fbSignInProvider() async {
    final _fbUser = await _socialAuthentication.facebookLogin();
    if (_fbUser == ExceptionConstants.exception) {
      return ExceptionConstants.exception;
    }
    SetProfile.setUserOnFireBase(_fbUser);
    SetProfile.setProfileSharedPrefrences(_fbUser);
    notifyListeners();
  }

  // Apple Sign in
  Future appleSignInProvider() async {
    final _appleUser = await _socialAuthentication.appleLogin();
    if (_appleUser == ExceptionConstants.exception) {
      return ExceptionConstants.exception;
    }
    SetProfile.setUserOnFireBase(_appleUser);
    SetProfile.setProfileSharedPrefrences(_appleUser);
    notifyListeners();
  }

  Future<void> signOut() async {
    await SocialSignOut.signOut();
    notifyListeners();
  }
}
