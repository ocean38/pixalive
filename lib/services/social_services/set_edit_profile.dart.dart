import 'package:firebase_auth/firebase_auth.dart';
import 'package:pixalive/database/helper/firestore_helper.dart';
import 'package:pixalive/database/models/user_model.dart';
import 'package:pixalive/utils/app_prefrences.dart';

class SetProfile {
  static final FireStoreHelperDB _fireStoreHelperObj = FireStoreHelperDB();

  // Set data in shared prefrences
  static void setProfileSharedPrefrences(User _user) {
    if (_user.displayName != null) {
      AppPrefrences.setName(_user.displayName);
    }
    if (_user.email != null) {
      AppPrefrences.setEmail(_user.email);
    }
    if (_user.photoURL != null) {
      AppPrefrences.setPhotoUrl(_user.photoURL);
    } else {
      AppPrefrences.setPhotoUrl("null");
    }
    if (_user.phoneNumber != null) {
      AppPrefrences.setMob(_user.phoneNumber);
    }
    AppPrefrences.setSignIn(true);
  }

  // Set social signIn data to fireStore
  static void setUserOnFireBase(User _user) {
    UserModel _currentUser = UserModel();

    _currentUser.userId = _user.uid;
    _currentUser.name = _user.displayName;
    _currentUser.email = _user.email;
    _currentUser.mobile = _user.phoneNumber;
    _currentUser.photo = _user.photoURL;

    _fireStoreHelperObj.createUser(_currentUser);
  }

  static void loginSharedPrefrences(UserModel _user) {
    if (_user.userId != null) {
      AppPrefrences.setName(_user.userId);
    }
    if (_user.name != null) {
      AppPrefrences.setName(_user.name);
    }

    if (_user.userName != null) {
      AppPrefrences.setUserName(_user.userName);
    }
    if (_user.email != null) {
      AppPrefrences.setEmail(_user.email);
    }
    if (_user.aboutMe != null) {
      AppPrefrences.setAboutMe(_user.aboutMe);
    }
    if (_user.dob != null) {
      AppPrefrences.setDOB(_user.dob);
    }
    if (_user.mobile != null) {
      AppPrefrences.setMob(_user.mobile);
    }
    if (_user.gender != null) {
      AppPrefrences.setGender(_user.gender);
    }
    if (_user.photo != null) {
      AppPrefrences.setPhotoUrl(_user.photo);
    }

    AppPrefrences.setSignIn(true);
  }
}

// class UpdateUserProfile {
//   // static User _user = auth.currentUser;

//   static changePassword(String _email) async {
//     auth.sendPasswordResetEmail(email: _email);
//   }
// }
