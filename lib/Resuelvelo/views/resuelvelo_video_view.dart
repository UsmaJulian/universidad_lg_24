import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:universidad_lg_24/Resuelvelo/models/resuelvelo_model.dart';
import 'package:universidad_lg_24/Resuelvelo/services/comment_resuelvelo_service.dart';
import 'package:universidad_lg_24/Resuelvelo/services/resuelvelo_services.dart';
import 'package:universidad_lg_24/Resuelvelo/views/resuelvelo_test_view.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/helpers/my_long_print.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/widgets/global/bottom_app_bar_global.dart';
import 'package:universidad_lg_24/widgets/global/header_global.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';
import 'package:vimeo_video_player/vimeo_video_player.dart';

class ResuelveloVideoView extends StatefulWidget {
  const ResuelveloVideoView({
    required this.user,
    required this.resuelveloData,
    super.key,
  });
  final User user;
  final Datum resuelveloData;

  @override
  State<ResuelveloVideoView> createState() => _ResuelveloVideoViewState();
}

class _ResuelveloVideoViewState extends State<ResuelveloVideoView> {
  // final _controller = YoutubePlayerController(
  //   params: const YoutubePlayerParams(
  //     showFullscreenButton: true,
  //   ),
  // );

  final TextEditingController _commentController = TextEditingController();
  final List<Map<String, String>> _comments = [];

  @override
  void initState() {
    super.initState();
    log('ResuelveloVideoView: ${widget.resuelveloData.resource}');
    // _controller.loadVideo(widget.resuelveloData.resource);
    // Inicializa comentarios desde los datos existentes
    _comments.addAll(
      widget.resuelveloData.comments
          .map((comment) => {'user': comment.user, 'comment': comment.comment}),
    );
  }

  @override
  void dispose() {
    // _controller.stopVideo();
    // _controller.close();
    _commentController.dispose();
    super.dispose();
  }

  void _addComment() {
    if (_commentController.text.trim().isNotEmpty) {
      setState(() {
        _comments.add({
          'user':
              widget.user.name.toString(), // Usa el nombre del usuario actual
          'comment': _commentController.text.trim(),
        });
        _commentController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    log('ResuelveloVideoView: ${widget.resuelveloData.resource}');
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: CustomAppBar(user: widget.user),
      endDrawer: DrawerMenu(
        user: widget.user,
        isHome: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 148,
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).size.height * 0.1,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // YoutubePlayer(controller: _controller),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.45,
                child: VimeoVideoPlayer(
                  // videoId: '12860646',

                  videoId: widget.resuelveloData.resource,
                  backgroundColor: mainColor,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(
                  top: 14,
                  bottom: 14,
                ),
                child: ElevatedButton(
                  onPressed: (widget.resuelveloData.test.toString() == '0')
                      ? () async {
                          final response =
                              await IsResuelveloService().getTestResuelvelo(
                            token: widget.user.token.toString(),
                            uid: widget.user.userId.toString(),
                            nid: int.parse(widget.resuelveloData.nid),
                          );
                          if (response.body.test.isNotEmpty) {
                            await Future<void>.delayed(
                              Duration.zero,
                            ).then(
                              (_) => Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (context) {
                                    return ResuelveloTestView(
                                      user: widget.user,
                                      content: response,
                                    );
                                  },
                                  settings: RouteSettings(
                                    name: '/solve/test/${response.body.title}',
                                  ),
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'No hay trivias disponibles',
                                ),
                              ),
                            );
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(129, 41),
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                      side: BorderSide(),
                    ),
                  ),
                  child: (widget.resuelveloData.test.toString() == '0')
                      ? const Text(
                          'Iniciar Test',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        )
                      : const Text(
                          'Realizada',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                ),
              ),
              HtmlWidget(
                widget.resuelveloData.content,
                enableCaching: true,
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 20),
              const Text(
                'Comentarios',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),

              // Mostrar comentarios
              for (final comment in _comments)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(radius: 30),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              comment['user']!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              comment['comment']!,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              // Sección para agregar comentarios
              const SizedBox(height: 20),
              const Text(
                'Agregar un comentario',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: 'Escribe tu comentario...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () async {
                    final response = await IsAddResuelveloComment()
                        .getAddResuelveloCommentService(
                      userId: widget.user.userId.toString(),
                      token: widget.user.token.toString(),
                      nid: widget.resuelveloData.nid,
                      comment: _commentController.text.trim(),
                    );
                    myLongPrint('comentario ${response.toJson()}');
                    if (response.response!.type != 'error') {
                      _addComment();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(response.response!.message!.toString()),
                        ),
                      );
                    }
                  },
                  child: const Text('Enviar'),
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
