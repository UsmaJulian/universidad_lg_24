// ignore_for_file: must_be_immutable, always_declare_return_types, inference_failure_on_function_return_type

import 'package:cool_stepper_reloaded/cool_stepper_reloaded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:rainbow_color/rainbow_color.dart';
import 'package:universidad_lg_24/Evaluaciones/bloc/evaluacion_bloc.dart';
import 'package:universidad_lg_24/Evaluaciones/models/models.dart';
import 'package:universidad_lg_24/Evaluaciones/views/evaluacion_view.dart';
import 'package:universidad_lg_24/Evaluaciones/views/resultado_view.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/helpers/flutter_radio_button_form_field.dart';
import 'package:universidad_lg_24/users/models/models.dart';

Map<dynamic, dynamic> preguntasList = {};
CountdownTimerController? controllerTime;
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class SingleEvaluacionView extends StatefulWidget {
  const SingleEvaluacionView({
    required this.user,
    required this.nid,
    super.key,
  });
  final User? user;
  final String nid;

  @override
  _SingleEvaluacionViewState createState() => _SingleEvaluacionViewState();
}

class _SingleEvaluacionViewState extends State<SingleEvaluacionView> {
  EvaluacionBloc evalacionBloc = EvaluacionBloc();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async {
        return _onBackPressed();
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: mainColor,
          title: const Center(
            child: InkWell(
              child: Image(
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
        body: _SingleEvaluacionContent(
          user: widget.user,
          nid: widget.nid,
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          '¡DESEA REGRESAR!',
          textAlign: TextAlign.center,
          style: TextStyle(color: mainColor),
        ),
        content: const Text(
          'Se enviará la información provista hasta el momento',
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
                  evalacionBloc
                      .sendEvaluacion(
                    data: preguntasList,
                    uid: widget.user!.userId,
                    token: widget.user!.token,
                    nid: widget.nid,
                  )
                      .then((value) {
                    final respuesta = value;

                    _result(
                      res: respuesta.status!.evaluacionRest,
                      user: widget.user,
                      context: context,
                      id: widget.nid,
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

class _SingleEvaluacionContent extends StatefulWidget {
  _SingleEvaluacionContent({this.user, this.nid});
  User? user;
  String? nid;
  @override
  __SingleEvaluacionContentState createState() =>
      __SingleEvaluacionContentState();
}

class __SingleEvaluacionContentState extends State<_SingleEvaluacionContent> {
  SingleEvaluacion? evaluacionInfo;
  bool load = false;
  EvaluacionBloc evalacionBloc = EvaluacionBloc();

  void _onLoad() {
    if (mounted) {
      setState(() {
        load = true;
        preguntasList = {};
      });
    }
  }

  void loadData() {
    evalacionBloc
        .getSingleEvaluaionesContent(
      token: widget.user!.token,
      uid: widget.user!.userId,
      nid: widget.nid,
    )
        .then((value) {
      _onLoad();
      evaluacionInfo = value;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (load) {
      return Container(
        // padding: EdgeInsets.all(0),
        child: _ContentSingleEvaluacion(
          evaluacionInfo: evaluacionInfo,
          time: int.parse(
            evaluacionInfo!.status!.tiempo!,
          ),
          nid: widget.nid,
          user: widget.user,
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

class _ContentSingleEvaluacion extends StatefulWidget {
  const _ContentSingleEvaluacion({
    super.key,
    this.evaluacionInfo,
    this.time,
    this.user,
    this.nid,
  });
  final SingleEvaluacion? evaluacionInfo;
  final int? time;
  final User? user;
  final String? nid;

  @override
  __ContentSingleEvaluacionState createState() =>
      __ContentSingleEvaluacionState();
}

class __ContentSingleEvaluacionState extends State<_ContentSingleEvaluacion>
    with TickerProviderStateMixin {
  EvaluacionBloc evalacionBloc = EvaluacionBloc();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  List<CoolStep> steps = [];
  String selectedRole = '';
  bool _autoValidate = false;
  SendEvaluacion? respuesta;
  Color barra = const Color(0xFF009846);

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

  Animatable<double> bgValue = Tween<double>(begin: 0, end: 10);

  Rainbow rb = Rainbow(
    rangeEnd: 10.0,
    spectrum: [
      Colors.green,
      Colors.yellow,
      mainColor,
    ],
  );

  @override
  void dispose() {
    // detroy de la animacion
    controllerAnimation?.dispose();
    super.dispose();
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
              child: CoolStepper(
                onCompleted: _onFinish,
                steps: steps,
                config: const CoolStepperConfig(
                  backText: 'ANTERIOR',
                  nextText: 'SIGUIENTE',
                  finalText: 'ENVIAR',
                  stepText: '',
                  ofText: 'DE',
                  headerColor: mainColor,
                  titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
                  subtitleTextStyle:
                      TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            Container(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  LinearProgressIndicator(
                    value: controllerAnimation!.value,
                    color: mainColor,
                    backgroundColor: rb[_anim!.value],
                    minHeight: 30,
                  ),
                  CountdownTimer(
                    controller: controllerTime,
                    onEnd: _onFinishTime,
                    endTime: endTime,
                    widgetBuilder: (_, CurrentRemainingTime? time) {
                      // print((widget.time / 1.2));
                      // print(time.min);

                      // if (time.min <= 8) {
                      //   setState(() {
                      //     barra = Color(0xFFFFE900);
                      //   });
                      // }

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
    for (final item in widget.evaluacionInfo!.status!.preguntas!) {
      // List<Respuesta> repustas = item.respuestas;
      final respuesta = item.respuestas!;

      final data = <Map<dynamic, dynamic>>[];

      for (final rs in respuesta) {
        data.add({'value': rs.delta, 'display': rs.texto});
      }
      preguntasList[item.id] = '0';
      steps.add(
        CoolStep(
          title: 'Pregunta $cont',
          subtitle: item.texto!,
          content: SizedBox(
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
                      preguntasList[item.id] = value;
                    });
                  },
                  validator: (value) {
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
  }

  ///////////////  finalizavion de los steps //////////

  _onFinish() {
    showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          '¡ENVIAR EVALUACIÓN!',
          textAlign: TextAlign.center,
          style: TextStyle(color: mainColor),
        ),
        content: const Text(
          'Se enviará tu evaluación',
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
                  evalacionBloc
                      .sendEvaluacion(
                    data: preguntasList,
                    uid: widget.user!.userId,
                    token: widget.user!.token,
                    nid: widget.nid,
                  )
                      .then((value) {
                    respuesta = value;

                    _result(
                      res: respuesta!.status!.evaluacionRest,
                      user: widget.user,
                      context: context,
                      id: widget.nid,
                    );
                  });
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
            'Te has tomado más tiempo de lo previsto, El progreso realizado será enviado.',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                evalacionBloc
                    .sendEvaluacion(
                  data: preguntasList,
                  uid: widget.user!.userId,
                  token: widget.user!.token,
                  nid: widget.nid,
                )
                    .then((value) {
                  respuesta = value;

                  _result(
                    res: respuesta!.status!.evaluacionRest,
                    user: widget.user,
                    context: context,
                    id: widget.nid,
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

  /// resivir el resultado ///
}

_result({EvaluacionRest? res, User? user, BuildContext? context, String? id}) {
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
                  text: 'EVALUACIÓN: ',
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
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => ResultadoView(
                        user: user,
                        evaluacion: id,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'VER RESPUESTAS',
                  style: TextStyle(
                    color: mainColor,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);

                  // debe haber un forma de retocedder el nav hasta un  punto
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => EvaluacionView(
                        user: user,
                      ),
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
