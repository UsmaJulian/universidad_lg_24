// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:universidad_lg_24/constants.dart';

class ButtonMain extends StatelessWidget {
  ButtonMain({this.onPress, super.key, this.text});
  final String? text;
  Widget? onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        backgroundColor: mainColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
      ),
      onPressed: (onPress != null)
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) {
                    return onPress!;
                  },
                ),
              );
            }
          : null,
      child: (onPress != null)
          ? Text(text!, style: const TextStyle(color: Colors.white))
          : const Text('Próximamente', style: TextStyle(color: mainColor)),
    );
  }
}
