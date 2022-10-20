import 'package:flutter/material.dart';
import 'package:pixalive/database/models/user_model.dart';
import 'package:pixalive/providers/fireStore_user_provider.dart';
import 'package:pixalive/utils/app_buttons.dart';
import 'package:pixalive/utils/app_colors.dart';
import 'package:pixalive/utils/app_constants.dart';
import 'package:pixalive/utils/app_dialogbox.dart';
import 'package:pixalive/utils/app_loader.dart';
import 'package:pixalive/utils/app_routes.dart';
import 'package:pixalive/utils/app_snackbar.dart';
import 'package:pixalive/utils/app_textfromfield.dart';
import 'package:pixalive/utils/app_textstyles.dart';
import 'package:pixalive/utils/app_validations.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final UserProvider _fireStoreUserProvider = UserProvider();

  // form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Text Controllers
  final TextEditingController _name = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  // Focus Nodes Declaration
  FocusNode? _nameFocus;
  FocusNode? _userNameFocus;
  FocusNode? _emailFocus;
  FocusNode? _passwordFocus;

  @override
  void initState() {
    // parrent objects initialization
    super.initState();

    // Focus Nodes initialization
    _nameFocus = FocusNode();
    _userNameFocus = FocusNode();
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
  }

  @override
  void dispose() {
    // Focus Node Dispose
    _nameFocus?.dispose();
    _userNameFocus?.dispose();
    _emailFocus?.dispose();
    _passwordFocus?.dispose();

    // Text Controllers
    _name.dispose();
    _userName.dispose();
    _email.dispose();
    _password.dispose();

    // parrent objects dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size _screensize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.loginPage);
                },
                child: Container(
                  padding: EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.blue,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Text(
                    "Log In",
                    style: AppTextStyle.blue18W400,
                  ),
                ),
              ),
            ),
          ],
          leading: AppButtons.backButton(context, AppColor.black),
        ),
        // Body
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                SizedBox(height: _screensize.height * 0.01),
                // Text
                Text(
                  "Create Account",
                  style: AppTextStyle.black24W700,
                ),

                SizedBox(height: _screensize.height * 0.03),

                // Name
                AppTextFormField(
                  validatorName: (value) => AppValidations.nameValidator(value),
                  controller: _name,
                  labelText: "Name",
                  focusNodeName: _nameFocus,
                  nextFocus: _userNameFocus,
                  isPassword: false,
                ),
                SizedBox(height: _screensize.height * 0.01),

                // User Name
                AppTextFormField(
                  validatorName: (value) =>
                      AppValidations.userNameValidator(value),
                  controller: _userName,
                  labelText: "User Name",
                  focusNodeName: _userNameFocus,
                  nextFocus: _emailFocus,
                  isPassword: false,
                ),
                SizedBox(height: _screensize.height * 0.01),

                // Email
                AppTextFormField(
                  validatorName: (value) =>
                      AppValidations.emailValidator(value),
                  controller: _email,
                  labelText: "Email",
                  focusNodeName: _emailFocus,
                  nextFocus: _passwordFocus,
                  isPassword: false,
                ),
                SizedBox(height: _screensize.height * 0.01),

                // password
                AppTextFormField(
                  validatorName: (value) =>
                      AppValidations.passwordValidator(value),
                  controller: _password,
                  labelText: "Password",
                  focusNodeName: _passwordFocus,
                  nextFocus: null,
                  isPassword: true,
                ),

                SizedBox(height: _screensize.height * 0.09),

                // Create Account Button
                AppButtons.appGradientButton(
                  buttonName: "Create",
                  onTap: () async {
                    AppLoader.start(context);
                    final _from = _formKey.currentState;
                    if (_from!.validate()) {
                      final bool _forgetPasswordResult =
                          await _fireStoreUserProvider
                              .forgotPasswordProvider(_email.text);
                      if (!_forgetPasswordResult == false) {
                        AppSnackbar.customSnackBar(
                          "User Already exist",
                          context,
                        );
                        return;
                      }
                      final UserModel _user = UserModel(
                        name: _name.text,
                        userName: _userName.text,
                        email: _email.text,
                        password: _password.text,
                      );

                      final _result = await _fireStoreUserProvider
                          .createUserProvider(_user);
                      AppLoader.close();
                      if (_result == ExceptionConstants.exception) {
                        AppSnackbar.customSnackBar(
                            "Something went wrong", context);
                        return;
                      }
                      AppDialogBox.createAccountSuccessfully(context);
                      _from.reset();
                    }
                  },
                  buttonTextStyle: AppTextStyle.white18W400,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
