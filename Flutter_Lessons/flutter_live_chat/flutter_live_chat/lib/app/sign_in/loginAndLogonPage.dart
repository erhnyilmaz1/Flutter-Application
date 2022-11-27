// ignore_for_file: file_names, prefer_if_null_operators, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_live_chat/common_widget/platform_sensitive_alert_dialog.dart';
import 'package:flutter_live_chat/common_widget/social_login_button.dart';
import 'package:flutter_live_chat/viewModel/user_view_model.dart';
import 'package:provider/provider.dart';

import '../../model/user_model.dart';
import '../error_exception.dart';

// ignore: constant_identifier_names
enum FormType { REGISTER, LOGIN }

class LoginAndLogonPage extends StatefulWidget {
  const LoginAndLogonPage({Key? key}) : super(key: key);

  @override
  State<LoginAndLogonPage> createState() => _LoginAndLogonPageState();
}

class _LoginAndLogonPageState extends State<LoginAndLogonPage> {
  // ignore: unused_field
  late String _email, _password, _socialButtonText, _textButtonText;
  var _formType = FormType.LOGIN;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _email = "";
    _password = "";
    _socialButtonText = "";
    _textButtonText = "";
  }

  void _formSubmit() async {
    _formKey.currentState!.save();
    debugPrint('Email : $_email , Password : $_password');
    final _userViewModel = Provider.of<UserViewModel>(context, listen: false);

    if (_formType == FormType.LOGIN) {
      try {
        FirebaseProcessUser? _user =
            await _userViewModel.signInWithEmailAndPassword(_email, _password);
        debugPrint("Widget Login User Id : ${_user!.userId.toString()}");
      } on PlatformException catch (e) {
        PlatformSensitiveAlertDialog(
                title: 'Login User Error',
                content: Errors.showError(e.code),
                mainButtonText: 'OK')
            .show(context);
      }
    } else {
      try {
        FirebaseProcessUser? _user = await _userViewModel
            .createUserWithEmailAndPassword(_email, _password);
        debugPrint("Widget Create User Id : ${_user!.userId.toString()}");
      } on PlatformException catch (e) {
        PlatformSensitiveAlertDialog(
                title: 'Create User Error',
                content: Errors.showError(e.code),
                mainButtonText: 'OK')
            .show(context);
      }
    }
  }

  void _change() {
    setState(() {
      _formType =
          _formType == FormType.LOGIN ? FormType.REGISTER : FormType.LOGIN;
    });
  }

  @override
  Widget build(BuildContext context) {
    _socialButtonText = _formType == FormType.LOGIN ? 'Sign In' : 'Sign Up';
    _textButtonText = _formType == FormType.LOGIN
        ? 'Don' 't You Have An Account? Sign Up '
        : 'Do You Have An Account? Sign In';

    final _userModel = Provider.of<UserViewModel>(context);

    if (_userModel.user != null) {
      Future.delayed(
        const Duration(milliseconds: 1),
        () {
          Navigator.of(context).popUntil(ModalRoute.withName("/"));
        },
      );
    }

    return _userModel.state == ViewState.IDLE
        ? Scaffold(
            appBar: AppBar(
              title: const Text('Login / Logon Process'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        //initialValue: 'erhan.yilmaz@gmail.com', // Denemelerde Her Seferinde Yazmamak İçin Kullanılır.
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          errorText: _userModel.emailErrorMessage != ""
                              ? _userModel.emailErrorMessage
                              : "",
                          prefixIcon: const Icon(Icons.mail),
                          hintText: 'Email',
                          labelText: 'Email',
                          border: const OutlineInputBorder(),
                        ),
                        onSaved: (enteredEmail) {
                          _email = enteredEmail!;
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        //initialValue: 'erhnylmz', // Denemelerde Her Seferinde Yazmamak İçin Kullanılır.
                        obscureText:
                            true, // Password Alanının Gizli Olmasını Sağlar.
                        decoration: InputDecoration(
                          errorText: _userModel.passwordErrorMessage != ""
                              ? _userModel.passwordErrorMessage
                              : "",
                          prefixIcon: const Icon(Icons.password),
                          hintText: 'Password',
                          labelText: 'Password',
                          border: const OutlineInputBorder(),
                        ),
                        onSaved: (enteredPassword) {
                          _password = enteredPassword!;
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SocialLoginButton(
                        buttonText: _socialButtonText,
                        buttonColor: Theme.of(context).primaryColor,
                        //buttonIcon:  const Icon(Icons.forward),
                        radius: 10,
                        onPressed: () => _formSubmit(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        onPressed: () => _change(),
                        child: Text(_textButtonText),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
