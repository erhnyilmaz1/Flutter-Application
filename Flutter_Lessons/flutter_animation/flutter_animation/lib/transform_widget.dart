// ignore_for_file: avoid_unnecessary_containers
import 'package:flutter/material.dart';
class TransformWidget extends StatefulWidget {
  const TransformWidget({Key key}) : super(key: key);

  @override
  State<TransformWidget> createState() => _TransformWidgetState();
}
class _TransformWidgetState extends State<TransformWidget> {
  var _sliderValue = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transform Widgets'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          getSlider(),
          getRotate(), // x-y Eksenlerinde Belirli Açılarla(angle Parameter) Dönürme İşlemi
          getScale(), // x-y Eksenlerinde Belirli Değerlerle(scale Parameter) Büyütme-Küçültme İşlemi
          getTranslate(), // x-y Eksenlerinde Belirli Değerlerle(offset(x,y) Parameter) Yer Değiştirme İşlemi
        ],
      ),
    );
  }
  Slider getSlider() {
    return Slider(
        value: _sliderValue,
        onChanged: (_newValue) {
          _sliderValue = _newValue;
        });
  }
  Container getRotate() {
    return Container(
      child: Transform.rotate(
        angle: _sliderValue,
        child: Container(
          width: 100,
          height: 100,
          color: Colors.blue,
        ),
      ),
    );
  }
  Container getScale() {
    return Container(
      child: Transform.scale(
        scale: _sliderValue == 0.0 ? 1.0 : _sliderValue / 50.0,
        origin: Offset(_sliderValue, _sliderValue),
        child: Container(
          width: 100,
          height: 100,
          color: Colors.pink,
        ),
      ),
    );
  }
  Container getTranslate() {
    return Container(
      child: Transform.translate(
        offset: Offset(_sliderValue, _sliderValue),
        child: Container(
          width: 100,
          height: 100,
          color: Colors.teal,
        ),
      ),
    );
  }
}
