import 'package:flutter/material.dart';
import 'package:universidad_lg_24/Biblioteca/models/biblioteca_model.dart';
import 'package:universidad_lg_24/Biblioteca/views/widgets/widgets.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/widgets/global/header_global.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';

class SingleBibliotecaView extends StatelessWidget {
  const SingleBibliotecaView({super.key, this.user, this.data});
  final User? user;
  final BibliotecaValue? data;
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
        padding: const EdgeInsets.only(top: 120),
        child: ContentSingleBibliotecaView(data: data),
      ),
    );
  }
}
