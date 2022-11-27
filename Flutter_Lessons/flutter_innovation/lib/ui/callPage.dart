// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CallPage extends StatelessWidget {
  const CallPage(PageStorageKey<String> callPageKey, {Key? key})
      : super(key: callPageKey);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(10),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(10),
              color: index % 2 == 0
                  ? Colors.orange.shade200
                  : Colors.indigo.shade200,
              child: Center(
                child: Text(index.toString()),
              ),
            ),
          );
        });
  }
}
