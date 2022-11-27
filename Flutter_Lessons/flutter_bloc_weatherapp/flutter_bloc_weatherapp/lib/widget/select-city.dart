// ignore_for_file: file_names

import 'package:flutter/material.dart';

class SelectCityWidget extends StatelessWidget {
  const SelectCityWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select City'),
      ),
      body: Form(
          child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _textController,
                decoration: const InputDecoration(
                  labelText: 'City',
                  hintText: 'Choose City',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                // 2.Parametrede TextFormFiled'deki Değeri Gönder.
                Navigator.pop(context, _textController.text);                
              },
              icon: const Icon(Icons.search))
        ],
      )),
    );
  }
}
