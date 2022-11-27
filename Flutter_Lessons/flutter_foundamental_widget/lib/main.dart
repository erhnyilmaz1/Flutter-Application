import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_foundamental_widget/navigator.dart';
import 'package:flutter_foundamental_widget/navigator/orangePage.dart';
import 'package:flutter_foundamental_widget/navigator/redPage.dart';
import 'package:flutter_foundamental_widget/onGeneratedRoute.dart';
//import 'package:flutter_foundamental_widget/buttons.dart';
//import 'package:flutter_foundamental_widget/imageExample.dart';
//import 'package:flutter_foundamental_widget/dropDownButton.dart';
//import 'package:flutter_foundamental_widget/popupMenuButton.dart';
//import 'package:flutter_foundamental_widget/cardAndListTile.dart';
//import 'package:flutter_foundamental_widget/listView.dart';
//import 'package:flutter_foundamental_widget/listViewLayout.dart';
//import 'package:flutter_foundamental_widget/gridview.dart';
//import 'package:flutter_foundamental_widget/boxDecoration.dart';
//import 'package:flutter_foundamental_widget/gestureDetector.dart';
//import 'package:flutter_foundamental_widget/customScrollView.dart';

//---------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
   1.)  StatelessWidget ==> SAYFADA HERHANGİ BİR ŞEY DEĞİŞTİRİLMEZSE KULLANILIR.
   2.)  StatefulWidget  ==> SAYFADA HERHANGİ BİR ŞEY DEĞİŞTİRİLİRSE  KULLANILIR. (StatefulWidget = StatelessWidget + STATE [SAYFADAKİ DEĞİŞİKLİK])
   3.)  Hot Reload (CTRL + F5) ==> SADECE build() METODUNDA DEĞİŞİKLİĞİ ALGILAR; runApp() METODU İÇERİSİNDEKİ DEĞİŞİKLİĞİ ALGILAMAZ.
   4.)  setState ((){}); ==> StatefulWidget'DA KULLANILIR. TANIMLANDIĞI WIDGET'IN İÇERİSİNDEKİ build() METODUNU TEKRAR TETİKLER.
   5.)  assets FOLDER'I OLUŞTURDUKTAN SONRA RESİM VEYA FONTLARI KULLANABİLMEK İÇİN pubspec.yaml içerisindeki "assets" KISMININ YORUMUNU KALDIRDIKTAN SONRA AŞAĞIDAKİ DEĞİŞİKLİK YAPILMALIDIR:
      assets:
          - assets/images/
  6.)  Image.asset("path")   ==> RESMİ DOSYADAN ALMA.
  7.)  Image.network("link") ==> RESMİ INTERNET LİNKİNDEN ALMA.
  8.)  CircleAvatar("link")  ==> RESMİ INTERNET LİNKİNDEN ALMA VE EKRAN ÇERÇEVESİNİ YUVARLAK YAPMA. backgroundImage PARAMETRESİNİ
  AŞAĞIDAKİ GİBİ KULLANIR:
                          backgroundImage: AssetImage(_logoURL)
                          backgroundImage: NetworkImage(_logoURL),
   9.)  IntrinsicHeight ==> SAYFA İÇERİSİNDEKİ TÜM ELEMANLARIN YÜKSEKLİK DEĞERİNİ, SAYFA İÇERİSİNDE YÜKSEKLİK DEĞERİ EN FAZLA OLAN ELEMANIN YÜKSEKLİK DEĞERİNE SETLER.
   10.) FadeInImage ==> SAYFA YÜKLENENE KADAR EKRANDA BAŞKA BİR RESİM GÖSTERMEYİ SAĞLAR.
        ÖRNEK : FadeInImage.assetNetwork( placeholder: "assets/images/loading.gif", image: _imageURL)
   11.) BUTTON ÇEŞİTLERİ ==> TextButton, TextButton.icon, ElevatedButton, ElevatedButton.icon,OutlinedButton,OutlinedButton.icon
   12.) Navigator : SAYFALAR ARASI GEÇİŞ SAĞLAR.
        Navigator.push(context,CupertinoPageRoute(builder: (redContext) => RedPage()));
        Navigator.of(context).push(MaterialPageRoute( builder: (redContext) => RedPage()));
   13.) CupertinoPageRoute ==> IOS İÇİN PAGE ROUTE
        MaterialPageRoute  ==> ANDROİD İÇİN PAGE ROUTE
   14.) maybePop() : POP EDİLECEK SAYFA VARSA POP EDER VE ÇALIŞIR, POP EDİLECEK SAYFA YOKSA ÇALIŞMAZ.
   15.) canPop()   : boolean DÖNDÜRÜR. POP EDİLECEK SAYFA OLUP OLMADIĞINI KONTROL EDER.
   16.) Navigator.pushReplacement ==> ANA SAYFAYI ROUTE EDİLEN SAYFA YAPAR. SAYFA YÖNLENDİRME BUTONLARI (Back , Next) OLMAZ.
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (greenContext) => GreenPage()));
   17.) routes : ROUTE EDİLECEK SAYFALARI BELİRLER . {"keyName" : (context) => RoutePage,} FORMATINDADIR.
        "/redPage": (context) => RedPage(),
        //  "/" : (context) => Scaffold(), ==> BUNU KULLANIRSAK home PROPERTIES'I KULLANMAMALIYI; YOKSA HATA ALIR.
        "/orangePage": (context) => OrangePage(),
   18.) onUnknownRoute  : routes İÇERİSİNDE OLMAYAN KEY'İ YÖNLENDİRME YAPMAK İSTERSEK BURASI ÇALIŞIR.
   19.) Navigator.pushNamed(context, "/redPage"); ==> routes İÇERİSİNDE YER ALAN "/redPage" KEY DEĞERİNİN YÖNLENDİRMEK İSTEDİĞİ SAYFAYA YÖNLENDİRİR.
   20.) onGenerateRoute : routes'in Dinamik Halidir. Sayfalar Arası Veri Gönderimi Sağlar. Belirli Koşullara Göre Çalışabilir. routes STATİKTİR.
   21.) Yeni Sayfaya Veri Gönderme Yöntem ==> Navigator.of(context).pushNamed("/studentList", arguments: 80)
        arguments Keyword'u Object Type'dadır. İçerisindeki Değer Yeni Sayfaya Gönderilen Değerdir.
   22.) Yeni Sayfada Veri Alma Yöntem 1                  ==> variableType variableName = ModalRoute.of(context)!.settings.arguments as variableType
   23.) Yeni Sayfada Veri Alma Yöntem 2 (KURUCU METOTTA) ==> variableType variableName = settings.arguments as variableType
   24.) settings : settings ==> RouteSettings türündeki setting'i YENİ SAYFAYA GÖNDERMELİYİZ; YOKSA HATA ALINIR. (Soldaki YENİ Sayfa , Sağdaki ESKİ Sayfa) Bu İşlem PageRoute İçerisinde Yapılır. Örnek :  return MaterialPageRoute( settings: settings, builder: (context) => widgetName);
   25.) popUntil : Belli Bir Koşula Kadar Sayfayı POP EDER. 
        Örnek : Navigator.popUntil(context, (route) => route.isFirst);
        route.isFirst                        ==> Ana Sayfa
        /                                    ==> Ana Sayfa
        route.settings.name == "/purplePage" ==> Koşuldaki Route'a Kadar
   26.) pushNamedAndRemoveUntil : Belli Bir Koşula Kadar Sayfayı POP EDER, DAHA SONRA İLK PARAMETREDEKİ SAYFAYA GİDER. 
        Örnek :  Navigator.pushNamedAndRemoveUntil( context, "/yellowPage", (route) => route.isFirst);
    
