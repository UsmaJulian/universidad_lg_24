import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:universidad_lg_24/Resuelvelo/models/resuelvelo_model.dart';
import 'package:universidad_lg_24/Resuelvelo/services/resuelvelo_services.dart';
import 'package:universidad_lg_24/Resuelvelo/views/resuelvelo_video_view.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/widgets/global/body_footer_global.dart';
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
              if (data != null) Image.network(data!.body.info.banner),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: HtmlWidget(
                  data?.body.info.content ?? '',
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                height: MediaQuery.of(context).size.height * 0.4,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Número de columnas en el Grid
                    crossAxisSpacing:
                        10, // Espaciado horizontal entre elementos
                    mainAxisSpacing: 10, // Espaciado vertical entre elementos
                    childAspectRatio:
                        0.75, // Relación de aspecto de los elementos
                  ),
                  itemCount: data?.body.data.length ?? 0,
                  itemBuilder: (context, index) {
                    final resuelve = data!.body.data[index];
                    return Stack(
                      children: [
                        SizedBox(
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.network(
                                    resuelve.thumbnail,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (resuelve.resource.isNotEmpty &&
                            resuelve.resource.contains('youtube'))
                          Positioned(
                            bottom: MediaQuery.of(context).size.height * 0.04,
                            left: 15,
                            child: ButtonMain(
                              text: 'Ver',
                              onPress: ResuelveloVideoView(
                                user: widget.user,
                                resuelveloData: resuelve,
                              ),
                              routeName: '/resuelvelo-video/${resuelve.title}',
                            ),
                          )
                        else
                          Positioned(
                            bottom: 10,
                            left: 15,
                            child: ButtonMain(
                              text: 'Ver',
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.08,
                ),
                child: const BodyFooter(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
