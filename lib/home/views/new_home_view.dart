import 'dart:developer';

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
  String? role;
  @override
  void initState() {
    _getRole();
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
  Future<String?> _getRole() async {
    await UserStorage().getUserStorage().then((value) {
      role = value?.role;
    });

    setState(() {});
    return role;
  }

  @override
  Widget build(BuildContext context) {
    log('role: $role');
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
        child: Stack(
          children: [
            // CarouselSlider ocupando toda la pantalla disponible
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.87,
              child: CarouselSlider.builder(
                itemCount: 3,
                options: CarouselOptions(
                  autoPlay: true,
                  height: MediaQuery.of(context).size.height *
                      0.87, // Ajustado para coincidir con el contenedor
                  enlargeFactor: 0,
                  viewportFraction: 1,
                ),
                itemBuilder:
                    (BuildContext context, int index, int pageViewIndex) {
                  Widget buildSlide(String imageUrl) {
                    log('imageUrl: $imageUrl');
                    return MouseRegion(
                      cursor: SystemMouseCursors.move,
                      child: GestureDetector(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height *
                              0.87, // Ajustado
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: (data?.body != null)
                                ? Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.87, // Ajustado
                                    // Agregar loading placeholder
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.87,
                                        color: Colors.grey[300],
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          ),
                                        ),
                                      );
                                    },
                                    // Manejar errores de carga
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.87,
                                        color: Colors.grey[300],
                                        child: const Icon(
                                          Icons.error,
                                          color: Colors.red,
                                          size: 50,
                                        ),
                                      );
                                    },
                                  )
                                : Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.87,
                                    color: Colors.grey[300],
                                  ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (context) => _getDestinationView(index),
                              settings: RouteSettings(
                                name: data!.body!.slides![index].linkApp
                                    .toString(),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }

                  if (data != null) {
                    switch (index) {
                      case 0:
                        return buildSlide(
                          data!.body!.slides![index].imagenApp.toString(),
                        );
                      case 1:
                        return buildSlide(
                          data!.body!.slides![index].imagenWeb.toString(),
                        );
                      case 2:
                        return buildSlide(
                          data!.body!.slides![index].imagenWeb.toString(),
                        );
                      default:
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.87,
                          color: Colors.grey[300],
                        );
                    }
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),

            // Botones posicionados explícitamente en la parte inferior
            Positioned(
              bottom: 50, // Margen desde abajo
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: role != 'visitorApp'
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ButtonMain(
                                text: 'Cursos',
                                onPress: NewCursosView(user: widget.user),
                                routeName: '/courses',
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 15, right: 15),
                                width: 3,
                                height: 50,
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                              ),
                              ButtonMain(
                                text: 'Noticias',
                                onPress: NoticiasView(user: widget.user),
                                routeName: '/news',
                              ),
                            ],
                          ),
                          const SizedBox(height: 26),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ButtonMain(
                                text: 'Reels',
                                onPress: ReelsView(user: widget.user),
                                routeName: '/reels',
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 15, right: 15),
                                width: 3,
                                height: 50,
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                              ),
                              ButtonMain(
                                text: 'Juegos',
                                onPress: JuegosView(user: widget.user),
                                routeName: '/games',
                              ),
                            ],
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ButtonMain(
                            text: 'Noticias',
                            onPress: NoticiasView(user: widget.user),
                            routeName: '/news',
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 15, right: 15),
                            width: 3,
                            height: 50,
                            decoration:
                                const BoxDecoration(color: Colors.white),
                          ),
                          ButtonMain(
                            text: 'Reels',
                            onPress: ReelsView(user: widget.user),
                            routeName: '/reels',
                          ),
                        ],
                      ),
              ),
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

  Widget _getDestinationView(int index) {
    switch (data!.body!.slides![index].linkApp) {
      case '/':
        return NewHomeView(user: widget.user);
      case '/courses':
        return (role != 'visitorApp')
            ? NewCursosView(user: widget.user)
            : NewHomeView(user: widget.user);
      case '/assessment':
        return (role != 'visitorApp')
            ? EvaluacionView(user: widget.user)
            : NewHomeView(user: widget.user);
      case 'library':
        return (role != 'visitorApp')
            ? BibliotecaView(user: widget.user)
            : NewHomeView(user: widget.user);
      case '/solve':
        return (role != 'visitorApp')
            ? ResuelveloView(user: widget.user)
            : NewHomeView(user: widget.user);
      case '/ranking':
        return (role != 'visitorApp')
            ? RankingView(user: widget.user)
            : NewHomeView(user: widget.user);
      case '/help':
        return AyudaView(user: widget.user);
      case '/profile':
        return PerfilView(user: widget.user);
      case '/reels':
        return ReelsView(user: widget.user);
      default:
        return NewHomeView(user: widget.user);
    }
  }
}
