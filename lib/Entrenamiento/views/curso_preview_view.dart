import 'package:cached_network_image/cached_network_image.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:universidad_lg_24/Entrenamiento/entrenamiento/entrenamiento_bloc.dart';
import 'package:universidad_lg_24/Entrenamiento/models/models.dart';
import 'package:universidad_lg_24/Entrenamiento/views/leccion_view.dart';
import 'package:universidad_lg_24/Entrenamiento/views/test_entrada_view.dart';
import 'package:universidad_lg_24/Entrenamiento/views/test_salida_view.dart';
import 'package:universidad_lg_24/Home/views/home_view.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/users/views/login/login_view.dart';

import 'package:universidad_lg_24/users/blocs/authentication/authentication_bloc.dart';
import 'package:video_player/video_player.dart';

class CursoPreviewPage extends StatefulWidget {
  const CursoPreviewPage({
    required this.user,
    required this.nid,
    super.key,
  });
  final User user;
  final String nid;

  @override
  _CursoPreviewPageState createState() => _CursoPreviewPageState();
}

class _CursoPreviewPageState extends State<CursoPreviewPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Center(
          child: InkWell(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return HomeView(
                      user: widget.user,
                    );
                  },
                ),
                (route) => false,
              );
            },
            child: const Image(
              image: AssetImage('assets/images/new_logo.png'),
              height: 35,
            ),
          ),
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
              icon: const Icon(Icons.person),
              color: Colors.transparent,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticatedState) {
            // show home page

            return _CursoPreviewContent(
              user: state.user,
              nid: widget.nid,
            );
          }
          // otherwise show login page
          return const LoginView();
        },
      ),
    );
  }
}

class _CursoPreviewContent extends StatefulWidget {
  _CursoPreviewContent({this.user, this.nid});
  User? user;
  String? nid;
  @override
  __CursoPreviewContentState createState() => __CursoPreviewContentState();
}

class __CursoPreviewContentState extends State<_CursoPreviewContent> {
  CursoPreview? cursoPreview;
  bool load = false;
  String? _textTestEntrada;
  bool acceso = false;
  EntrenamientoBloc cursoPreviewBloc = EntrenamientoBloc();

  void _onLoad() {
    if (mounted) {
      setState(() {
        load = true;
      });
    }
  }

