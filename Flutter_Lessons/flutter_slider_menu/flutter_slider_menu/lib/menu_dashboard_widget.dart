import 'package:flutter/material.dart';

TextStyle _textStyle = const TextStyle(
  color: Colors.white,
  fontSize: 20,
);
Color _backgroundColor = const Color(0xFF343442);

class MenuDashboard extends StatefulWidget {
  const MenuDashboard({Key? key}) : super(key: key);

  @override
  State<MenuDashboard> createState() => _MenuDashboardState();
}

class _MenuDashboardState extends State<MenuDashboard>
    with SingleTickerProviderStateMixin {
  late double _displayWidth = 0.0;
  //late double _displayHeight = 0.0;
  bool _isMenuOpen = false;

  late AnimationController _controller;
  late Animation<double> _scaleDashboardAnimation;
  late Animation<double> _scaleMenuAnimation;
  late Animation<Offset> _offsetMenuAnimation;
  final Duration _duration = const Duration(milliseconds: 300);

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: _duration);
    _scaleDashboardAnimation = Tween(begin: 1.0, end: 0.6).animate(_controller);
    _scaleMenuAnimation = Tween(begin: 1.0, end: 0.6).animate(_controller);
    _offsetMenuAnimation =
        Tween(begin: const Offset(-1, 0), end: const Offset(0, 0))
            .animate(_controller);

    _controller.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _displayWidth = MediaQuery.of(context).size.width;
    //_displayHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: Stack(children: [
          createMenu(context),
          createDashboard(context),
        ]),
      ),
    );
  }

  Widget createMenu(BuildContext context) {
    return SlideTransition(
      position: _offsetMenuAnimation,
      child: ScaleTransition(
        scale: _scaleMenuAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dashboard',
                  style: _textStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Messages',
                  style: _textStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Utility Bills',
                  style: _textStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Fund Transfer',
                  style: _textStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Branches',
                  style: _textStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget createDashboard(BuildContext context) {
    return AnimatedPositioned(
      duration: _duration,
      // top: _isMenuOpen ? 0.1 * _displayHeight : 0.0,
      // bottom: _isMenuOpen ? 0.1 * _displayHeight : 0.0,
      top: 0,
      bottom: 0,
      left: _isMenuOpen ? 0.4 * _displayWidth : 0.0,
      right: _isMenuOpen ? -0.4 * _displayWidth : 0.0,
      child: ScaleTransition(
        scale: _scaleDashboardAnimation,
        child: Material(
          borderRadius: _isMenuOpen
              ? const BorderRadius.all(Radius.circular(40.0))
              : null,
          elevation: 8.0,
          color: _backgroundColor,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (_isMenuOpen) {
                            _controller.reverse();
                          } else {
                            _controller.forward();
                          }
                          _isMenuOpen = !_isMenuOpen;
                        });
                      },
                      child: const Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'My Card',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    const Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  height: 200,
                  child: PageView(
                    children: [
                      Container(
                        color: Colors.pink,
                        width: 100,
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      Container(
                        color: Colors.purple,
                        width: 100,
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      Container(
                        color: Colors.teal,
                        width: 100,
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.person),
                        title: Text('Öğrenci $index'),
                        trailing: const Icon(Icons.add),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
