import 'package:flutter/material.dart';
import 'package:universidad_lg_24/constants.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: footerColor,
      height: MediaQuery.of(context).size.height * 0.08,
      child: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 40,
        ),
        child: Center(
          child: Text(
            'Copyright © 2024 UNIVERSIDAD LG Todos los derechos reservados',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
