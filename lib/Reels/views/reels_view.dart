import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:universidad_lg_24/constants.dart';

import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/widgets/global/body_footer_global.dart';

import 'package:universidad_lg_24/widgets/global/header_global.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';
import 'package:video_player/video_player.dart';

class ReelsView extends StatefulWidget {
  const ReelsView({required this.user, super.key});
  final User user;
  @override
  State<ReelsView> createState() => _ReelsViewState();
}

class _ReelsViewState extends State<ReelsView> {
  final reels = [
    {
      'likes': 2,
      'resource':
          'https://www.universidadlg.com.pe/sites/default/files/reels/lavaseca_-_vivencial.mp4',
      'tags': ['#LAVASECA CON AI DD'],
      'thumbnail':
          'https://www.universidadlg.com.pe/sites/default/files/harold_lavaseca_viven-opt.png',
      'title': 'LAVASECA CON AI DD',
      'type': 'video',
    },
    {
      'likes': 2,
      'resource':
          'https://www.universidadlg.com.pe/sites/default/files/reels/qned_80.mp4',
      'tags': ['#3 BENEFICIOS - QNED80'],
      'thumbnail':
          'https://www.universidadlg.com.pe/sites/default/files/esther_qned80-opt.png',
      'title': '3 BENEFICIOS - QNED80',
      'type': 'video',
    },
    {
      'likes': 2,
      'resource':
          'https://www.universidadlg.com.pe/sites/default/files/reels/xg2-beneficios.mp4',
      'tags': ['#3 BENEFICIOS - XG2T'],
      'thumbnail':
          'https://www.universidadlg.com.pe/sites/default/files/franco_xboom_func-opt.png',
      'title': '3 BENEFICIOS - XG2T',
      'type': 'video',
    },
    {
      'likes': 2,
      'resource':
          'https://www.universidadlg.com.pe/sites/default/files/reels/xl7.mp4',
      'tags': ['#LG XBOOM - XL7S'],
      'thumbnail':
          'https://www.universidadlg.com.pe/sites/default/files/patty_xl7-opt.png',
      'title': 'LG XBOOM - XL7S',
      'type': 'video',
    },
    {
      'likes': 2,
      'resource':
          'https://www.universidadlg.com.pe/sites/default/files/reels/reel_agosto_-_switcher.mp4',
      'tags': ['#DEMO SWITCHER'],
      'thumbnail':
          'https://www.universidadlg.com.pe/sites/default/files/demo_switcher_danny-opt.png',
      'title': 'DEMO SWITCHER',
      'type': 'video',
    },
    {
      'likes': 2,
      'resource':
          'https://www.universidadlg.com.pe/sites/default/files/reels/reel_2.mp4',
      'tags': ['#REFRIGERADORAS APLICATIVO THIN Q'],
      'thumbnail':
          'https://www.universidadlg.com.pe/sites/default/files/thinq_nykol-opt.png',
      'title': 'REFRIGERADORAS APLICATIVO THIN Q',
      'type': 'video',
    },
    {
      'likes': 2,
      'resource':
          'https://www.universidadlg.com.pe/sites/default/files/reels/reel_xg2t_agosto.mp4',
      'tags': ['#XG2'],
      'thumbnail':
          'https://www.universidadlg.com.pe/sites/default/files/mic_integrado_diego-opt.png',
      'title': 'XG2',
      'type': 'video',
    },
    {
      'likes': 2,
      'resource':
          'https://www.universidadlg.com.pe/sites/default/files/reels/reel_agosto.mp4',
      'tags': ['#OLED BENEFICIOS'],
      'thumbnail':
          'https://www.universidadlg.com.pe/sites/default/files/oled_diego-opt.png',
      'title': 'OLED BENEFICIOS',
      'type': 'video',
    },
    {
      'likes': 2,
      'resource':
          'https://www.universidadlg.com.pe/sites/default/files/reels/reel_1.mp4',
      'tags': ['#WASHTOWER'],
      'thumbnail':
          'https://www.universidadlg.com.pe/sites/default/files/washtower_nykol-opt.png',
      'title': 'WASHTOWER',
      'type': 'video',
    },
    {
      'likes': 2,
      'resource':
          'https://www.universidadlg.com.pe/sites/default/files/reels/objet_collection_estilo_1.mp4',
      'tags': ['#OBJECT COLLECTION COLOR'],
      'thumbnail':
          'https://www.universidadlg.com.pe/sites/default/files/lg-obeject-top-freezer.png',
      'title': 'OBJECT COLLECTION COLOR',
      'type': 'video',
    },
    {
      'likes': 2,
      'resource':
          'https://www.universidadlg.com.pe/sites/default/files/reels/loco_cine_2.0.mp4',
      'tags': ['#MATCH-PERFECTO'],
      'thumbnail':
          'https://www.universidadlg.com.pe/sites/default/files/portada_loco_cine4.png',
      'title': 'MATCH PERFECTO',
      'type': 'video',
    },
    {
      'likes': 2,
      'resource':
          'https://www.universidadlg.com.pe/sites/default/files/reels/craft_ice._final_1_-_trim_0.mp4',
      'tags': ['#CRAFT ICE', '#LG'],
      'thumbnail':
          'https://www.universidadlg.com.pe/sites/default/files/portada_craft_0.png',
      'title': 'CRAFT ICE',
      'type': 'video',
    },
    {
      'likes': 0,
      'resource':
          'https://www.universidadlg.com.pe/sites/default/files/reels/reel_yogurt_final.mp4',
      'tags': ['#LG', '#Yogurt', '#NEOCHEF'],
      'thumbnail':
          'https://www.universidadlg.com.pe/sites/default/files/meliportadayogurt.png',
      'title': 'Yogurt EN TU NEOCHEF',
      'type': 'video',
    },
    {
      'likes': 0,
      'resource':
          'https://www.universidadlg.com.pe/sites/default/files/reels/lg_washtower_vivencial_final.mp4',
      'tags': ['#SMART', '#PAIRING'],
      'thumbnail':
          'https://www.universidadlg.com.pe/sites/default/files/portada_smart_pairing.png',
      'title': 'SMART PAIRING',
      'type': 'video',
    },
    {
      'likes': 0,
      'resource':
          'https://www.universidadlg.com.pe/sites/default/files/reels/reel_av1.mp4',
      'tags': ['#LG XBOOM', '#XG2'],
      'thumbnail':
          'https://www.universidadlg.com.pe/sites/default/files/portada_xg2.png',
      'title': 'LG XBOOM XG2',
      'type': 'video',
    },
    {
      'likes': 0,
      'resource':
          'https://www.universidadlg.com.pe/sites/default/files/reels/apple_tv.mp4',
      'tags': ['#APPLE TV', '#SUSCRIPCIÓN'],
      'thumbnail':
          'https://www.universidadlg.com.pe/sites/default/files/danny_apple.png',
      'title': 'APPLE TV SUSCRIPCIÓN',
      'type': 'video',
    },
    {
      'likes': 0,
      'resource':
          'https://www.universidadlg.com.pe/sites/default/files/reels/3_beneficios.mp4',
      'tags': ['#OLED', '#POSÉ'],
      'thumbnail':
          'https://www.universidadlg.com.pe/sites/default/files/portada_oled_pose_1.png',
      'title': 'OLED POSÉ',
      'type': 'video',
    },
    {
      'likes': 0,
      'resource':
          'https://www.universidadlg.com.pe/sites/default/files/reels/reel_nykol_microondas_-_trim.mp4',
      'tags': ['#MICROONDAS', '#NEOCHEFLG'],
      'thumbnail':
          'https://www.universidadlg.com.pe/sites/default/files/neo_nykol.png',
      'title': 'MICROONDAS NEOCHEFLG',
      'type': 'video',
    },
    {
      'likes': 0,
      'resource':
          'https://www.universidadlg.com.pe/sites/default/files/reels/5_cosas_que_no_sabias_en_2_minutos.mp4',
      'tags': ['#DATOS', '#IMPORTANTES'],
      'thumbnail':
          'https://www.universidadlg.com.pe/sites/default/files/melisa_5_cosas_2.png',
      'title': '5 COSAS QUE NO SABIAS EN 2 MINUTOS',
      'type': 'video',
    },
  ];

