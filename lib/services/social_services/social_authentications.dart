// This file contains all the social signIn and signOut function

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:pixalive/utils/app_constants.dart';
import 'package:pixalive/utils/app_prefrences.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn googleSignInstance = GoogleSignIn();
final FacebookLogin facebookLoginInstance = FacebookLogin();
bool _isSignIn = false;

class SocialAuthentication {
  //-------------------------Singleton Obj-------------------------------

  static final SocialAuthentication _socialAuth = SocialAuthentication._();
  factory SocialAuthentication() {
    return _socialAuth;
  }
  SocialAuthentication._();

  //-------------------------GOOGLE-------------------------------

  Future googleSignIn() async {
    try {
      final GoogleSignInAccount? _signInAccount =
          await googleSignInstance.signIn();
      final GoogleSignInAuthentication _googleAccountAuthentication =
          await _signInAccount!.authentication;
      final OAuthCredential _credential = GoogleAuthProvider.credential(
        accessToken: _googleAccountAuthentication.accessToken,
        idToken: _googleAccountAuthentication.idToken,
      );

      final UserCredential _result =
          await FirebaseAuth.instance.signInWithCredential(_credential);
      final User? _user = _result.user;

      if (FirebaseAuth.instance.currentUser != null) {
        debugPrint("${_user!.displayName} Signed In Google \n");
        _isSignIn = true;
        return _user;
      } else {
        debugPrint("Unable to Sign In With Google \n");
        return ExceptionConstants.exception;
      }
    } catch (error) {
      debugPrint("Google Exception :- $error");
      return ExceptionConstants.exception;
    }
  }

  //-------------------FACEBOOK---------------------------

  Future facebookLogin() async {
    final FacebookLoginResult _result = await facebookLoginInstance.logIn();
    switch (_result.status) {
      case FacebookLoginStatus.cancel:
        break;
      case FacebookLoginStatus.error:
        return ExceptionConstants.exception;
      case FacebookLoginStatus.success:
        try {
          final _fbUser = await loginWithfacebook(_result);
          return _fbUser;
        } catch (error) {
          debugPrint("FB Exception :- $error \n");
        }
        break;
    }
  }

  // FaceBook login
  Future loginWithfacebook(_result) async {
    // final FacebookAccessToken _accessToken = _result.accessToken;
    // final AuthCredential _credential =
    //     FacebookAuthProvider.credential(_accessToken.token);

    // final UserCredential _facebookCredential =
    //     await FirebaseAuth.instance.signInWithCredential(_credential);
    // _isSignIn = true;
    // return _facebookCredential.user;
  }

  //-------------------APPLE---------------------------

  Future appleLogin() async {
    try {
      // if (!await AppleSignIn.isAvailable()) {
      //   return false;
      // }
      // final AuthorizationResult _result = await AppleSignIn.performRequests([
      //   AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
      // ]);

      // switch (_result.status) {
      //   case AuthorizationStatus.authorized:
      //     // final String _user = _result.credential.user;

      //     final AppleIdCredential _auth = _result.credential;
      //     final OAuthProvider _oAuthProvider = OAuthProvider("apple.com");

      //     final AuthCredential _credential = _oAuthProvider.credential(
      //       idToken: String.fromCharCodes(_auth.identityToken),
      //       accessToken: String.fromCharCodes(_auth.authorizationCode),
      //     );
      //     final UserCredential _appleUser =
      //         await auth.signInWithCredential(_credential);
      //     _isSignIn = true;
      //     return _appleUser.user;

      //     break;
      //   case AuthorizationStatus.error:
      //     debugPrint("Sign in failed: ${_result.error.localizedDescription}");
      //     break;
      //   case AuthorizationStatus.cancelled:
      //     debugPrint("User cancelled");
      //     break;
      // }
    } catch (error) {
      debugPrint("Apple sign in exception :- $error");
      return ExceptionConstants.exception;
    }
  }
  //-------------------Custom SignIn---------------------------

  Future customSignIn(String _email, String _password) async {
    try {
      final UserCredential _user = await auth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );

      return _user.user;
    } catch (e) {
      print("Exception =  $e");
      return ExceptionConstants.exception;
    }
  }

  //-------------------Create user SignUp---------------------------

  customSignUp(String _email, String _password, String _name) async {
    try {
      final UserCredential _result = await auth.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      _result.user!.updateDisplayName(_name);
    } catch (error) {
      debugPrint("Custom SignUp error :- $error");

      if (error == "The email address is already in use by another account.") {
        return "The email address is already in use by another account.";
      }
      return ExceptionConstants.exception;
    }
  }
}

//
//---------------------------Social Sign Out---------------------------
//
class SocialSignOut {
  static signOut() async {
    try {
      final User? _user = auth.currentUser;

      // Google sign out
      if (_isSignIn) {
        if (_user?.providerData[0].providerId == "google.com") {
          await googleSignInstance.disconnect();
          await googleSignInstance.signOut();
        }

        // facebook sign out

        else if (_user?.providerData[0].providerId == "facebook.com") {
          // await facebookLoginInstance.logOut();
        }

        // Apple sign out
        else if (_user?.providerData[0].providerId == "apple.com") {
          await auth.signOut();
        }

        // Custom and firebase sign out
        await auth.signOut();
        AppPrefrences.setSignIn(false);
        _isSignIn = false;
      }
    } finally {
      debugPrint("rest Pref");
      AppPrefrences.resetPrefrences();
    }
  }
}
