// ignore_for_file: must_be_immutable, always_declare_return_types, inference_failure_on_function_return_type, unused_field, unused_element_parameter, unused_local_variable

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
import 'package:universidad_lg_24/widgets/drawer_menu.dart';
import 'package:universidad_lg_24/widgets/global/bottom_app_bar_global.dart';
import 'package:universidad_lg_24/widgets/global/header_global.dart';

Map<dynamic, dynamic> preguntasList = {};
CountdownTimerController? controllerTime;
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class SingleEvaluacionView extends StatefulWidget {
  const SingleEvaluacionView({
    required this.user,
    required this.nid,
    required this.singleRoute,
    super.key,
  });
  final User? user;
  final String nid;
  final String singleRoute;

  @override
  _SingleEvaluacionViewState createState() => _SingleEvaluacionViewState();
}

class _SingleEvaluacionViewState extends State<SingleEvaluacionView> {
  EvaluacionBloc evalacionBloc = EvaluacionBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: const Color(0xffF6F3EB),
      appBar: CustomAppBar(user: widget.user),
      endDrawer: DrawerMenu(
        user: widget.user,
        isHome: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 166, left: 18, right: 18, bottom: 119),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: _onBackPressed,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(129, 41),
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    side: BorderSide(),
                  ),
                ),
                child: const Text(
                  'Volver',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Evaluación',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 43),
                child: Divider(
                  color: Color(0xff707070),
                  thickness: 1,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: _SingleEvaluacionContent(
                  user: widget.user,
                  nid: widget.nid,
                  singleRoute: widget.singleRoute,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomAppBar(),
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
  const _SingleEvaluacionContent({
    required this.singleRoute,
    this.user,
    this.nid,
    super.key,
  });

  final User? user;
  final String? nid;
  final String singleRoute;

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
  void dispose() {
    print('dispose 2 called');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!load) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return _ContentSingleEvaluacion(
      evaluacionInfo: evaluacionInfo,
      time: int.parse(evaluacionInfo!.status!.tiempo ?? '30'),
      user: widget.user,
      nid: widget.nid,
      singleRoute: widget.singleRoute,
    );
  }
}

class _ContentSingleEvaluacion extends StatefulWidget {
  const _ContentSingleEvaluacion({
    required this.singleRoute,
    required this.evaluacionInfo,
    required this.time,
    required this.user,
    required this.nid,
  });
  final SingleEvaluacion? evaluacionInfo;
  final int? time;
  final User? user;
  final String? nid;
  final String singleRoute;

  @override
  __ContentSingleEvaluacionState createState() =>
      __ContentSingleEvaluacionState();
}

class __ContentSingleEvaluacionState extends State<_ContentSingleEvaluacion>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  // Services and state
  final EvaluacionBloc evalacionBloc = EvaluacionBloc();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  // Navigation
  final PageController _pageController = PageController();
  int _currentQuestionIndex = 0;

  // Form and data
  final List<CoolStep> steps = [];
  SendEvaluacion? respuesta;
  bool _autoValidate = false;

  // Timer and animation
  AnimationController? controllerAnimation;
  Animation<double>? _anim;
  int endTime = 0;
  final Color barra = const Color(0xFF009846);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

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
    WidgetsBinding.instance.removeObserver(this);
    print('dispose 3 called');

    controllerTime?.disposeTimer();

    // detroy de la animacion
    controllerAnimation?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('stateUI: $state');
    if (state == AppLifecycleState.paused) {
      print('paused');
      pauseTimer();
    } else if (state == AppLifecycleState.resumed) {
      print('Started');
      startTimer();
    }
  }

  void startTimer() {
    controllerTime?.start();
  }

  void pauseTimer() {
    print('pauseController');
    controllerTime?.disposeTimer();
  }

  void _goToNextQuestion() {
    if (_currentQuestionIndex < steps.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _onFinish();
    }
  }

  void _goToPreviousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Sección de preguntas:${steps[_currentQuestionIndex].title}');
    if (steps.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Progress indicator (e.g., "1/10")
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Text(
              '${_currentQuestionIndex + 1}/${steps.length}',
              style: const TextStyle(
                color: Color(0xffAAA8A5),
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Question text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              steps[_currentQuestionIndex].title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Divider
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Divider(
              color: Color(0xff707070),
              thickness: 1,
            ),
          ),

          // PageView for questions
          SizedBox(
            height: MediaQuery.of(context).size.height *
                0.3, // Fixed height for the question area
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: steps.length,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: steps[index].content,
                  ),
                );
              },
            ),
          ),

          // Navigation buttons
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Previous button (only show if not first question)
                if (_currentQuestionIndex > 0)
                  ElevatedButton(
                    onPressed: _goToPreviousQuestion,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(120, 50),
                      backgroundColor: const Color(0xffF6F3EB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: const BorderSide(),
                      ),
                    ),
                    child: const Text(
                      'ANTERIOR',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                else
                  const SizedBox(width: 120), // Spacer when button is hidden

                // Next/Submit button
                ElevatedButton(
                  onPressed: _goToNextQuestion,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(120, 50),
                    backgroundColor: mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    _currentQuestionIndex < steps.length - 1
                        ? 'SIGUIENTE'
                        : 'ENVIAR',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Timer
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: CountdownTimer(
              controller: controllerTime,
              onEnd: _onFinish,
              widgetBuilder: (_, CurrentRemainingTime? time) {
                if (time == null) {
                  return const Text(
                    'Tiempo finalizado',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.timer, color: Colors.white),
                    const SizedBox(width: 5),
                    Text(
                      '${time.min ?? 0}:${time.sec.toString().padLeft(2, '0')}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
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
          // title: 'Pregunta $cont',
          title: item.texto!,
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

  void _onFinish() {
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

  if (puntaje >= 90) {}

  showDialog<String>(
    context: context!,
    barrierDismissible: false,
    // para no cerrar outclick de la alerta
    builder: (BuildContext context) => PopScope(
      // will para evitar el retroceso
      canPop: false,
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
