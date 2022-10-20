import 'dart:io' as IO;
import 'package:flutter/material.dart';
import 'package:pixalive/providers/fireStore_user_provider.dart';
import 'package:pixalive/providers/social_auth_provider.dart';
import 'package:pixalive/utils/app_buttons.dart';
import 'package:pixalive/utils/app_colors.dart';
import 'package:pixalive/utils/app_constants.dart';
import 'package:pixalive/utils/app_images.dart';
import 'package:pixalive/utils/app_loader.dart';
import 'package:pixalive/utils/app_routes.dart';
import 'package:pixalive/utils/app_snackbar.dart';
import 'package:pixalive/utils/app_textfromfield.dart';
import 'package:pixalive/utils/app_textstyles.dart';
import 'package:pixalive/utils/app_validations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final UserProvider _fireStoreUserProvider = UserProvider();
  final SocialAuthProvider _socialAuthProvider = SocialAuthProvider();
  // From key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Text Controllers
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  // Focus Nodes Declaration
  FocusNode? _emailFocus;
  FocusNode? _passwordFocus;

  @override
  void initState() {
    // parrent objects initialization
    super.initState();

    // Focus Nodes initialization
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
  }

  @override
  void dispose() {
    // Focus Node Dispose
    _emailFocus?.dispose();
    _passwordFocus?.dispose();

    // Text Controllers
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
                  Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.createAccountPage,
                  );
                },
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: 5,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.blue,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Text(
                    "Create Account",
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
                  "Login",
                  style: AppTextStyle.black24W700,
                ),

                SizedBox(height: _screensize.height * 0.03),

                // Email
                AppTextFormField(
                  validatorName: (value) =>
                      AppValidations.emailValidator(value),
                  controller: _email,
                  labelText: "Email Address",
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

                SizedBox(height: _screensize.height * 0.01),

                // forgetPassword
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.forgetPasswordPage,
                      );
                    },
                    child: Text(
                      "Forgot Password?",
                      style: AppTextStyle.grey16W700,
                    ),
                  ),
                ),

                SizedBox(height: _screensize.height * 0.035),

                // Login Button
                AppButtons.appGradientButton(
                  buttonName: "Log In",
                  onTap: () async {
                    final FormState? _from = _formKey.currentState;
                    if (_from!.validate()) {
                      AppLoader.start(context);
                      final _result =
                          await _fireStoreUserProvider.loginUserProvider(
                        _email.text,
                        _password.text,
                      );
                      AppLoader.close();
                      if (_result == ExceptionConstants.exception) {
                        Navigator.pop(context);
                        AppSnackbar.customSnackBar(
                          "Email ID or password must be wrong !",
                          context,
                        );
                      } else {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          AppRoutes.homePage,
                          (Route<dynamic> route) => false,
                        );
                      }
                      _from.reset();
                    }
                  },
                  buttonTextStyle: AppTextStyle.white18W400,
                ),

                SizedBox(height: _screensize.height * 0.025),

                // Text
                Center(
                  child: Text(
                    "Or",
                    style: AppTextStyle.grey20Shade700,
                  ),
                ),

                SizedBox(height: _screensize.height * 0.025),

                // Social Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: _screensize.width * 0.04),

                    // FaceBook Button
                    AppButtons.socialAccountButton(
                      image: AppImages.facebookImage,
                      color: AppColor.facebookBlue,
                      onTap: () async {
                        AppLoader.start(context);
                        final _result =
                            await _socialAuthProvider.fbSignInProvider();
                        AppLoader.close();
                        if (_result == ExceptionConstants.exception) {
                          Navigator.pop(context);
                          AppSnackbar.customSnackBar(
                              "SomeThing went wrong with FaceBook SignIn !",
                              context);
                        } else {
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.homePage,
                          );
                        }
                      },
                    ),

                    // Google Button
                    AppButtons.socialAccountButton(
                      image: AppImages.googleImage,
                      color: AppColor.googleRed,
                      onTap: () async {
                        AppLoader.start(context);
                        final result =
                            await _socialAuthProvider.googleSignInProvider();
                        AppLoader.close();
                        if (result == ExceptionConstants.exception) {
                          Navigator.pop(context);
                          AppSnackbar.customSnackBar(
                            "SomeThing went wrong with Google SignIn !",
                            context,
                          );
                        } else {
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.homePage,
                          );
                        }
                      },
                    ),

                    // Apple Button
                    AppButtons.socialAccountButton(
                      image: AppImages.appleLogo,
                      color: AppColor.black,
                      onTap: () async {
                        if (IO.Platform.isIOS) {
                          AppLoader.start(context);
                          final _result =
                              await _socialAuthProvider.appleSignInProvider();
                          AppLoader.close();
                          if (_result == false) {
                            AppSnackbar.customSnackBar(
                                "Your iPhone is not support Apple SignIn",
                                context);
                          } else if (_result == ExceptionConstants.exception) {
                            Navigator.pop(context);
                            AppSnackbar.customSnackBar(
                              "SomeThing Went wrong with Apple SignIn",
                              context,
                            );
                          }
                        } else {
                          AppSnackbar.customSnackBar(
                            "Apple SignIn avaliable only in Apple devices",
                            context,
                          );
                        }
                      },
                    ),

                    SizedBox(width: _screensize.width * 0.04),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
