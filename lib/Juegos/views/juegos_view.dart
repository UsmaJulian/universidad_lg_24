import 'package:flutter/material.dart';
import 'package:universidad_lg_24/Juegos/views/widgets/trivia_card_basico.dart';
import 'package:universidad_lg_24/Juegos/views/widgets/trivia_card_experto.dart';
import 'package:universidad_lg_24/Juegos/views/widgets/trivia_card_intermedio.dart';

import 'package:universidad_lg_24/users/models/models.dart';

import 'package:universidad_lg_24/widgets/global/bottom_app_bar_global.dart';
import 'package:universidad_lg_24/widgets/global/header_global.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';

class JuegosView extends StatefulWidget {
  const JuegosView({required this.user, super.key});
  final User user;
  @override
  State<JuegosView> createState() => _JuegosViewState();
}

class _JuegosViewState extends State<JuegosView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: CustomAppBar(),
      endDrawer: DrawerMenu(
        user: widget.user,
        isHome: true, // Indica que el DrawerMenuLeft se está utilizando
        // en la pantalla de inicio.
      ),
      body: Stack(
        children: [
          const Image(
            image: AssetImage(
              'assets/images/Fondo-trivia.png',
            ),
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 158,
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Juegos',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      // const SizedBox(width: 20),
                      // ButtonMain(
                      //   text: 'Menú',
                      //   bgColor: Colors.white,
                      //   textColor: mainColor,
                      //   onPress: Container(),
                      // ),
                    ],
                  ),
                  Expanded(
                    child: DefaultTabController(
                      length: 3,
                      child: Column(
                        children: [
                          const TabBar(
                            unselectedLabelColor: Colors.white,
                            labelColor: Colors.white,
                            indicatorColor: Colors.white,
                            dividerColor: Colors.transparent,
                            tabs: [
                              Tab(text: 'Basico'),
                              Tab(text: 'Intermedio'),
                              Tab(text: 'Avanzado'),
                            ],
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: SizedBox(
                                height: 1900,
                                child: TabBarView(
                                  children: [
                                    TriviaCardBasico(user: widget.user),
                                    TriviaCardIntermedio(user: widget.user),
                                    TriviaCardExperto(user: widget.user),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomAppBar(),
    );
  }
}
