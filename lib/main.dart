import 'package:flutter/material.dart';
import 'package:pixalive/providers/fireStore_user_provider.dart';
import 'package:pixalive/providers/firestore_chat_provider.dart';
import 'package:pixalive/providers/social_auth_provider.dart';
import 'package:pixalive/ui/chat_users_page.dart';
import 'package:pixalive/ui/create_account_page.dart';
import 'package:pixalive/ui/edit_profile.dart';
import 'package:pixalive/ui/forget_password_page.dart';
import 'package:pixalive/ui/forgot_link_sent.dart';
import 'package:pixalive/ui/home_page.dart';
import 'package:pixalive/ui/login_page.dart';
import 'package:pixalive/ui/onboarding_page.dart';
import 'package:pixalive/ui/otp_page.dart';
import 'package:pixalive/ui/reset_congratulations.dart';
import 'package:pixalive/ui/reset_password.dart';
import 'package:pixalive/ui/view_profile.dart';
import 'package:pixalive/ui/welcome_page.dart';
import 'package:pixalive/utils/app_prefrences.dart';
import 'package:pixalive/utils/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

// PIXALIVE
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialiaze the firebase
  await AppPrefrences.init(); // Initialiaze the Shared Prefrence
  runApp(MyApp());
}

// This widget is the root of your application.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Providers
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SocialAuthProvider>(
          create: (context) {
            return SocialAuthProvider();
          },
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) {
            return UserProvider();
          },
        ),
        ChangeNotifierProvider<ChatProvider>(
          create: (context) {
            return ChatProvider();
          },
        ),
      ],

      /// Material App
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: OnBoardingScreen(),

        /// Initial Route
        initialRoute: AppPrefrences.getIsTutorialVisited() != true
            ? AppRoutes.onBoarding
            : AppPrefrences.getSignIn() == true
                ? AppRoutes.homePage
                : AppRoutes.welcomePage,

        /// Routes
        routes: {
          AppRoutes.onBoarding: (context) => OnBoardingScreen(),
          AppRoutes.welcomePage: (context) => WelcomePage(),
          AppRoutes.homePage: (context) => HomePage(),
          AppRoutes.otpPage: (context) => OtpPage(),
          AppRoutes.resetPage: (context) => ResetPassword(),
          AppRoutes.viewProfile: (context) => ViewProfile(),
          AppRoutes.loginPage: (context) => LoginPage(),
          AppRoutes.chatUserPage: (context) => ChatUsersPage(),
          AppRoutes.createAccountPage: (context) => CreateAccountPage(),
          AppRoutes.editProfile: (context) => EditProfile(),
          AppRoutes.forgetPasswordPage: (context) => ForgetPasswordPage(),
          AppRoutes.forgotLinkSent: (context) => ForgotLinkSent(),
          AppRoutes.resetCongrats: (context) => ResetCongrats(),
        },
      ),
    );
  }
}
