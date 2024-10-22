import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:universidad_lg_24/Resuelvelo/models/resuelvelo_model.dart';
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
  @override
  void initState() {
    super.initState();
    _controller.loadVideo(widget.resuelveloData.resource);
  }

  @override
  void dispose() {
    _controller.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: CustomAppBar(),
      endDrawer: DrawerMenu(
        user: widget.user,
        isHome: true, // Indica que el DrawerMenuLeft se está utilizando
        // en la pantalla de inicio.
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 148, left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YoutubePlayer(
                controller: _controller,
              ),
              // const SizedBox(height: 20),
              // Text(
              //   widget.resuelveloData.title,
              //   style: const TextStyle(
              //     fontSize: 25,
              //     fontWeight: FontWeight.w700,
              //   ),
              // ),

              HtmlWidget(
                widget.resuelveloData.content,
                enableCaching: true,
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),

              /// Espacio para Likes
              const SizedBox(height: 20),
              const Text(
                'Comentarios',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),

              for (final comments in widget.resuelveloData.comments)
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      const CircleAvatar(
                        radius: 30,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        comments.comment,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