  TextEditingController searchController = TextEditingController();

  String searchTerm = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: const Color(0xffF6F3EB),
      appBar: CustomAppBar(),
      endDrawer: DrawerMenu(
        user: widget.user,
        isHome: true, // Indica que el DrawerMenuLeft se está utilizando
        // en la pantalla de inicio.
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 135,
                left: 20,
                right: 20,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Reels',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  searchInput(),
                  SizedBox(
                    // height: MediaQuery.of(context).size.height * 0.55,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (final reel in reels)
                            if (reel['tags'].toString().contains(searchTerm))
                              if (reel['type'] == 'video')
                                Padding(
                                  padding: const EdgeInsets.only(top: 25),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Image.network(
                                              reel['thumbnail'].toString(),
                                              fit: BoxFit.cover,
                                            ),
                                            Center(
                                              child: IconButton(
                                                onPressed: () {
                                                  dialogo(context, reel);
                                                },
                                                icon: const Icon(
                                                  Icons
                                                      .play_circle_fill_outlined,
                                                  color: mainColor,
                                                  size: 90,
                                                ),
                                                iconSize: 50,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      /* Row(
                                        children: [
                                          const Icon(
                                            Icons.favorite_border_outlined,
                                            size: 40,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            reel['likes'].toString(),
                                            style: const TextStyle(
                                              fontSize: 44,
                                              fontWeight: FontWeight.bold,
                                              color: mainColor,
                                            ),
                                          ),
                                        ],
                                      ), */
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        height: 1,
                                        decoration: const BoxDecoration(
                                          color: Color(0xff707070),
                                        ),
                                      ),
                                      Text(
                                        reel['tags'].toString().replaceAll(
                                              RegExp(r'[^\#\w\s]+'),
                                              '',
                                            ),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              else
                                Padding(
                                  padding: const EdgeInsets.only(top: 25),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Image.asset(
                                          reel['resource'].toString(),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.favorite_border_outlined,
                                            size: 40,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            reel['likes'].toString(),
                                            style: const TextStyle(
                                              fontSize: 44,
                                              fontWeight: FontWeight.bold,
                                              color: mainColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: 1,
                                        decoration: const BoxDecoration(
                                          color: Color(0xff707070),
                                        ),
                                      ),
                                      Text(
                                        reel['tags'].toString().replaceAll(
                                              RegExp(r'[^\#\w\s]+'),
                                              '',
                                            ),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const BodyFooter(),
          ],
        ),
      ),
    );
  }

  Future<void> dialogo(BuildContext context, Map<String, Object> reel) async {
    final videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(reel['resource'].toString()),
    );
    await videoPlayerController.initialize();
    return Future.delayed(Duration.zero, () {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            backgroundColor: bgColor,
            insetPadding: EdgeInsets.zero,
            icon: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  videoPlayerController.pause().then((_) {
                    videoPlayerController.dispose();
                  });
                },
                icon: const Icon(
                  Icons.close,
                  color: mainColor,
                ),
              ),
            ),
            content: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Chewie(
                controller: ChewieController(
                  videoPlayerController: videoPlayerController,
                  errorBuilder: (
                    context,
                    errorMessage,
                  ) {
                    return const Center(
                      child: Text(
                        'Error al cargar el video',
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      );
    });
  }

  Widget searchInput() {
    return Container(
      margin: EdgeInsets.zero,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: Color(0xffE6E1D6),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: searchController,
              textAlign: TextAlign.center,
              onChanged: (String value) async {
                search(value);
              },
              decoration: const InputDecoration(
                hintText: 'Buscar',
                hintStyle: TextStyle(fontSize: 16, color: Color(0xff716F6A)),
                border: InputBorder.none,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              search(searchController.text);
              // print(searchController.text);
            },
            child: const SizedBox(
              child: Icon(Icons.search, color: Color(0xff716F6A)),
            ),
          ),
        ],
      ),
    );
  }

  void search(String value) {
    setState(() {
      searchTerm = value;
    });
  }
}
