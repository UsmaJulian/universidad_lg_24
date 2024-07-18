import 'package:flutter/material.dart';
import 'package:universidad_lg_24/constants.dart';

class BodyFooter extends StatelessWidget {
  const BodyFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container( 
      width: MediaQuery.of(context).size.width,
      height: 85,
      decoration: const BoxDecoration(color: footerColor),
      child: const Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40
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