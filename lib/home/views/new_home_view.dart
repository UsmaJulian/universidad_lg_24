import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:universidad_lg_24/Ayuda/views/ayuda_view.dart';
import 'package:universidad_lg_24/Biblioteca/views/biblioteca_view.dart';
import 'package:universidad_lg_24/Cursos/views/new_cursos_view.dart';
import 'package:universidad_lg_24/Evaluaciones/views/evaluacion_view.dart';
import 'package:universidad_lg_24/Home/models/new_home_model.dart';
// import 'package:universidad_lg_24/Home/services/home_service.dart';
import 'package:universidad_lg_24/Home/services/new_home_service.dart';
import 'package:universidad_lg_24/Juegos/views/Juegos_view.dart';
import 'package:universidad_lg_24/Noticias/views/noticias_view.dart';
import 'package:universidad_lg_24/Ranking/views/ranking_view.dart';
import 'package:universidad_lg_24/Reels/views/reels_view.dart';
import 'package:universidad_lg_24/Resuelvelo/views/resuelvelo_view.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/users/views/profile/perfil_view.dart';
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
  NewHomeModel? data;
  @override
  void initState() {
    _getHomeContent();
    super.initState();
  }

  Future<void> _getHomeContent() async {
    // Verifica si el widget está montado antes de llamar a setState
    if (!mounted) return;

    try {
      data = await NewHomeService().newGetServiceContent(
        widget.user.userId.toString(),
        widget.user.token.toString(),
      );

      if (mounted) {
        setState(() {});
      }

      print(data?.body?.slides);
    } catch (e) {
      // Manejo de errores
      print('Error fetching home content: $e');
    }
  }

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
                            child: (data?.body != null)
                                ? Image.network(
                                    data!.body!.slides![index].imagenWeb
                                        .toString(),
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                  )
                                : const SizedBox(),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (context) {
                                  switch (data!.body!.slides![index].linkApp) {
                                    case '/':
                                      return NewHomeView(user: widget.user);
                                    case '/courses':
                                      return NewCursosView(user: widget.user);
                                    case '/assessment':
                                      return EvaluacionView(user: widget.user);
                                    case 'library':
                                      return BibliotecaView(user: widget.user);
                                    case '/solve':
                                      return ResuelveloView(user: widget.user);
                                    case '/ranking':
                                      return RankingView(user: widget.user);
                                    case '/help':
                                      return AyudaView(user: widget.user);
                                    case '/profile':
                                      return PerfilView(user: widget.user);
                                    case '/reels':
                                      return ReelsView(user: widget.user);
                                    default:
                                      return NewHomeView(user: widget.user);
                                  }
                                },
                                settings: RouteSettings(
                                  name: data!.body!.slides![index].linkApp
                                      .toString(),
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
                            child: (data?.body != null)
                                ? Image.network(
                                    data!.body!.slides![index].imagenWeb
                                        .toString(),
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                  )
                                : const SizedBox(),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (context) {
                                  switch (data!.body!.slides![index].linkApp) {
                                    case '/':
                                      return NewHomeView(user: widget.user);
                                    case '/courses':
                                      return NewCursosView(user: widget.user);
                                    case '/assessment':
                                      return EvaluacionView(user: widget.user);
                                    case 'library':
                                      return BibliotecaView(user: widget.user);
                                    case '/solve':
                                      return ResuelveloView(user: widget.user);
                                    case '/ranking':
                                      return RankingView(user: widget.user);
                                    case '/help':
                                      return AyudaView(user: widget.user);
                                    case '/profile':
                                      return PerfilView(user: widget.user);
                                    case '/reels':
                                      return ReelsView(user: widget.user);
                                    default:
                                      return NewHomeView(user: widget.user);
                                  }
                                },
                                settings: RouteSettings(
                                  name: data!.body!.slides![index].linkApp
                                      .toString(),
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
                            child: (data?.body != null)
                                ? Image.network(
                                    data!.body!.slides![index].imagenWeb
                                        .toString(),
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                  )
                                : const SizedBox(),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (context) {
                                  switch (data!.body!.slides![index].linkApp) {
                                    case '/':
                                      return NewHomeView(user: widget.user);
                                    case '/courses':
                                      return NewCursosView(user: widget.user);
                                    case '/assessment':
                                      return EvaluacionView(user: widget.user);
                                    case 'library':
                                      return BibliotecaView(user: widget.user);
                                    case '/solve':
                                      return ResuelveloView(user: widget.user);
                                    case '/ranking':
                                      return RankingView(user: widget.user);
                                    case '/help':
                                      return AyudaView(user: widget.user);
                                    case '/profile':
                                      return PerfilView(user: widget.user);
                                    case '/reels':
                                      return ReelsView(user: widget.user);
                                    default:
                                      return NewHomeView(user: widget.user);
                                  }
                                },
                                settings: RouteSettings(
                                  name: data!.body!.slides![index].linkApp
                                      .toString(),
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
