// ignore_for_file: must_be_immutable, prefer_final_fields, avoid_unnecessary_containers, avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_live_chat/app/chat_page.dart';
import 'package:flutter_live_chat/app/custom_bottom_navigation_bar.dart';
import 'package:flutter_live_chat/app/profile_page.dart';
import 'package:flutter_live_chat/app/tab_items.dart';
import 'package:flutter_live_chat/app/user_page.dart';
import 'package:flutter_live_chat/model/user_model.dart';
import 'package:flutter_live_chat/notification_handler.dart';
import 'package:flutter_live_chat/viewModel/all_users_view_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final FirebaseProcessUser? user;

  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.Users;

  Map<TabItem, Widget> _allPage = {
    TabItem.Users: const UserPage(),
    TabItem.Chat: const ChatPage(),
    TabItem.Profile: ChangeNotifierProvider(
      create: (context) => AllUsersViewModel(),
      child: const ProfilePage(),
    )
  };
  Map<TabItem, GlobalKey<NavigatorState>> _navigatorKey = {
    TabItem.Users: GlobalKey<NavigatorState>(),
    TabItem.Chat: GlobalKey<NavigatorState>(),
    TabItem.Profile: GlobalKey<NavigatorState>()
  };

  @override
  void initState() {
    super.initState();
    NotificationHandler().initializeFCMNotification(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: WillPopScope(
      onWillPop: () async =>
          await _navigatorKey[_currentTab]!.currentState!.maybePop(),
      child: CustomBottomNavigationBar(
          currentTab: _currentTab,
          onSelectedTab: (_selectedTab) {
            if (_selectedTab == _currentTab) {
              _navigatorKey[_currentTab]!.currentState!.popUntil(
                    (route) => route.isFirst,
                  );
            } else {
              setState(() {
                _currentTab = _selectedTab;
              });
            }
          },
          createdPage: _allPage,
          navigatorKey: _navigatorKey),
    ));
  }

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    //backgroundColor: Colors.grey,
    padding: const EdgeInsets.all(0),
  );
}
