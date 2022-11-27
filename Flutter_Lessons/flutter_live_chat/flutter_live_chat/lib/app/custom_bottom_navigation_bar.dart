import 'package:flutter/cupertino.dart';
import 'package:flutter_live_chat/app/tab_items.dart';
//import 'package:flutter_live_chat/admob_process.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar(
      {super.key,
      @required this.currentTab,
      @required this.onSelectedTab,
      @required this.createdPage,
      @required this.navigatorKey});

  final TabItem? currentTab;
  final ValueChanged<TabItem>? onSelectedTab;
  final Map<TabItem, Widget>? createdPage;
  final Map<TabItem, GlobalKey<NavigatorState>>? navigatorKey;

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  //late BannerAd _myBannerAd;

  @override
  void initState() {
    super.initState();
    //AdmobProcess.admobInitialize();
    //_myBannerAd = AdmobProcess.buildeBannerAd();
    //_myBannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    //_myBannerAd.load();

    return Column(
      children: [
        Expanded(
          child: CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
              items: [
                createdBottomNavigationItems(TabItem.Users),
                createdBottomNavigationItems(TabItem.Chat),
                createdBottomNavigationItems(TabItem.Profile),
              ],
              onTap: (index) => widget.onSelectedTab!(TabItem.values[index]),
            ),
            tabBuilder: (context, index) {
              final _showTabItem = TabItem.values[index];

              return CupertinoTabView(
                navigatorKey: widget.navigatorKey![_showTabItem],
                builder: (context) {
                  return widget.createdPage![_showTabItem]!;
                },
              );
            },
          ),
        ),
        const SizedBox(
          height: 45,
        ),
      ],
    );
  }

  BottomNavigationBarItem createdBottomNavigationItems(TabItem tabItem) {
    final _createdTab = TabItemData.allTab[tabItem];

    return BottomNavigationBarItem(
        label: _createdTab!.title, icon: Icon(_createdTab.icon));
  }
}