*/
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------

void main() {
  //debugPrint("Main Method Run");
  runApp(MyApp());
  // runApp( return MaterialApp(
  //     title: "My Counter AppBar",
  //     theme: ThemeData(primarySwatch: Colors.teal),
  //     home: MyHomePage(),
  //   ););
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  //..customAnimation = CustomAnimation();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("MyApp Class Run");
    return MaterialApp(
      title: "My Counter AppBar",
      theme: ThemeData(
          //primarySwatch: Colors.purple,
          outlinedButtonTheme:
              OutlinedButtonThemeData(style: OutlinedButton.styleFrom()),
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue))),
          textTheme: TextTheme(
              headline1: TextStyle(
                  color: Colors.purple, fontWeight: FontWeight.bold))),
      home: Scaffold(
        appBar: AppBar(title: Text("Erhan")),
        // body: ImageExample(),
        // body: Buttons(),
        // body: DropDownButtons(),
        // body: PopupMenuButtons(),
        // body: CardAndListTales(),
        // body: ListViewUsage(),
        // body: ListViewLayout(),
        // body: GridViewUsage(),
        // body: BoxDecorationUsed(),
        // body: GestureDetectorUsage(),
        // body: CustomScrollViewUsage(),
        body: NavigatorUsage(),
      ),
      // routes: {
      //   "/redPage": (context) => RedPage(),
      //   //  "/" : (context) => Scaffold(), ==> BUNU KULLANIRSAK home PROPERTIES'I KULLANMAMALIYI; YOKSA HATA ALIR.
      //   "/orangePage": (context) => OrangePage(),
      // },
      // onUnknownRoute: (settings) => MaterialPageRoute(
      //     builder: (context) => Scaffold(
      //           appBar: AppBar(
      //             title: Text("ERROR"),
      //           ),
      //           body: Center(
      //             child: Text("404"),
      //           ),
      //         )),
      onGenerateRoute: OnGeneratedRoute.onGeneratedRoute,
      builder: EasyLoading.init(),
    );
  }
}
