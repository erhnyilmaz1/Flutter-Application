import 'package:flutter/material.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';

class NewPage extends StatefulWidget {
  const NewPage({Key key}) : super(key: key);

  @override
  State<NewPage> createState() => _NewPageState();
}
// 1.) Stagger => Sequential(Sıralı, Ardışık) Veya Overlapping (Üst Üste Gelme, Örtüşme) Şeklinde Animasyon Oluşturur. Controller Değeri 0 ile 1 Arasında Bu İşlemleri Yapar.
//     Örnek Olarak 0.100-0.125 Arası Opacity, 0.125-0.250 Arası Width , 0.250-0.375 Arası Height, 0.250-0.375 Arası Padding Özelliği Animasyon Olarak Verilsin.
//     Burada Opacity-Width Arası Sequential, Width-Height Arası Sequential, Height-Padding Arası Overlapping Olarak Çalışır.
// 2.) AnimatedBuilder, İçerisinde setState Barındırdığından Stagger İşlemleri Stateless Olarak Yapılır.

class _NewPageState extends State<NewPage> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  SequenceAnimation _sequenceAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    _sequenceAnimation = SequenceAnimationBuilder()
        .addAnimatable(
            animatable: Tween<double>(begin: 0, end: 1),
            from: Duration.zero,
            to: const Duration(milliseconds: 250),
            tag: 'opacity') // For Opacity
        .addAnimatable(
            animatable: Tween<double>(begin: 50, end: 150),
            from: const Duration(milliseconds: 250),
            to: const Duration(milliseconds: 500),
            tag: 'width') // For Width
        .addAnimatable(
            animatable: Tween<double>(begin: 50, end: 150),
            from: const Duration(milliseconds: 500),
            to: const Duration(milliseconds: 750),
            tag: 'height') // For Height
        .addAnimatable(
            animatable: EdgeInsetsTween(
                begin: const EdgeInsets.only(bottom: 16),
                end: const EdgeInsets.only(bottom: 75)),
            from: const Duration(milliseconds: 750),
            to: const Duration(milliseconds: 1000),
            tag: 'padding',
            curve: Curves.easeInCirc) // For Padding
        .addAnimatable(
            animatable: BorderRadiusTween(
              begin: BorderRadius.circular(4.0),
              end: BorderRadius.circular(75.0),
            ),
            from: const Duration(milliseconds: 750),
            to: const Duration(milliseconds: 1000),
            tag: 'borderRadius',
            curve: Curves.ease) // For BorderRadius
        .addAnimatable(
            animatable: ColorTween(
              begin: Colors.indigo[100],
              end: Colors.orange[400],
            ),
            from: const Duration(milliseconds: 1000),
            to: const Duration(milliseconds: 1500),
            tag: 'color',
            curve: Curves.ease) // For Color
        .animate(_controller);

    _controller.forward();
    // _controller.forward(); YAZILMAZSA ANİMASYON ÇALIŞMAZ!
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Next Page')),
      body: Center(
        child: AnimatedBuilder(
          //AnimatedBuilder, İçerisinde setState Barındırdığından Stagger İşlemleri Stateless Olarak Yapılır.
          animation: _controller,
          builder: (BuildContext context, Widget child) {
            return Container(
              padding: _sequenceAnimation['padding'].value,
              child: Opacity(
                opacity: _sequenceAnimation['opacity'].value,
                child: Container(
                  decoration: BoxDecoration(
                    color: _sequenceAnimation['color'].value,
                    border: Border.all(
                      width: 3,
                      color: Colors.pink[200],
                    ),
                    borderRadius: _sequenceAnimation['borderRadius'].value,
                  ),
                  width: _sequenceAnimation['width'].value,
                  height: _sequenceAnimation['height'].value,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
