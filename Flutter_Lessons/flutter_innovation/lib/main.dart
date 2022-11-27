import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_innovation/ui/callPage.dart';
import 'package:flutter_innovation/ui/drawerUsage.dart';
import 'package:flutter_innovation/ui/homePage.dart';
import 'package:flutter_innovation/ui/pageViewPage.dart';
import 'package:flutter_innovation/ui/tabbarPage.dart';

import 'AppScrollBehavior .dart';

//import 'fontUsage.dart';

/*
      1.) PageStorageKey : Sayfada Yapılan Değişikliği Kaydeder. Sayfa Değiştirip Değişiklik Yaptığın Sayfaya Geri Geldiğinde Kaydedilmiş Halini Göstermeyi Sağlar.
 */

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.orange),
      home: const MyHomePage(),
      scrollBehavior: AppScrollBehavior(),
    );
  }
}

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedMenuItem = 0;
  List<Widget> allPage = [];
  late HomePage homePage;
  late CallPage callPage;
  //PageViewPage pageViewPage = const PageViewPage();
  late PageViewPage pageViewPage;

  var homePageKey = const PageStorageKey("key_home_page");
  var callPageKey = const PageStorageKey("key_call_page");
  var pageViewPageKey = const PageStorageKey("key_pageView_page");

  @override
  void initState() {
    super.initState();
    homePage = HomePage(homePageKey);
    callPage = CallPage(callPageKey);
    pageViewPage = PageViewPage(pageViewPageKey);
    allPage = [homePage, callPage, pageViewPage];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerUsage(),
      appBar: AppBar(
        title: const Text('Flutter Dersleri Bölüm 2',
            style: TextStyle(
              fontFamily: 'HandWriting',
            )),
      ),
      // body: const Center(
      //   child: FontUsage(),
      // ),
      body: selectedMenuItem <= allPage.length - 1
          ? allPage[selectedMenuItem]
          : allPage[0],
      bottomNavigationBar: bottomNavMenu(),
    );
  }

  Theme bottomNavMenu() {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.cyan.shade100,
        canvasColor: Colors.orangeAccent,
      ),
      child: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.amber,
            icon: Icon(Icons.home),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.red,
            icon: Icon(Icons.search),
            label: 'Ara',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.tealAccent,
            icon: Icon(Icons.add),
            label: 'Ekle',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.brown,
            icon: Icon(Icons.account_box),
            label: 'Profil',
          ),
        ],
        //type: BottomNavigationBarType.fixed, // 4 ögeden az ise bu çalışır.
        type: BottomNavigationBarType.shifting,
        // 4 ve fazla öge ise bu çalışır
        currentIndex: selectedMenuItem,
        onTap: (index) {
          setState(() {
            selectedMenuItem = index;
            if (index == 3) {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (tabbarContext) => const TabbarPage()))
                  .then((value) => selectedMenuItem = 0);
            }
          });
        },
      ),
    );
  }
}
