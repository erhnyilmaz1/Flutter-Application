// ignore_for_file: file_names

import 'package:flutter/material.dart';

class TabbarPage extends StatefulWidget {
  const TabbarPage({Key? key}) : super(key: key);

  @override
  _TabbarPageState createState() => _TabbarPageState();
}

class _TabbarPageState extends State<TabbarPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tabbar Usage'),
        bottom: tabBarMenu(),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          Container(
            color: Colors.redAccent,
            child: const Center(
              child: Text(
                'TAB 1',
                style: TextStyle(fontSize: 48),
              ),
            ),
          ),
          Container(
            color: Colors.blueAccent,
            child: const Center(
              child: Text(
                'TAB 2',
                style: TextStyle(fontSize: 48),
              ),
            ),
          ),
          Container(
            color: Colors.greenAccent,
            child: const Center(
              child: Text(
                'TAB 3',
                style: TextStyle(fontSize: 48),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: tabBarMenuBottom(),
    );
  }

  TabBar tabBarMenu() {
    return TabBar(
      controller: tabController,
      tabs: const <Widget>[
        Tab(
          icon: Icon(Icons.keyboard),
          text: 'Tab1',
        ),
        Tab(
          icon: Icon(Icons.lock),
          text: 'Tab2',
        ),
        Tab(
          icon: Icon(Icons.add_box),
          text: 'Tab3',
        ),
      ],
    );
  }

  Widget tabBarMenuBottom() {
    return Container(
      color: Colors.tealAccent,
      child: TabBar(
        controller: tabController,
        tabs: const <Widget>[
          Tab(
            icon: Icon(Icons.keyboard),
            text: 'Tab1',
          ),
          Tab(
            icon: Icon(Icons.lock),
            text: 'Tab2',
          ),
          Tab(
            icon: Icon(Icons.add_box),
            text: 'Tab3',
          ),
        ],
      ),
    );
  }
}
