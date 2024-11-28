import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:universidad_lg_24/Cursos/views/new_cursos_view.dart';
import 'package:universidad_lg_24/Juegos/views/Juegos_view.dart';
import 'package:universidad_lg_24/Noticias/views/noticias_view.dart';
import 'package:universidad_lg_24/Reels/views/reels_view.dart';
import 'package:universidad_lg_24/Resuelvelo/views/resuelvelo_view.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/widgets/global/bottom_app_bar_global.dart';
import 'package:universidad_lg_24/widgets/global/header_global.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';

class NewHomeView extends StatefulWidget {
  const NewHomeView({required this.user, super.key});
  final User user;

  @override
  State<NewHomeView> createState() => _NewHomeViewState();
}

class _NewHomeViewState extends State<NewHomeView> {
  //  final images = <Map<String, dynamic>>[
  //   {
  //     'image': 'assets/images/Home.png',
  //     'route': ReelsView(
  //       user: widget.user,
  //     ),
  //   },
  //   {
  //     'image': 'assets/images/IMG_3802.PNG',
  //     'route': ResuelveloView(
  //       user: widget.user,
  //     ),
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,

      backgroundColor: const Color(0xffF6F3EB),
      appBar: CustomAppBar(
        user: widget.user,
      ),
      endDrawer: DrawerMenu(
        user: widget.user,
        isHome: true, // Indica que el DrawerMenuLeft se está utilizando
        // en la pantalla de inicio.
      ),
      /* body: Stack(
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
      ), */
      body: Padding(
        padding: const EdgeInsets.only(top: 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.51,
              child: CarouselSlider.builder(
                itemCount: 3,
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 0.1,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.15,
                  viewportFraction: 0.6,
                ),
                itemBuilder:
                    (BuildContext context, int index, int pageViewIndex) {
                  switch (index) {
                    case 0:
                      return MouseRegion(
                        cursor: SystemMouseCursors.move,
                        child: GestureDetector(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'assets/images/Home.png',
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (context) => ReelsView(
                                  user: widget.user,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    case 1:
                      return MouseRegion(
                        cursor: SystemMouseCursors.move,
                        child: GestureDetector(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'assets/images/IMG_3802.PNG',
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (context) => NewCursosView(
                                  user: widget.user,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    case 2:
                      return MouseRegion(
                        cursor: SystemMouseCursors.move,
                        child: GestureDetector(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'assets/images/IMG_4063.PNG',
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (context) => ResuelveloView(
                                  user: widget.user,
                                ),
                              ),
                            );
                          },
                        ),
                      );

                    default:
                      return Container();
                  }
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ButtonMain(
                      text: 'Cursos',
                      onPress: NewCursosView(
                        user: widget.user,
                      ),
                      routeName: '/courses',
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 15),
                      width: 3,
                      height: 50,
                      decoration: const BoxDecoration(color: Colors.white),
                    ),
                    ButtonMain(
                      text: 'Noticias',
                      onPress: NoticiasView(user: widget.user),
                      routeName: '/news',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 26,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ButtonMain(
                      text: 'Reels',
                      onPress: ReelsView(user: widget.user),
                      routeName: '/reels',
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 15),
                      width: 3,
                      height: 50,
                      decoration: const BoxDecoration(color: Colors.white),
                    ),
                    ButtonMain(
                      text: 'Juegos',
                      onPress: JuegosView(user: widget.user),
                      routeName: '/games',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomAppBar(),

      // floatingActionButton: FloatingActionButton(
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(100),
      //   ),
      //   onPressed: () {},
      //   backgroundColor: footerColor,
      //   child: const Icon(
      //     Icons.mail_outline,
      //     color: Colors.white,
      //   ),
      // ),
    );
  }
}
