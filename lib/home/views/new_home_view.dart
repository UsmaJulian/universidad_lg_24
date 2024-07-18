import 'package:flutter/material.dart';
import 'package:universidad_lg_24/Cursos/views/new_cursos_view.dart';
import 'package:universidad_lg_24/Entrenamiento/views/curso_preview_view.dart';
import 'package:universidad_lg_24/Juegos/views/Juegos_view.dart';
import 'package:universidad_lg_24/Noticias/views/noticias_view.dart';
import 'package:universidad_lg_24/Reels/views/reels_view.dart';
import 'package:universidad_lg_24/constants.dart';

import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/widgets/global/bottom_app_bar_global.dart';
import 'package:universidad_lg_24/widgets/global/header_global.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';

class NewHomeView extends StatelessWidget {
  const NewHomeView({required this.user, super.key});
  final User user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: const Color(0xffF6F3EB),
      appBar: CustomAppBar(),
      endDrawer: DrawerMenu(
        user: user,
        isHome: true, // Indica que el DrawerMenuLeft se está utilizando
        // en la pantalla de inicio.
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/Home.png',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
          ),
          Positioned(
            bottom: 195,
            left: 22,
            child: Column(
              children: [
                Row(
                  children: [
                    ButtonMain(
                      text: 'Cursos',
                      onPress: NewCursosView(
                        user: user,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 15),
                      width: 3,
                      height: 50,
                      decoration: const BoxDecoration(color: Colors.white),
                    ),
                    ButtonMain(
                      text: 'Noticias',
                      onPress: NoticiasView(user: user),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 36,
                ),
                Row(
                  children: [
                    ButtonMain(
                      text: 'Reels',
                      onPress: ReelsView(user: user),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 15),
                      width: 3,
                      height: 50,
                      decoration: const BoxDecoration(color: Colors.white),
                    ),
                    ButtonMain(
                      text: 'Juegos',
                      onPress: JuegosView(user: user),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomAppBar(),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        onPressed: () {},
        backgroundColor: footerColor,
        child: const Icon(
          Icons.mail_outline,
          color: Colors.white,
        ),
      ),
    );
  }
}
