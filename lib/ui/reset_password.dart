import 'package:flutter/material.dart';
import 'package:pixalive/providers/fireStore_user_provider.dart';
import 'package:pixalive/utils/app_buttons.dart';
import 'package:pixalive/utils/app_constants.dart';
import 'package:pixalive/utils/app_routes.dart';
import 'package:pixalive/utils/app_snackbar.dart';
import 'package:pixalive/utils/app_textfromfield.dart';
import 'package:pixalive/utils/app_textstyles.dart';
import 'package:pixalive/utils/app_validations.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  // From key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Focus Node
  FocusNode? _newPasswordFocus;
  FocusNode? _confrimPasswordFocus;

  // Text Controllers
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  @override
  void initState() {
    // parrent objects initialization
    super.initState();

    // Focus Nodes initialization
    _newPasswordFocus = FocusNode();
    _confrimPasswordFocus = FocusNode();
  }

  @override
  void dispose() {
    // Text Controllers
    _newPassword.dispose();
    _confirmPassword.dispose();

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
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black,
            icon: Icon(
              Icons.arrow_back,
            ),
          ),
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
                  "Reset Password",
                  style: AppTextStyle.black24W700,
                ),

                SizedBox(height: _screensize.height * 0.02),

                // Text
                Text(
                  "It's almost done. Enter your new password",
                  style: AppTextStyle.grey16W700,
                ),

                SizedBox(height: _screensize.height * 0.05),

                // new password
                AppTextFormField(
                  validatorName: (value) =>
                      AppValidations.passwordValidator(value),
                  controller: _newPassword,
                  labelText: "New Password",
                  focusNodeName: _newPasswordFocus,
                  nextFocus: _confrimPasswordFocus,
                  isPassword: true,
                ),

                SizedBox(height: _screensize.height * 0.025),

                // confirm password
                AppTextFormField(
                  validatorName: (value) =>
                      AppValidations.passwordValidator(value),
                  controller: _confirmPassword,
                  labelText: "Confirm Password",
                  focusNodeName: _confrimPasswordFocus,
                  nextFocus: null,
                  isPassword: true,
                ),

                SizedBox(height: _screensize.height * 0.09),

                // Create Account Button
                AppButtons.appGradientButton(
                  "Done",
                  () async {
                    final FormState? _from = _formKey.currentState;
                    if (_from!.validate()) {
                      if (_newPassword.text == _confirmPassword.text) {
                        final _result = await UserProvider()
                            .resetPasswordProvider(_newPassword.text);
                        if (_result == ExceptionConstants.exception) {
                          AppSnackbar.customSnackBar(
                              "SomeThing went wrong!", context);
                        } else if (_result) {
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.resetCongrats,
                          );
                        } else {
                          AppSnackbar.customSnackBar(
                              "Unable to change ur password !", context);
                        }
                      } else {
                        AppSnackbar.customSnackBar(
                            "Password must be same", context);
                      }
                      _from.reset();
                    }
                  },
                  AppTextStyle.white18W400,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
