// ignore_for_file: prefer_equal_for_default_values

import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    Key? key,
    required this.buttonText,
    this.buttonColor: Colors.purple,
    this.textColor: Colors.white,
    this.radius: 16,
    this.height: 40,
    this.buttonIcon: const Icon(Icons.add),
    required this.onPressed,
  }) : super(key: key);

  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final double radius;
  final double height;
  final Widget buttonIcon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: SizedBox(
        height: height,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buttonIcon,
              Text(
                buttonText,
                style: TextStyle(
                  color: textColor,
                ),
              ),
              Opacity(
                opacity: 0,
                child: buttonIcon,
              ),
            ],
          ),
          style: ElevatedButton.styleFrom(
            primary: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius)),
            ),
          ),
        ),
      ),
    );
  }
}
