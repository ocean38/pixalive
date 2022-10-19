// This file contains all Shared Preferences of the application
// To save the signed in user data

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPrefrences {
  static SharedPreferences? _preference;

  // initialization of the Shared prefrences
  static init() async {
    _preference = await SharedPreferences.getInstance();
  }

  ///
  static String _isTutorialVisited = "isTutorialVisited";
  static String _name = "name";
  static String _userName = "userName";
  static String _email = "email";
  static String _photoUrl = "photoUrl";
  static String _mob = "mob";
  static String _isSignIn = "isSocialLogIn";
  static String _aboutMe = "aboutMe";
  static String _dob = "dob";
  static String _gender = "gender";
  static String _userID = "userID";

  // USER ID
  static setUserID(value) {
    _preference?.setString(_userID, value);
  }

  static getUserID() {
    return _preference?.getString(_userID);
  }

  // User Name Social Auth
  static setUserName(value) {
    _preference?.setString(_userName, value);
  }

  static getUsetName() {
    return _preference?.getString(_userName);
  }

  // Gender
  static setGender(value) {
    _preference?.setString(_gender, value);
  }

  static getGender() {
    return _preference?.getString(_gender);
  }

  // DOB
  static setDOB(value) {
    _preference?.setString(_dob, value);
  }

  static getDOB() {
    return _preference?.getString(_dob);
  }

  // About Me
  static setAboutMe(value) {
    _preference?.setString(_aboutMe, value);
  }

  static getAboutMe() {
    return _preference?.getString(_aboutMe);
  }

  // Name Social Auth
  static setName(value) {
    _preference?.setString(_name, value);
  }

  static getName() {
    return _preference?.getString(_name);
  }

  // Email Social Auth
  static setEmail(value) {
    _preference?.setString(_email, value);
  }

  static getEmail() {
    return _preference?.getString(_email);
  }

  // Mobile Social Auth
  static setMob(value) {
    _preference?.setString(_mob, value);
  }

  static getMob() {
    return _preference?.getString(_mob);
  }

  // Photo Social Auth
  static setPhotoUrl(value) {
    _preference?.setString(_photoUrl, value);
  }

  static getPhotoUrl() {
    return _preference?.getString(_photoUrl);
  }

  // Tutorial Page visited
  static setIsTutorialVisited() {
    _preference?.setBool(_isTutorialVisited, true);
  }

  static getIsTutorialVisited() {
    return _preference?.getBool(_isTutorialVisited);
  }

  // Sign In in the app
  static setSignIn(val) {
    _preference?.setBool(_isSignIn, val);
  }

  static getSignIn() {
    return _preference?.getBool(_isSignIn);
  }

  static void ab() {
    debugPrint(getName());
    debugPrint(getUsetName());
    debugPrint(getEmail());
    debugPrint(getPhotoUrl());
  }

  // reset prefrences
  static void resetPrefrences() {
    _preference?.clear();
    AppPrefrences.setIsTutorialVisited();
  }
}
