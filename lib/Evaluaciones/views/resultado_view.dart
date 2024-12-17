import 'package:flutter/material.dart';
import 'package:universidad_lg_24/Evaluaciones/views/widgets/content_data.dart';

import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/widgets/global/header_global.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';

class ResultadoView extends StatelessWidget {
  const ResultadoView({super.key, this.user, this.evaluacion});
  final User? user;
  final String? evaluacion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: const Color(0xffF6F3EB),
      appBar: CustomAppBar(user: user),
      endDrawer: DrawerMenu(
        user: user,
        isHome: true, // Indica que el DrawerMenuLeft se está utilizando
        // en la pantalla de inicio.
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: ContentData(
          user: user,
          evaluacion: evaluacion,
        ),
      ),
    );
  }
}
