// This file contains all validation for text from field

class AppValidations {
  // Password validator
  static String? passwordValidator(String _password) {
    final String _str = r"^[a-zA-Z0-9@#$%^&*()+-?/;']";
    RegExp _rexp = new RegExp(_str);
    if (_password.length == 0)
      return "Required";
    else if (_password.length < 8)
      return "Length must be 8";
    else if (!_rexp.hasMatch(_password))
      return "Enter a valid Password";
    else
      return null;
  }

  // Name validator
  static String? nameValidator(String _name) {
    final String _str = r"(^[a-zA-Z ]*$)";
    RegExp _rexp = new RegExp(_str);
    if (_name.length == 0)
      return "Required";
    else if (!_rexp.hasMatch(_name))
      return "Name don't contain special character";
    else
      return null;
  }

  // UserName validator
  static String? userNameValidator(String _userName) {
    final String _str = r"(^[a-zA-Z0-9]*$)";
    RegExp _rexp = new RegExp(_str);
    if (_userName.length == 0)
      return "Required";
    else if (!_rexp.hasMatch(_userName))
      return "Username don't contain special character";
    else
      return null;
  }

  // Mobile validator
  static String? mobileNumberValidator(String _mob) {
    final String _str = r"(^[0-9]*$)";
    RegExp _rexp = new RegExp(_str);
    if (_mob.length == 0)
      return "Required";
    else if (_mob.length != 10)
      return "Enter a valid mob number";
    else if (!_rexp.hasMatch(_mob))
      return "Mobile number must be 0 to 9";
    else
      return null;
  }

  // Email validator
  static String? emailValidator(String _email) {
    final String str = r"^[a-zA-Z0-9_.-]+@[a-zA-Z0-9.]+.[a-zA-Z]";
    RegExp _rexp = new RegExp(str);
    if (_email.length == 0)
      return "Required";
    else if (!_rexp.hasMatch(_email))
      return "Enter a valid Email ID";
    else
      return null;
  }
}
