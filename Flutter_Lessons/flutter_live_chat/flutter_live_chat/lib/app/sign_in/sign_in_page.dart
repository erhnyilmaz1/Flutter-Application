// ignore_for_file: unnecessary_null_comparison, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
//import 'package:flutter/scheduler.dart';
//import 'package:flutter/services.dart';
//import 'package:flutter_live_chat/app/error_exception.dart';
import 'package:flutter_live_chat/app/sign_in/loginAndLogonPage.dart';
//import 'package:flutter_live_chat/common_widget/platform_sensitive_alert_dialog.dart';
import 'package:flutter_live_chat/common_widget/social_login_button.dart';
import 'package:flutter_live_chat/model/user_model.dart';
import 'package:flutter_live_chat/viewModel/user_view_model.dart';
import 'package:provider/provider.dart';

//late PlatformException _platformExceptionError;

class SignInPage extends StatefulWidget {
  const SignInPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // void anonymouslyLogin(BuildContext context) async {
  void signInWithGoogle(BuildContext context) async {
    final _userViewModel = Provider.of<UserViewModel>(context, listen: false);
    FirebaseProcessUser? _user = await _userViewModel.signInWithGoogle();
    debugPrint("Sign In Google User ${_user!.userId.toString()}");
  }

  void loginAndLogonProcess(BuildContext context) async {
    Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => const LoginAndLogonPage(),
    ));
  }

  @override
  void initState() {
    super.initState();
    // _platformExceptionError = PlatformException();
    // SchedulerBinding.instance.addPersistentFrameCallback((_) {
    //   if (_platformExceptionError != null) {
    //     PlatformSensitiveAlertDialog(
    //       title: 'Create User Error',
    //       content: Errors.showError(_platformExceptionError.code),
    //       mainButtonText: 'OK',
    //     ).show(context);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Lover'),
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade200,
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Sign In',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SocialLoginButton(
              buttonText: 'Sign In With Gmail',
              textColor: Colors.black87,
              buttonColor: Colors.white,
              buttonIcon: Image.asset('images/google-logo.png'),
              onPressed: () => signInWithGoogle(context),
            ),
            SocialLoginButton(
              buttonText: 'Sign In With Facebook',
              textColor: Colors.white,
              buttonColor: const Color(0xFF334D92),
              buttonIcon: Image.asset('images/facebook-logo.png'),
              onPressed: () {},
            ),
            SocialLoginButton(
              onPressed: () => loginAndLogonProcess(context),
              buttonText: 'Sign In With Email And Password',
              buttonIcon: const Icon(
                Icons.email,
                color: Colors.white,
                size: 32,
              ),
            ),
            // SocialLoginButton(
            //   onPressed: () => anonymouslyLogin(context),
            //   buttonColor: Colors.teal,
            //   buttonIcon: const Icon(Icons.supervised_user_circle),
            //   buttonText: 'Sign In Guest',
            // ),
          ],
        ),
      ),
    );
  }
}
