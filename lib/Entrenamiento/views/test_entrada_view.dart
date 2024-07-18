// ignore_for_file: strict_raw_type, inference_failure_on_function_return_type

import 'package:cool_stepper_reloaded/cool_stepper_reloaded.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:rainbow_color/rainbow_color.dart';
import 'package:universidad_lg_24/Entrenamiento/entrenamiento/entrenamiento_bloc.dart';
import 'package:universidad_lg_24/Entrenamiento/models/send_test_entrada_model.dart';
import 'package:universidad_lg_24/Entrenamiento/models/test_entrada_model.dart';
import 'package:universidad_lg_24/Entrenamiento/views/curso_preview_view.dart';

import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/helpers/flutter_radio_button_form_field.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/widgets/button_main.dart';
import 'package:universidad_lg_24/widgets/global/header_global.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';

Map preguntasList = {};
CountdownTimerController? controllerTime;
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class TestEntradaView extends StatefulWidget {
  const TestEntradaView({
    required this.user,
    required this.curso,
    required this.leccion,
    super.key,
    this.parent,
  });
  final String? parent;
  final User? user;
  final String? curso;
  final String? leccion;

  @override
  _TestEntradaViewState createState() => _TestEntradaViewState();
}

class _TestEntradaViewState extends State<TestEntradaView> {
  EntrenamientoBloc testEntradaBloc = EntrenamientoBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: secondColor,
      appBar: CustomAppBar(),
      endDrawer: DrawerMenu(
        user: widget.user,
        isHome: true, // Indica que el DrawerMenuLeft se está utilizando
        // en la pantalla de inicio.
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 128),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 10, top: 10),
              child: OutlinedButton(
                onPressed: _onBackPressed,
                child: const Text(
                  'Volver',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Expanded(
              child: _TestEntradaContent(
                user: widget.user,
                curso: widget.curso,
                leccion: widget.leccion,
                parent: widget.parent,
              ),
            ),
          ],
        ),
      ),

      // otherwise show login page
    );
  }

  Future<bool> _onBackPressed() async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          '¿DESEA REGRESAR?',
          textAlign: TextAlign.center,
          style: TextStyle(color: mainColor),
        ),
        content: const Text(
          'Se enviará la información prevista hasta el momento',
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancelar',
                  style: TextStyle(
                    color: mainColor,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  testEntradaBloc
                      .sendTestEntrada(
                    data: preguntasList,
                    uid: widget.user!.userId,
                    token: widget.user!.token,
                    curso: widget.curso,
                    leccion: widget.leccion,
                  )
                      .then((value) {
                    final respuesta = value!;

                    _result(
                      context: context,
                      res: respuesta.status!.dataTest,
                      user: widget.user,
                      id: widget.curso,
                      parent: widget.parent,
                    );
                  });
                },
                child: const Text(
                  'Aceptar',
                  style: TextStyle(
                    color: mainColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
    return false;
  }
}

class _TestEntradaContent extends StatefulWidget {
  const _TestEntradaContent({this.user, this.curso, this.leccion, this.parent});
  final User? user;
  final String? curso;
  final String? leccion;
  final String? parent;
  @override
  __TestEntradaContentState createState() => __TestEntradaContentState();
}

class __TestEntradaContentState extends State<_TestEntradaContent> {
  TestEntrada? testEntradaInfo;
  bool load = false;
  EntrenamientoBloc testEntradaBloc = EntrenamientoBloc();

  void _onLoad() {
    if (mounted) {
      setState(() {
        load = true;
        preguntasList = {};
      });
    }
  }

  void loadData() {
    testEntradaBloc
        .getTestEntradaContent(
      token: widget.user!.token,
      uid: widget.user!.userId,
      curso: widget.curso,
      leccion: widget.leccion,
    )
        .then((value) {
      _onLoad();
      testEntradaInfo = value;
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
      return SizedBox(
        // padding: EdgeInsets.all(0),
        child: _ContentTestEntrada(
          testEntradaInfo: testEntradaInfo,
          time: int.parse(
            testEntradaInfo!.status!.tiempo!,
          ),
          user: widget.user,
          curso: widget.curso,
          leccion: widget.leccion,
          parent: widget.parent,
        ),
      );
    }

    return const Center(
      child: CircularProgressIndicator(
        color: mainColor,
      ),
    );
  }
}

class _ContentTestEntrada extends StatefulWidget {
  const _ContentTestEntrada({
    this.testEntradaInfo,
    this.time,
    this.user,
    this.curso,
    this.leccion,
    this.parent,
  });
  final TestEntrada? testEntradaInfo;
  final int? time;
  final User? user;
  final String? curso;
  final String? leccion;
  final String? parent;

  @override
  __ContentTestEntradaState createState() => __ContentTestEntradaState();
}

class __ContentTestEntradaState extends State<_ContentTestEntrada>
    with TickerProviderStateMixin {
  // EvaluacionBloc evalacionBloc = EvaluacionBloc();
  EntrenamientoBloc testEntradaBloc = EntrenamientoBloc();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  List<CoolStep> steps = [];
  String selectedRole = '';
  bool _autoValidate = false;
  // SendEvaluacion respuesta;

  Animatable<double> bgValue = Tween<double>(begin: 0, end: 10);

  Rainbow rb = Rainbow(
    rangeEnd: 10.0,
    spectrum: [
      Colors.green,
      Colors.yellow,
      mainColor,
    ],
  );

  AnimationController? controllerAnimation;
  Animation<double>? _anim;
  int endTime = 0;

  @override
  void initState() {
    super.initState();
    //crear los steps/////
    listSteps();

    //  inicion de contador
    endTime =
        DateTime.now().millisecondsSinceEpoch + 1000 * (widget.time! * 60);
    controllerTime =
        CountdownTimerController(endTime: endTime, onEnd: _onFinishTime);

    /// animacion del loader
    if (controllerAnimation != null) {
      controllerAnimation?.dispose();
    }
    controllerAnimation = AnimationController(
      vsync: this,
      duration: Duration(minutes: widget.time!),
    )..addListener(() {
        setState(() {
          // col
        });
      });

    controllerAnimation?.repeat(max: 1);
    controllerAnimation?.forward();
    _anim = bgValue.animate(controllerAnimation!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _key,
        autovalidateMode:
            _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: CoolStepper(
                  onCompleted: _onFinish,
                  contentPadding: const EdgeInsets.all(15),
                  steps: steps,
                  config: CoolStepperConfig(
                    backText: 'ANTERIOR',
                    nextText: 'SIGUIENTE',
                    finalText: 'ENVIAR',
                    stepText: '',
                    ofText: 'DE',
                    headerColor: secondColor,
                    titleTextStyle:
                        const TextStyle(color: Colors.black, fontSize: 20),
                    subtitleTextStyle:
                        const TextStyle(color: Colors.black, fontSize: 16),
                    nextTextStyle: const TextStyle(
                      color: mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    nextButton: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(110, 50),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        backgroundColor: mainColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'SIGUIENTE',
                        style: TextStyle(color: secondColor),
                      ),
                    ),
                    finishButton: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(110, 50),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        backgroundColor: mainColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'ENVIAR',
                        style: TextStyle(color: secondColor),
                      ),
                    ),
                    backButton: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(110, 50),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        backgroundColor: secondColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'ANTERIOR',
                        style: TextStyle(color: mainColor),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  LinearProgressIndicator(
                    value: controllerAnimation?.value,
                    color: mainColor,
                    backgroundColor: rb[_anim!.value],
                    minHeight: 30,
                  ),
                  CountdownTimer(
                    controller: controllerTime,
                    onEnd: _onFinishTime,
                    endTime: endTime,
                    widgetBuilder: (_, CurrentRemainingTime? time) {
                      if (time == null) {
                        return const Text(
                          'Tiempo finalizado',
                          style: TextStyle(color: Colors.white),
                        );
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.timer,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            '${time.min ?? 0} : ${time.sec}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ////////////////////  llenar los steps/////////////////

  void listSteps() {
    var cont = 1;
    for (final item in widget.testEntradaInfo!.status!.preguntas!) {
      // List<Respuesta> repustas = item.respuestas;
      final respuesta = item.respuestas! as List<dynamic>;

      final data = <Map>[];

      for (final rs in respuesta) {
        data.add({'value': rs.delta, 'display': rs.texto});
      }
      preguntasList[item.id] = '0';
      steps.add(
        CoolStep(
          title: 'Pregunta $cont',
          subtitle: item.texto!.toString(),
          content: Container(
            child: Column(
              children: <Widget>[
                FlutterRadioButtonFormField(
                  toggleable: true,
                  padding: const EdgeInsets.all(8),
                  context: context,
                  value: 'value',
                  display: 'display',
                  data: data,
                  activeColor: mainColor,
                  autoValidate: true,
                  onSaved: (value) {
                    setState(() {
                      preguntasList[item.id] = value.toString();
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'no pasa';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          validation: () {
            setState(() {
              _autoValidate = true;
            });

            if (!_key.currentState!.validate()) {
              ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
                const SnackBar(
                  content: Text('Marca una casilla para continuar'),
                  backgroundColor: mainColor,
                ),
              );

              return 'no-pasa';
            }

            /// guarda el formulatio despues de cada step para llenar el map  ///
            _key.currentState?.save();
            return null;
          },
        ),
      );
      cont++;
    }
    // return steps;
  }

  ///////////////  finalizavion de los steps //////////

  _onFinish() {
    showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          '¡ENVIAR TEST ENTRADA!',
          textAlign: TextAlign.center,
          style: TextStyle(color: mainColor),
        ),
        content: const Text(
          'Se enviará tu test de entrada.',
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'CANCELAR',
                  style: TextStyle(
                    color: mainColor,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  testEntradaBloc
                      .sendTestEntrada(
                    data: preguntasList,
                    uid: widget.user!.userId,
                    token: widget.user!.token,
                    curso: widget.curso,
                    leccion: widget.leccion,
                  )
                      .then((value) {
                    final respuesta = value!;

                    _result(
                      context: context,
                      res: respuesta.status!.dataTest,
                      user: widget.user,
                      id: widget.curso,
                      parent: widget.parent,
                    );
                  });

                  // Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute<void>(
                  //         builder: (BuildContext context) =>
                  //             EntrenamientoPage(user: widget.user)));
                },
                child: const Text(
                  'ENVIAR',
                  style: TextStyle(
                    color: mainColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    // print(preguntasList);
  }

  ///  finalizacion del tiempo ////
  _onFinishTime() {
    showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: const Text(
            '!TIEMPO FINALIZADO!',
            textAlign: TextAlign.center,
            style: TextStyle(color: mainColor),
          ),
          content: const Text(
            'Te has tomado más tiempo de lo previsto, intentalo a la próxima.',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                testEntradaBloc
                    .sendTestEntrada(
                  data: preguntasList,
                  uid: widget.user!.userId,
                  token: widget.user!.token,
                  curso: widget.curso,
                  leccion: widget.leccion,
                )
                    .then((value) {
                  final respuesta = value!;

                  _result(
                    context: context,
                    res: respuesta.status!.dataTest,
                    user: widget.user,
                    id: widget.curso,
                    parent: widget.parent,
                  );
                });
              },
              child: const Text(
                'ENVIAR',
                style: TextStyle(color: mainColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // detroy de la animacion
    controllerAnimation?.dispose();
    super.dispose();
  }
}

_result({
  DataTest? res,
  User? user,
  BuildContext? context,
  String? id,
  String? parent,
}) {
  // destroy del contador
  controllerTime?.disposeTimer();
  final title = res!.titulo!;
  final puntaje = res.puntaje!;
  final copa = res.copa!;

  showDialog<String>(
    context: context!,
    barrierDismissible: false,
    // para no cerrar outclick de la alerta
    builder: (BuildContext context) => WillPopScope(
      // will para evitar el retroceso
      onWillPop: () async => false,
      child: AlertDialog(
        title: const Text(
          'RESULTADO',
          textAlign: TextAlign.center,
          style: TextStyle(color: mainColor),
        ),
        content: SizedBox(
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user!.name!,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              RichText(
                text: TextSpan(
                  text: 'TEST DE ENTRADA: ',
                  style: const TextStyle(color: mainColor),
                  children: [
                    TextSpan(
                      text: title,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              RichText(
                text: TextSpan(
                  text: 'PUNTAJE: ',
                  style: const TextStyle(color: mainColor),
                  children: [
                    TextSpan(
                      text: '$puntaje%',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Icon(Icons.emoji_events, color: mainColor),
                  Text(copa),
                ],
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  // Navigator.pop(context);
                  // Navigator.pop(context);
                  // Navigator.pop(context);

                  // debe haber un forma de retocedder el nav hasta un  punto
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          CursoPreviewPage(user: user, nid: parent!),
                    ),
                  );
                },
                child: const Text(
                  'CONTINUAR',
                  style: TextStyle(
                    color: mainColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
