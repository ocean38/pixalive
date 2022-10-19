import 'package:flutter/material.dart';
import 'package:pixalive/providers/fireStore_user_provider.dart';
import 'package:pixalive/utils/app_buttons.dart';
import 'package:pixalive/utils/app_colors.dart';
import 'package:pixalive/utils/app_loader.dart';
import 'package:pixalive/utils/app_routes.dart';
import 'package:pixalive/utils/app_snackbar.dart';
import 'package:pixalive/utils/app_textfromfield.dart';
import 'package:pixalive/utils/app_textstyles.dart';
import 'package:pixalive/utils/app_validations.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final UserProvider _fireStoreUserProvider = UserProvider();
  // From key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Text Controllers
  final TextEditingController _email = TextEditingController();

  @override
  void dispose() {
    // dispose text editing controller
    _email.dispose();
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
                  "Forgot Your Password?",
                  style: AppTextStyle.black24W700,
                ),

                SizedBox(height: _screensize.height * 0.02),

                // Text
                Text(
                  "Enter your register email address. We will \nsend you a reset password link.",
                  style: AppTextStyle.black16W300,
                ),

                SizedBox(height: _screensize.height * 0.05),

                // Email
                AppTextFormField(
                  validatorName: (value) =>
                      AppValidations.emailValidator(value),
                  controller: _email,
                  labelText: "Email Address",
                  focusNodeName: null,
                  nextFocus: null,
                  isPassword: false,
                ),

                SizedBox(height: _screensize.height * 0.09),

                // Create Account Button
                AppButtons.appGradientButton(
                  "Submit",
                  () async {
                    final _from = _formKey.currentState;
                    if (_from!.validate()) {
                      AppLoader.start(context);
                      final bool _forgetPasswordResult =
                          await _fireStoreUserProvider
                              .forgotPasswordProvider(_email.text);
                      AppLoader.close();
                      if (_forgetPasswordResult) {
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.otpPage,
                        );
                      } else {
                        Navigator.pop(context);
                        AppSnackbar.customSnackBar(
                          "Your email does not exist !",
                          context,
                        );
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
