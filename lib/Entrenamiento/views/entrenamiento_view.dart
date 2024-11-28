import 'package:flutter/material.dart';
import 'package:universidad_lg_24/Entrenamiento/widgets/widgets.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/widgets/global/bottom_app_bar_global.dart';
import 'package:universidad_lg_24/widgets/global/header_global.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';

class EntrenamientoView extends StatelessWidget {
  const EntrenamientoView({
    required this.user,
    super.key,
  });
  final User user;

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
      body: Padding(
        padding: const EdgeInsets.only(bottom: 96),
        child: EntrenamientoContent(user: user),
      ),
      bottomNavigationBar: const CustomBottomAppBar(),
    );
  }
}
