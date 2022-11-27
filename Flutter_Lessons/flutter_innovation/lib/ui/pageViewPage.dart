// ignore_for_file: file_names

import 'package:flutter/material.dart';

class PageViewPage extends StatefulWidget {
  const PageViewPage(PageStorageKey<String> pageViewPageKey, {Key? key})
      : super(key: pageViewPageKey);

  @override
  _PageViewPageViewState createState() => _PageViewPageViewState();
}

class _PageViewPageViewState extends State<PageViewPage> {
  var pageViewPageController =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
  bool isScrolDirection = true;
  bool isReverse = false;
  bool isPageSnapping = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            scrollDirection:
                isScrolDirection ? Axis.horizontal : Axis.horizontal,
            reverse: isReverse,
            controller: pageViewPageController,
            pageSnapping: isPageSnapping,
            onPageChanged: ((index) {
              debugPrint("Changed Page Index: $index");
            }),
            children: [
              Container(
                width: double?.infinity,
                height: 300,
                color: Colors.amber,
                child: Center(
                  child: Column(
                    children: [
                      const Text(
                        'Sayfa 0',
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(
                        width: 200.0,
                        height: 50.0,
                        child: ElevatedButton(
                          onPressed: () {
                            pageViewPageController.jumpToPage(2);
                          },
                          child: const Center(
                            child: Text('2.Sayfaya Git'),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: double?.infinity,
                height: 300,
                color: Colors.purple.shade100,
                child: const Center(
                  child: Text(
                    'Sayfa 1',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
              Container(
                width: double?.infinity,
                height: 300,
                color: Colors.indigoAccent,
                child: const Center(
                  child: Text(
                    'Sayfa 2',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            width: double?.infinity,
            height: 300,
            color: Colors.blueGrey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text('Scroll Direction'),
                      Checkbox(
                        value: isScrolDirection,
                        onChanged: (val) {
                          setState(() {
                            isScrolDirection = val!;
                          });
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text('Reverse'),
                      Checkbox(
                        value: isReverse,
                        onChanged: (val) {
                          setState(() {
                            isReverse = val!;
                          });
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text('Page Snapping'),
                      Checkbox(
                        value: isPageSnapping,
                        onChanged: (val) {
                          setState(() {
                            isPageSnapping = val!;
                          });
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
