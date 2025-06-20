import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:universidad_lg_24/Resuelvelo/models/resuelvelo_model.dart';
import 'package:universidad_lg_24/Resuelvelo/services/resuelvelo_services.dart';
import 'package:universidad_lg_24/Resuelvelo/views/resuelvelo_video_view.dart';
import 'package:universidad_lg_24/users/models/models.dart';

import 'package:universidad_lg_24/widgets/global/bottom_app_bar_global.dart';
import 'package:universidad_lg_24/widgets/global/header_global.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';

class ResuelveloView extends StatefulWidget {
  const ResuelveloView({required this.user, super.key});
  final User user;
  @override
  State<ResuelveloView> createState() => _ResuelveloViewState();
}

class _ResuelveloViewState extends State<ResuelveloView> {
  ResuelveloModel? data;
  // final resuelvelo = [
  //   {
  //     'resource': '',
  //     'thumbnail': 'assets/static/portada-dos.png',
  //     'title': 'Próximamente',
  //     'type': 'imagen',
  //   },
  //   {
  //     'resource': '',
  //     'thumbnail': 'assets/static/portada-tres.png',
  //     'title': 'Próximamente',
  //     'type': 'imagen',
  //   },
  //   {
  //     'resource': '',
  //     'thumbnail': 'assets/static/portada-dos.png',
  //     'title': 'Próximamente',
  //     'type': 'imagen',
  //   },
  //   {
  //     'resource': 'https://www.youtube.com/watch?v=S6QBcHHPD6w',
  //     'thumbnail': 'assets/static/portada-dos.png',
  //     'title': 'Episodio 1',
  //     'content':
  //         '<p>"¡Bienvenidos al primer capítulo de "<strong> "Resuélvelo con LG"! </strong></p><p>"En esta miniserie aprenderemos a sacar el máximo provecho de la tecnología de LG. Desde tips prácticos hasta soluciones innovadoras, este espacio está diseñado para ayudarles a resolver cualquier desafío tecnológico que puedan enfrentar."</p><p>"prepárense para descubrir soluciones que harán su vida más fácil y conectada. ¡Vamos a comenzar esta aventura tecnológica juntos!"</p>',
  //     'tags': ['ResuélveloConLG'],
  //     'likes': 0,
  //     'comments': [
  //       {
  //         'user': 'Bryan Piñeros',
  //         'avatar': '',
  //         'comment': '¡Excelente video!',
  //       },
  //       {
  //         'user': 'Salomon Portuguez Ledesma',
  //         'avatar': '',
  //         'comment': '¡Buen video!',
  //       },
  //     ],
  //     'type': 'video',
  //   },
  // ];

  @override
  void initState() {
    super.initState();
    _getDataResuelvelo();
  }

  Future<void> _getDataResuelvelo() async {
    await IsResuelveloService()
        .getResuelveloService(
      uid: widget.user.userId,
      token: widget.user.token,
      pager: 1,
    )
        .then((value) {
      setState(() {
        data = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: CustomAppBar(user: widget.user),
      endDrawer: DrawerMenu(
        user: widget.user,
        isHome: true, // Indica que el DrawerMenuLeft se está utilizando
        // en la pantalla de inicio.
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (data != null)
                Image.network(data!.body.info.banner, fit: BoxFit.cover),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: HtmlWidget(
                  data?.body.info.content ?? '',
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7, // ✅ Ajustado para dar más altura
                  ),
                  itemCount: data?.body.data.length ?? 0,
                  itemBuilder: (context, index) {
                    final resuelve = data!.body.data[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        mainAxisSize: MainAxisSize.min, // ✅ Importante
                        children: [
                          // ✅ SizedBox con altura específica en lugar de Expanded
                          SizedBox(
                            height: 270, // ✅ Altura fija para la imagen
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.network(
                                resuelve.thumbnail,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child:
                                        const Icon(Icons.image_not_supported),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          // ✅ Botón con altura específica
                          SizedBox(
                            height: 35,
                            width: 150,
                            child: resuelve.resource.isNotEmpty
                                ? ButtonMain(
                                    text: 'Ver',
                                    onPress: ResuelveloVideoView(
                                      user: widget.user,
                                      resuelveloData: resuelve,
                                    ),
                                    routeName:
                                        '/resuelvelo-video/${resuelve.title}',
                                  )
                                : ButtonMain(text: 'Ver'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomAppBar(),
    );
  }
}
