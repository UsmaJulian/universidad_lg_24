import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:universidad_lg_24/Cursos/services/cursos_services.dart';
import 'package:universidad_lg_24/Entrenamiento/models/models.dart';
import 'package:universidad_lg_24/Entrenamiento/views/test_entrada_view.dart';
import 'package:universidad_lg_24/Entrenamiento/views/test_salida_view.dart';
import 'package:universidad_lg_24/constants.dart';

import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/widgets/global/bottom_app_bar_global.dart';
import 'package:universidad_lg_24/widgets/global/header_global.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';
import 'package:video_player/video_player.dart';

class NewCursoSingleView extends StatefulWidget {
  const NewCursoSingleView({required this.user, required this.nid, super.key});
  final User user;
  final String nid;
  @override
  State<NewCursoSingleView> createState() => _NewCursoSingleViewState();
}

class _NewCursoSingleViewState extends State<NewCursoSingleView> {
  CursoPreview? cursoData;
  @override
  void initState() {
    getCursosData();
    super.initState();
  }

  Future<void> getCursosData() async {
    final stringCursoData = await CursosServices().serviceGetCursoInfoContent(
      widget.user.userId.toString(),
      widget.user.token.toString(),
      widget.nid,
    );

    cursoData = stringCursoData;

    setState(() {});
  }

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
      body: Padding(
        padding:
            const EdgeInsets.only(top: 148, right: 25, left: 25, bottom: 106),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (cursoData != null)
                Column(
                  children: [
                    SizedBox(
                      width: 290,
                      child: Text(
                        cursoData!.status!.data!.curso!.title.toString(),
                        style: const TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              Divider(
                color: Colors.grey[400],
              ),
              if (cursoData != null)
                Padding(
                  padding: const EdgeInsets.only(top: 36, bottom: 36),
                  child: HtmlWidget(
                    cursoData!.status!.data!.curso!.bodyValue.toString(),
                  ),
                ),
              Divider(
                color: Colors.grey[400],
              ),
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: footerColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Icon(
                      Icons.mail_outline,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {},
                ),
              ),
              if (cursoData != null)
                Padding(
                  padding: const EdgeInsets.only(top: 36, bottom: 36),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      cursoData!.status!.data!.curso!.uri.toString(),
                    ),
                  ),
                ),
              if (cursoData != null)
                if (cursoData!.status!.data!.curso!.video.toString().isNotEmpty)
                  Chewie(
                    controller: ChewieController(
                      videoPlayerController: VideoPlayerController.networkUrl(
                        Uri.parse(
                          cursoData!.status!.data!.curso!.video.toString(),
                        ),
                      ),
                      aspectRatio: 16 / 9,
                      autoInitialize: true,
                    ),
                  )
                else
                  const SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (cursoData != null)
                    ButtonMain(
                      text: 'Test de entrada',
                      onPress: TestEntradaView(
                        user: widget.user,
                        curso: cursoData!.status!.data!.curso!.nid,
                        leccion: cursoData!.status!.data!.leccionId,
                      ),
                    ),
                  if (cursoData != null)
                    ButtonMain(
                      text: 'Test de salida',
                      onPress: TestSalidaPage(
                        user: widget.user,
                        curso: cursoData!.status!.data!.curso!.nid.toString(),
                        leccion: cursoData!.status!.data!.leccionId.toString(),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomAppBar(),
    );
  }
}
