import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:universidad_lg_24/Resuelvelo/models/resuelvelo_model.dart';
import 'package:universidad_lg_24/Resuelvelo/services/comment_resuelvelo_service.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/widgets/global/header_global.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

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
  final _controller = YoutubePlayerController(
    params: const YoutubePlayerParams(
      showFullscreenButton: true,
    ),
  );

  final TextEditingController _commentController = TextEditingController();
  final List<Map<String, String>> _comments = [];

  @override
  void initState() {
    super.initState();
    _controller.loadVideo(widget.resuelveloData.resource);
    // Inicializa comentarios desde los datos existentes
    _comments.addAll(
      widget.resuelveloData.comments
          .map((comment) => {'user': comment.user, 'comment': comment.comment}),
    );
  }

  @override
  void dispose() {
    _controller.close();
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
        padding: const EdgeInsets.only(top: 148, left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YoutubePlayer(controller: _controller),
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
                  onPressed: () {
                    IsAddResuelveloComment().getAddResuelveloCommentService(
                      userId: widget.user.userId.toString(),
                      token: widget.user.token.toString(),
                      nid: widget.resuelveloData.nid,
                      comment: _commentController.text.trim(),
                    );
                  },
                  child: const Text('Enviar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
