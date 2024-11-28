// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:universidad_lg_24/constants.dart';

class ButtonMain extends StatelessWidget {
  ButtonMain({
    this.onPress,
    super.key,
    this.text,
    this.bgColor = mainColor,
    this.textColor = Colors.white,
    this.routeName,
  });
  final String? text;
  Widget? onPress;
  final String? routeName;
  Color bgColor;
  Color textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(170, 50),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        backgroundColor: bgColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
      ),
      onPressed: (onPress != null && routeName != null)
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) {
                    return onPress!;
                  },
                  settings: RouteSettings(name: routeName),
                ),
              );
            }
          : null,
      child: (onPress != null && text != null)
          ? Text(text!, style: TextStyle(color: textColor))
          : Text(
              text ?? 'Proximamente',
              style: const TextStyle(color: mainColor),
            ),
    );
  }
}
