// ignore_for_file: unused_field, unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:flutter_live_chat/app/home_page.dart';
import 'package:flutter_live_chat/app/sign_in/sign_in_page.dart';
import 'package:flutter_live_chat/viewModel/user_view_model.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _userViewModel = Provider.of<UserViewModel>(context);
    //debugPrint("UserViewModel State: ${_userViewModel.state.toString()}");
    //debugPrint("UserViewModel User: ${_userViewModel.user.toString()}");
    if (_userViewModel.state == ViewState.IDLE) {
      if (_userViewModel.user == null) {
        debugPrint("Show SignInPage");
        return const SignInPage();
      } else {
        debugPrint("Show HomePage");
        return HomePage(user: _userViewModel.user);
      }
    } else {
      // ViewState.BUSY
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