  void loadData() {
    cursoPreviewBloc
        .getCursoPreviewContent(
      token: widget.user!.token,
      uid: widget.user!.userId,
      curso: widget.nid,
    )
        .then((value) {
      _onLoad();
      cursoPreview = value;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (load) {
      print(cursoPreview!.status!.data!.curso!.video);
      return Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (cursoPreview!.status!.data!.curso!.video!.isEmpty)
                Container(
                  margin: const EdgeInsets.fromLTRB(50, 10, 50, 0.8),
                  child: CachedNetworkImage(
                    imageUrl: cursoPreview!.status!.data!.curso!.uri!,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(
                      color: mainColor,
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                )
              else
                _VideoPlayerLeccion(cursoPreview!.status!.data!.curso!.video!),
              Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Align(
                      child: Text(
                        '${cursoPreview!.status!.data!.curso!.title}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    HtmlWidget(
                      cursoPreview!.status!.data!.curso!.bodyValue!,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                        shape: const RoundedRectangleBorder(),
                      ),
                      onPressed: () {
                        if (cursoPreview!.status!.data!.testEntrada == 0 ||
                            cursoPreview!.status!.data!.testEntrada == 2) {
                          acceso = true;
                          _textTestEntrada =
                              'Por favor lee detenidamente cada una de las preguntas y opciones de respuesta a continuación. Debes disponer de ${cursoPreview!.status!.data!.testTiempo} minutos, una buena conexión a internet, no cierres o salgas de la aplicación.';
                        } else {
                          acceso = false;
                          _textTestEntrada =
                              'Este Test de Entrada ya fue realizado y no puede repetirse, debes continuar el curso.';
                        }

                        _viewTestEntrada(_textTestEntrada.toString(), acceso);
                      },
                      child: const Text('TEST DE ENTRADA'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                        shape: const RoundedRectangleBorder(),
                      ),
                      onPressed: () {
                        if (cursoPreview!.status!.data!.testEntrada == 1 ||
                            cursoPreview!.status!.data!.testEntrada == 2) {
                          _textTestEntrada = 'Continuar';
                          acceso = true;
                        } else {
                          _textTestEntrada =
                              'Primero debes completar el Test de Entrada para ingresar al contenido del curso.';
                          acceso = false;
                        }

                        _viewLeccion(_textTestEntrada.toString(), acceso);
                      },
                      child: const Text('VER CURSO'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                        shape: const RoundedRectangleBorder(),
                      ),
                      onPressed: () {
                        if ((cursoPreview!.status!.data!.testEntrada == 1 &&
                                cursoPreview!.status!.data!.testSalida == 0 &&
                                cursoPreview!.status!.data!.verCurso == 1) ||
                            (cursoPreview!.status!.data!.testEntrada == 2 &&
                                cursoPreview!.status!.data!.testSalida == 0 &&
                                cursoPreview!.status!.data!.verCurso == 1)) {
                          acceso = true;
                          _textTestEntrada =
                              'Por favor lee detenidamente cada una de las preguntas y opciones de respuesta a continuación. Debes disponer de ${cursoPreview!.status!.data!.testTiempo} minutos, una buena conexión a internet, no cierres o salgas de la aplicación.';
                        }

                        if (cursoPreview!.status!.data!.testSalida == 1 &&
                            cursoPreview!.status!.data!.verCurso == 1) {
                          acceso = false;
                          _textTestEntrada =
                              'Este Test de Salida ya fue realizado y no puede repetirse.';
                        }

                        if (cursoPreview!.status!.data!.testEntrada == 0 ||
                            cursoPreview!.status!.data!.verCurso == 0) {
                          acceso = false;
                          _textTestEntrada =
                              'Primero debes terminar el Test de Entrada y luego ver el curso para tomar este Test de Salida.';
                        }

                        if ((cursoPreview!.status!.data!.testEntrada == 1 &&
                                cursoPreview!.status!.data!.verCurso == 0) ||
                            cursoPreview!.status!.data!.testEntrada == 2 ||
                            cursoPreview!.status!.data!.verCurso == 0) {
                          acceso = false;
                          _textTestEntrada =
                              'Debes ver el curso para tomar este Test de Salida.';
                        }

                        _viewTestSalida(_textTestEntrada.toString(), acceso);
                      },
                      child: const Text('TEST DE SALIDA'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(color: mainColor),
      );
    }
  }

  _viewTestEntrada(String textDinamic, bool acceso) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          '¡Ten presente!',
          textAlign: TextAlign.center,
          style: TextStyle(color: mainColor, fontWeight: FontWeight.w600),
        ),
        content: Text(
          _textTestEntrada.toString(),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();

                  if (acceso) {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => TestEntradaPage(
                          parent: widget.nid,
                          user: widget.user,
                          curso: cursoPreview!.status!.data!.curso!.nid,
                          leccion: cursoPreview!.status!.data!.leccionId,
                        ),
                      ),
                    );
                  }

                  // return false;
                },
                child: const Text(
                  'Continuar',
                  style: TextStyle(color: mainColor, fontSize: 18),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _viewLeccion(String textDinamic, bool acceso) async {
    if (acceso) {
      await Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => LeccionPage(
            user: widget.user!,
            curso: cursoPreview!.status!.data!.curso!.nid!,
            leccion: cursoPreview!.status!.data!.leccionId!,
            parent: widget.nid,
          ),
        ),
      );
    } else {
      await showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text(
            '¡Ten presente!',
            textAlign: TextAlign.center,
            style: TextStyle(color: mainColor, fontWeight: FontWeight.w600),
          ),
          content: Text(
            textDinamic,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // return false;
                  },
                  child: const Text(
                    'Continuar',
                    style: TextStyle(color: mainColor, fontSize: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }

  _viewTestSalida(String textDinamic, bool acceso) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          '¡Ten presente!',
          textAlign: TextAlign.center,
          style: TextStyle(color: mainColor, fontWeight: FontWeight.w600),
        ),
        content: Text(
          _textTestEntrada.toString(),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();

                  if (acceso) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TestSalidaPage(
                          user: widget.user!,
                          curso: cursoPreview!.status!.data!.curso!.nid!,
                          leccion: cursoPreview!.status!.data!.leccionId!,
                        ),
                      ),
                    );
                  }

                  return;
                },
                child: const Text(
                  'Continuar',
                  style: TextStyle(color: mainColor, fontSize: 18),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _VideoPlayerLeccion extends StatefulWidget {
  const _VideoPlayerLeccion(this.video);
  final String video;
  @override
  __VideoPlayerLeccion createState() => __VideoPlayerLeccion();
}

class __VideoPlayerLeccion extends State<_VideoPlayerLeccion>
    with TickerProviderStateMixin {
  VideoPlayerController? _controller;
  FlickManager? flickManager;

  @override
  void initState() {
    super.initState();
    // _controller = VideoPlayerController.network(widget.video)
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {});
    //   });
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(widget.video),
    );

    // _controller.value.duration;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.5),
      child: FlickVideoPlayer(flickManager: flickManager!),
    );
  }

  @override
  void dispose() {
    super.dispose();
    flickManager?.dispose();
    _controller?.dispose();
  }
}
