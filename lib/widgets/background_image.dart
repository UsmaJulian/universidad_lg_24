// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  BackgroundImage({required height, required image, super.key});
  double height = 0;
  final String image = '';
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    if (height == 0) {
      height = screenHeight;
    }

    return Container(
      height: height,
      width: screenWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
