import 'package:flutter/material.dart';

class AnimationWidgets extends StatefulWidget {
  const AnimationWidgets({Key key}) : super(key: key);

  @override
  State<AnimationWidgets> createState() => _AnimationWidgetsState();
}

// 1.) AnimatedCrossFade => Verilen 2 Çocuk Arasında Animasyon Geçişi Yapar.
class _AnimationWidgetsState extends State<AnimationWidgets> {
  var _color = Colors.pink;
  var _width = 200.0;
  var _height = 200.0;
  var _isFirstChildActive = false;
  var _opacityValue = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Widgets'),
      ),
      body: Center(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(seconds: 2),
                  width: _width,
                  height: _height,
                  color: _color,
                ),
                ElevatedButton(
                  onPressed: () {
                    _animatedContainerProcess();
                  },
                  child: const Text('Animated Container'),
                  style: ElevatedButton.styleFrom(
                    primary: _color,
                  ),
                ),
                AnimatedCrossFade(
                  firstChild: Image.network(
                      'https://i.ytimg.com/vi/05vEbwazBs0/hqdefault.jpg'),
                  secondChild: Image.network(
                      'https://www.masalcisite.com/wp-content/uploads/bfi_thumb/car-33yvvk97uepc6lc8ru2r62.jpg'),
                  crossFadeState: _isFirstChildActive
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: const Duration(seconds: 3),
                ),
                ElevatedButton(
                  onPressed: () {
                    _animationCrossFadeProcess();
                  },
                  child: const Text('Animated Cross Fade'),
                  style: ElevatedButton.styleFrom(
                    primary: _color,
                  ),
                ),
                AnimatedOpacity(
                  opacity: _opacityValue,
                  duration: const Duration(seconds: 2),
                  child: const FlutterLogo(
                    size: 100,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _animationOpacityProcess();
                  },
                  child: const Text('Animated Opacity'),
                  style: ElevatedButton.styleFrom(
                    primary: _color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _animatedContainerProcess() {
    setState(() {
      _color = _color == Colors.pink ? Colors.yellow : Colors.pink;
      _width = _width == 200.0 ? 300.0 : 200.0;
      _height = _height == 200.0 ? 300.0 : 200.0;
    });
  }

  void _animationCrossFadeProcess() {
    setState(() {
      _isFirstChildActive = !_isFirstChildActive;
    });
  }

  void _animationOpacityProcess() {
    setState(() {
      _opacityValue = _opacityValue == 1.0 ? 0.5 : 1.0;
    });
  }
}
