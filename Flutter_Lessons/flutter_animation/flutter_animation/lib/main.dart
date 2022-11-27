import 'package:flutter/material.dart';
import 'package:flutter_animation/new_page.dart';
import 'package:flutter_animation/transform_widget.dart';

import 'animation_widget.dart';

void main() {
  runApp(const MyApp());
}

// Dart'da Mixin , Bir Sınıfın Özelliklerini Başka Sınıftan Extend Etmeden Kullanma Biçimidir. (with Mixin Şeklinde Yapılır.)
// Dart'da NORMALDE 1 CLASS SADECE 1 CLASS'I EXTEND EDER ; AMA Mixin YAPISI İLE BU YAPI FARKLILAŞIR. (_MyHomePageState Class'ı Hem MyHomePage Class'ını Hem de SingleTickerProviderStateMixin Class'ının Özelliklreini Kullanır. )
// Örnek: class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin.
// 1.) Ticker ==>
// 2.) Animasyon ==>
// 3.) Animasyon Controller ==> Fazladan Kaynak Ve Memory Oluşmaması İçin Muhakkak dispose Metodu Kullanılmalıdır.
//     @override
//      void dispose() {
//        super.dispose();
//        _controller.dispose();
//      }
// 4.) Animation Değeri, Tween ve Curve Olmak Üzere 2 Şeklide Oluşturulur.
// 5.) Tween ==> (begin : value1, end  : value2).animate(parent: _controller) Değerleri Arasında Değer Üretir. Doğrusal (Lineer) Hareket Eder, Zıplama Yoktur.
// 6.) Curve ==> (parent: value1, curve: value2) Değerleri Arasında Değer Üretir. Eğrisel  (Lineer Olmayan) Hareket Eder, Zıplama Vardır.

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  AnimationController _controller;
  Animation _animation;
  Animation _animation2;
  Animation _animation3;

  @override
  void initState() {
    super.initState();

    //----------------------------------------------------------------------------------------------------------------------------------------------------------
    // ANIMATINCONTROLLER
    //----------------------------------------------------------------------------------------------------------------------------------------------------------

    _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 3),
        lowerBound: 0,
        upperBound: 100);

    _controller.addListener(() {
      // setState MUHAKKAK YAZILMALIDIR/
      setState(() {
        // debugPrint(_controller.value.toString());
        // debugPrint(_animation.value.toString());
      });

      _controller
          .forward(from: 20)
          .orCancel; // orCancel İle İşlem Hatalı Olursa Animasyonu İptal Etme SAğlanır.
      // from: lowerBound'da Verdiğin Değer Yerine Verdiğin Değerden Başlatır. (Yukarıda Yer Alan 10 Değeri Yerine from İçerisindeki 20 Değerinden Başlatır.)
      // _controller.forward() : lowerBound'dan upperBound'a Gider.
      // _controller.reverse() : upperBound'dan lowerBound'a Gider.

      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller
              .reverse()
              .orCancel; // orCancel İle İşlem Hatalı Olursa Animasyonu İptal Etme SAğlanır.
        } else if (status == AnimationStatus.dismissed) {
          _controller
              .forward()
              .orCancel; // orCancel İle İşlem Hatalı Olursa Animasyonu İptal Etme SAğlanır.
        }
        // debugPrint("Durum : " + status.toString());
      });

      //----------------------------------------------------------------------------------------------------------------------------------------------------------

      //----------------------------------------------------------------------------------------------------------------------------------------------------------
      // ANIMATION
      //----------------------------------------------------------------------------------------------------------------------------------------------------------
      //_animation = Tween(begin: 20, end: 50).animate(_controller);

      _animation = ColorTween(begin: Colors.red, end: Colors.yellow)
          .animate(_controller);

      _animation2 = AlignmentTween(
              begin: const Alignment(-1, -1), end: const Alignment(1, 1))
          .animate(_controller);

      _animation3 = CurvedAnimation(
          parent: _controller,
          curve: Curves.bounceIn); // Onlarca Curves Çeşidi Vardır.
      // _controller İel 0-1 Arasında Değer Üretildi.

      _animation2 = AlignmentTween(
              begin: const Alignment(-1, -1), end: const Alignment(1, 1))
          .animate(CurvedAnimation(
              parent: _controller, curve: Curves.easeInOutExpo));

      //----------------------------------------------------------------------------------------------------------------------------------------------------------
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.teal.withOpacity(_controller.value / 100.0), // withOpacity, 0-1 Arası Değer Aldığından controller.value/100 Yapıldı.
      // double Değerleri controller.value(lowerBound ve UpperBound doble döndürdüğünden) Kullanarak Animasyon Haline Getirebiliriz.

      backgroundColor: _animation.value,
      // Animation İle Color Değer Üretildi.(_animation'a ColorTween İle Color Atandı.)

      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
              style: TextStyle(fontSize: _animation3.value * 20),
            ),
            Container(
              height: 100,
              alignment: _animation2.value,
              // Animation İle Alignment Değer Üretildi.(_animation2'ye AlignmentTween İle Alignment Atandı.)

              child: Text('$_counter',
                  style: TextStyle(fontSize: _controller.value + 20)),
            ),
            const Hero(
              tag: 'Erhan',
              child: FlutterLogo(
                size: 64,
                textColor: Colors.purple,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: ((context) => const NewPage())));
              },
              child: const Text('Next Page'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const AnimationWidgets())));
              },
              child: const Text('Animation Widgets'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const TransformWidget())));
              },
              child: const Text('Transform Widgets'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
