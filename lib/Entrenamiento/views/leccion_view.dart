import 'package:cached_network_image/cached_network_image.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:universidad_lg_24/Entrenamiento/entrenamiento/entrenamiento_bloc.dart';
import 'package:universidad_lg_24/Entrenamiento/models/active_test_salida_model.dart';
import 'package:universidad_lg_24/Entrenamiento/models/leccion_model.dart';
import 'package:universidad_lg_24/Entrenamiento/views/curso_preview_view.dart';
import 'package:universidad_lg_24/Home/views/new_home_view.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:video_player/video_player.dart';

CountdownTimerController? controllerTime;

class LeccionPage extends StatefulWidget {
  const LeccionPage({
    required this.user,
    required this.curso,
    required this.leccion,
    super.key,
    this.parent,
  });
  final User user;
  final String curso;
  final String leccion;
  final String? parent;

  @override
  _LeccionPageState createState() => _LeccionPageState();
}

class _LeccionPageState extends State<LeccionPage> {
  @override
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
                MaterialPageRoute<void>(
                  builder: (_) {
                    return NewHomeView(
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
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) =>
                  CursoPreviewPage(user: widget.user, nid: widget.parent!),
            ),
          );

          return false;
        },
        child: _LeccionContent(
          user: widget.user,
          curso: widget.curso,
          leccion: widget.leccion,
        ),
      ),
    );
  }
}

class _LeccionContent extends StatefulWidget {
  const _LeccionContent({this.user, this.curso, this.leccion});
  final User? user;
  final String? curso;
  final String? leccion;
  @override
  __LeccionContentState createState() => __LeccionContentState();
}

class __LeccionContentState extends State<_LeccionContent> {
  Leccion? leccion;
  bool load = false;
  EntrenamientoBloc leccionBloc = EntrenamientoBloc();
  int endTime = 0;

  void _onLoad() {
    if (mounted) {
      setState(() {
        load = true;
      });
    }
  }

  void loadData() {
    leccionBloc
        .getLeccionContent(
      token: widget.user!.token,
      uid: widget.user!.userId,
      curso: widget.curso,
      leccion: widget.leccion,
    )
        .then((value) {
      _onLoad();
      leccion = value;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();

    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * (2 * 60);
    // controllerTime =
    //     CountdownTimerController(endTime: endTime, onEnd: _onFinishTime);

    // Activar Test Salida
    leccionBloc
        .activeTestSalida(
      uid: widget.user!.userId,
      token: widget.user!.token,
      curso: widget.curso,
    )
        .then((value) {
      final respuesta = value!;
      // print('pasa');
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // controllerTime.disposeTimer();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (load) {
      return Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(50, 10, 50, 0.8),
                child: CachedNetworkImage(
                  imageUrl: leccion!.status!.data!.curso!.uri!,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(
                    color: mainColor,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Align(
                      child: Text(
                        '${leccion!.status!.data!.curso!.titulo}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    HtmlWidget(
                      leccion!.status!.data!.curso!.bodyValue!,
                    ),
                  ],
                ),
              ),
              if (leccion!.status!.data!.curso!.tipo == 'VideoLocal')
                _VideoPlayerLeccion(leccion!)
              else
                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 200,
                      width: double.infinity,
                      child: HtmlWidget(
                        '<iframe height="${MediaQuery.of(context).size.height - 250} "  width="${MediaQuery.of(context).size.width}"+ src="https://docs.google.com/gview?url=${leccion!.status!.data!.curso!.datos}&embedded=true" frameborder="0" ></iframe>',
                      ),
                    ),
                    // CountdownTimer(
                    //   controller: controllerTime,
                    // ),
                  ],
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

  _onFinishTime() {
    // print('dddd');

    showDialog<String>(
      context: context,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: const Text(
            '¡Enhorabuena!',
            textAlign: TextAlign.center,
            style: TextStyle(color: mainColor),
          ),
          content: const Text(
            'Has tomado todo el curso, ahora puedes realizar el Test de Salida, ¡Suerte!',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                leccionBloc
                    .activeTestSalida(
                  uid: widget.user!.userId,
                  token: widget.user!.token,
                  curso: widget.curso,
                )
                    .then((value) {
                  final respuesta = value!;
                });
                Navigator.pop(context, 'pasa');
                // validadcion deregreso
              },
              child: const Text(
                'CONTINUAR',
                style: TextStyle(color: mainColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VideoPlayerLeccion extends StatefulWidget {
  const _VideoPlayerLeccion(this.leccion);
  final Leccion leccion;
  @override
  __VideoPlayerLeccion createState() => __VideoPlayerLeccion();
}

class __VideoPlayerLeccion extends State<_VideoPlayerLeccion>
    with TickerProviderStateMixin {
  VideoPlayerController? _controller;
  FlickManager? flickManager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(
        widget.leccion.status!.data!.curso!.datos!,
      ),
    );
    // _controller =
    //     VideoPlayerController.network(widget.leccion.status.data.curso.datos)
    //       ..initialize().then((_) {
    //         setState(() {});
    //       });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
