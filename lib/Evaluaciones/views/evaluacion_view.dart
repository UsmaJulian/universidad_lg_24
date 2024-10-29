import 'package:flutter/material.dart';
import 'package:universidad_lg_24/Evaluaciones/views/widgets/evaluacion_content.dart';

import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/widgets/global/header_global.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';

class EvaluacionView extends StatelessWidget {
  const EvaluacionView({
    required this.user,
    super.key,
  });
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: const Color(0xffF6F3EB),
      appBar: CustomAppBar(),
      endDrawer: DrawerMenu(
        user: user,
        isHome: true, // Indica que el DrawerMenuLeft se está utilizando
        // en la pantalla de inicio.
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 120),
        child: EvaluacionContent(
          user: user,
        ),
      ),
    );
  }
}
