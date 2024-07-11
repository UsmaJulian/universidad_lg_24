import 'package:flutter/material.dart';
import 'package:universidad_lg_24/constants.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const BottomAppBar(
      color: footerColor,
      height: 95,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 60,
        ),
        child: Center(
          child: Text(
            'Copyright © 2023 UNIVERSIDAD LG Todos los derechos reservados',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
