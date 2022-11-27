// ignore_for_file: use_key_in_widget_constructors
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_live_chat/common_widget/platform_sensitive_widget.dart';

class PlatformSensitiveAlertDialog extends PlatformSensitiveWidget {
  final String title;
  final String content;
  final String mainButtonText;
  final String? cancelButtonText;

  const PlatformSensitiveAlertDialog({
    required this.title,
    required this.content,
    required this.mainButtonText,
    this.cancelButtonText,
  });

  Future<bool?> show(BuildContext context) async {
    return Platform.isIOS
        ? await showCupertinoDialog<bool>(
            context: context, builder: (context) => this)
        : await showDialog<bool>(
            context: context,
            builder: (context) => this,
            barrierDismissible: false);
  }

  @override
  Widget buildAndroidWidget(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: createMainCancelButtons(context),
    );
  }

  @override
  Widget buildIOSWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: createMainCancelButtons(context),
    );
  }

  createMainCancelButtons(BuildContext context) {
    List<Widget> _allButtons = [];

    if (Platform.isIOS) {
      if (cancelButtonText != null) {
        _allButtons.add(
          CupertinoDialogAction(
            child: Text(cancelButtonText!),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        );
      }

      _allButtons.add(
        CupertinoDialogAction(
          child: Text(mainButtonText),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      );
    } else {
      if (cancelButtonText != null) {
        _allButtons.add(
          ElevatedButton(
            child: Text(cancelButtonText!),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        );
      }

      _allButtons.add(
        ElevatedButton(
          child: Text(mainButtonText),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      );
    }
  }
}
