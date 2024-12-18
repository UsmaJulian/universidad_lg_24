import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:universidad_lg_24/Reels/models/reels_model.dart';
import 'package:universidad_lg_24/Reels/services/reels_services.dart';
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
  ReelsModel? data;
  final StreamController<ReelsModel> _streamController =
      StreamController<ReelsModel>();
  final List<Map<String, Object>> reels = [];
  int _pager = 0;
  TextEditingController searchController = TextEditingController();
  final RefreshController _refreshController = RefreshController();

  String searchTerm = '';

  @override
  void initState() {
    _getDataReels();
    super.initState();
  }

  Future<void> _getDataReels() async {
    try {
      final response = await IsReelsService().getReelsService(
        uid: widget.user.userId,
        token: widget.user.token,
        pager: _pager,
      );

      if (response.body.isNotEmpty) {
        setState(() {
          data = response;
          for (final item in data!.body) {
            reels.add({
              'likes': item.likes,
              'resource': item.resource,
              'tags': item.tags,
              'thumbnail': item.thumbnail,
              'title': item.title,
              'nid': item.nid,
              'type': item.type,
            });
          }
        });
      }
    } catch (e) {
      debugPrint('Error fetching reels: $e');
    }
  }

  Future<void> _refreshData() async {
    try {
      _pager++; // Incrementar antes de la llamada
      debugPrint('Refrescando datos con pager: $_pager');

      final response = await IsReelsService().getReelsService(
        uid: widget.user.userId,
        token: widget.user.token,
        pager: _pager,
      );

      if (response.body.isNotEmpty) {
        setState(() {
          for (final item in response.body) {
            reels.add({
              'likes': item.likes,
              'resource': item.resource,
              'tags': item.tags,
              'thumbnail': item.thumbnail,
              'title': item.title,
              'nid': item.nid,
              'type': item.type,
            });
          }
        });
      }

      _refreshController.loadComplete();
    } catch (e) {
      debugPrint('Error al refrescar los datos: $e');
      _refreshController.loadFailed();
    }
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: const Color(0xffF6F3EB),
      appBar: CustomAppBar(user: widget.user),
      endDrawer: DrawerMenu(
        user: widget.user,
        isHome: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.15,
                left: 20,
                right: 20,
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
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: SmartRefresher(
                      enablePullDown: false,
                      enablePullUp: true,
                      header: const WaterDropHeader(),
                      controller: _refreshController,
                      onLoading: _refreshData,
                      child: ListView.builder(
                        itemCount: reels.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemBuilder: (BuildContext context, int index) {
                          final reel = reels[index];

                          if (reel['tags']
                                  .toString()
                                  .toLowerCase()
                                  .contains(searchTerm.toLowerCase()) &&
                              reel['type'] == 'video') {
                            return Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                              dialogo(
                                                context,
                                                reel,
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.play_circle_fill_outlined,
                                              color: mainColor,
                                              size: 90,
                                            ),
                                            iconSize: 50,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Row(
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
                                    onTap: () async {
                                      final response = await IsReelsService()
                                          .getReelsAddLikeService(
                                        uid: widget.user.userId,
                                        token: widget.user.token,
                                        nid: reel['nid'].toString(),
                                      );
                                      if (response.response.type == 'success') {
                                        setState(() {
                                          reel['likes'] = response.body.likes;
                                        });
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 15),
                                  Container(
                                    height: 1,
                                    decoration: const BoxDecoration(
                                      color: Color(0xff707070),
                                    ),
                                  ),
                                  Text(
                                    reel['tags']
                                        .toString()
                                        .replaceAll(RegExp(r'[^\#\w\s]+'), ''),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
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
