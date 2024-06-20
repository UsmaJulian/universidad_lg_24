import 'package:flutter/material.dart';
import 'package:universidad_lg_24/constants.dart';

class ButtonMain extends StatelessWidget {
  ButtonMain({super.key, this.text, this.onPress});
  final String? text;
  Widget? onPress;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        backgroundColor: mainColor,
        shape: const RoundedRectangleBorder(),
      ),
      child: Text(text!),
      onPressed: () {
        if (onPress != null) {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) {
                return onPress!;
              },
            ),
          );
        }
      },
    );
  }
}
