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
      'likes': 10,
      'resource': 'assets/static/craft_ice.mp4',
      'tags': ['#LG'],
      'thumbnail': 'assets/static/portada_craft_0.png',
      'title': 'CRAFT ICE',
      'type': 'video',
    },
    {
      'likes': 15,
      'resource': 'assets/static/loco_cine_2.0.mp4',
      'tags': ['#LG'],
      'thumbnail': 'assets/static/portada_loco_cine4.png',
      'title': 'MATCH PERFECTO',
      'type': 'video',
    },
    {
      'likes': 20,
      'resource': 'assets/static/meliportadayogurt.png',
      'tags': ['#LG', '#Yogurt'],
      'type': 'image',
    },
    {
      'likes': 25,
      'resource': 'assets/static/portada_craft_0.png',
      'tags': ['#LG'],
      'type': 'image',
    },
    {
      'likes': 30,
      'resource': 'assets/static/portada_loco_cine4.png',
      'tags': ['#LG'],
      'type': 'image',
    },
    {
      'likes': 35,
      'resource': 'assets/static/reel_yogurt_final.mp4',
      'tags': ['#LG'],
      'thumbnail': 'assets/static/meliportadayogurt.png',
      'title': 'YOGURT EN TU NEOCHEF',
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
                  top: 120, left: 20, right: 20, bottom: 20),
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
                                            Image.asset(
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
    final videoPlayerController =
        VideoPlayerController.asset(reel['resource'].toString());
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
