import 'package:flutter/material.dart';

// ignore: constant_identifier_names
enum TabItem { Users, Chat,Profile }

class TabItemData {
  final String title;
  final IconData icon;

  TabItemData(this.title, this.icon);

  static Map<TabItem, TabItemData> allTab = {
    TabItem.Users: TabItemData("Users", Icons.supervised_user_circle),
    TabItem.Chat: TabItemData("Chat", Icons.chat),
    TabItem.Profile: TabItemData("Profile", Icons.person)
  };
}
