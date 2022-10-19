// user model

import 'package:pixalive/utils/app_constants.dart';

class UserModel {
  // user data fields
  String? userId;
  String? name;
  String? userName;
  String? email;
  String? password;
  String? aboutMe;
  String? mobile;
  String? gender;
  String? dob;
  String? location;
  String? photo;

  // constructor
  UserModel({
    this.userId,
    this.name,
    this.userName,
    this.email,
    this.password,
    this.aboutMe,
    this.mobile,
    this.gender,
    this.dob,
    this.location,
    this.photo,
  });

  Map<String, dynamic> toJSON() => {
        DatabaseConstants.userID: userId,
        DatabaseConstants.name: name,
        DatabaseConstants.userName: userName,
        DatabaseConstants.email: email,
        DatabaseConstants.password: password,
        DatabaseConstants.aboutMe: aboutMe,
        DatabaseConstants.dob: dob,
        DatabaseConstants.gender: gender,
        DatabaseConstants.mob: mobile,
        DatabaseConstants.location: location,
        DatabaseConstants.photo: photo,
      };

  UserModel.fromJson(Map<String, dynamic> map)
      : userId = map[DatabaseConstants.userID],
        name = map[DatabaseConstants.name],
        userName = map[DatabaseConstants.userName],
        email = map[DatabaseConstants.email],
        password = map[DatabaseConstants.password],
        aboutMe = map[DatabaseConstants.aboutMe],
        dob = map[DatabaseConstants.dob],
        gender = map[DatabaseConstants.gender],
        mobile = map[DatabaseConstants.mob],
        location = map[DatabaseConstants.location],
        photo = map[DatabaseConstants.photo];
}
