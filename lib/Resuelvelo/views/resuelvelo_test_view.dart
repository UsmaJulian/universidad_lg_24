import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:universidad_lg_24/Resuelvelo/models/resuelvelo_test_model.dart';
import 'package:universidad_lg_24/Resuelvelo/services/resuelvelo_services.dart';
import 'package:universidad_lg_24/Resuelvelo/views/resuelvelo_view.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/helpers/my_long_print.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/widgets/global/bottom_app_bar_global.dart';
import 'package:universidad_lg_24/widgets/global/header_global.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';

class ResuelveloTestView extends StatefulWidget {
  const ResuelveloTestView({
    required this.user,
    required this.content,
    super.key,
  });
  final User user;
  final ResuelveloTestModel content;
  @override
  State<ResuelveloTestView> createState() => _ResuelveloTestViewState();
}

class _ResuelveloTestViewState extends State<ResuelveloTestView> {
  int _currentTest = 0;
  final List<String> _currentAnswer = ['', '', '', '', '', '', '', '', '', ''];
  final List<Test> _test = [];
  @override
  void initState() {
    _test.addAll(widget.content.body.test);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Current: $_currentTest');
    return Scaffold(
      backgroundColor: const Color(0xffF6F3EB),
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: CustomAppBar(
        user: widget.user,
      ),
      endDrawer: DrawerMenu(
        user: widget.user,
        isHome: true, // Indica que el DrawerMenuLeft se está utilizando
        // en la pantalla de inicio.
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 166, left: 38, right: 38, bottom: 121),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) {
                        return ResuelveloView(user: widget.user);
                      },
                    ),
                  );
                },
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
                child: const Text(
                  'Volver',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Row(
                children: [
                  const Text(
                    'Test',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Image.asset(
                      'assets/png/lg premia tu conocimiento blanco _Mesa de trabajo 1 (2).png',
                      width: 180,
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 3),
                child: Divider(
                  color: Color(0xff707070),
                  thickness: 1,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: AutoSizeText(
                        '${_currentTest + 1}/${_test.length}',
                        minFontSize: 41,
                        maxFontSize: 45,
                        style: const TextStyle(
                          color: Color(0xffAAA8A5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 6, left: 38, right: 38),
                      child: AutoSizeText(
                        minFontSize: 10,
                        maxFontSize: 14,
                        _test[_currentTest].question,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Divider(
                        color: Color(0xff707070),
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const AutoSizeText(
                                'a',
                                minFontSize: 10,
                                maxFontSize: 14,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {
                                  if (_currentTest == 0) {
                                    _currentAnswer[0] = '1';
                                  } else if (_currentTest == 1) {
                                    _currentAnswer[1] = '1';
                                  } else if (_currentTest == 2) {
                                    _currentAnswer[2] = '1';
                                  } else if (_currentTest == 3) {
                                    _currentAnswer[3] = '1';
                                  } else if (_currentTest == 4) {
                                    _currentAnswer[4] = '1';
                                  } else if (_currentTest == 5) {
                                    _currentAnswer[5] = '1';
                                  } else if (_currentTest == 6) {
                                    _currentAnswer[6] = '1';
                                  } else if (_currentTest == 7) {
                                    _currentAnswer[7] = '1';
                                  } else if (_currentTest == 8) {
                                    _currentAnswer[8] = '1';
                                  } else if (_currentTest == 9) {
                                    _currentAnswer[9] = '1';
                                  }
                                  setState(() {
                                    if (_currentTest < _test.length - 1) {
                                      _currentTest++;
                                    }
                                  });
                                  debugPrint('CurrentAnswer: $_currentAnswer');
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(129, 41),
                                  backgroundColor: const Color(0xffF6F3EB),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                  ),
                                ),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: AutoSizeText(
                                    minFontSize: 10,
                                    maxFontSize: 14,
                                    _test[_currentTest].anwers.isNotEmpty
                                        ? _test[_currentTest].anwers[0]
                                        : 'Opción no disponible',
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'b',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_currentTest == 0) {
                                        _currentAnswer[0] = '2';
                                      } else if (_currentTest == 1) {
                                        _currentAnswer[1] = '2';
                                      } else if (_currentTest == 2) {
                                        _currentAnswer[2] = '2';
                                      } else if (_currentTest == 3) {
                                        _currentAnswer[3] = '2';
                                      } else if (_currentTest == 4) {
                                        _currentAnswer[4] = '2';
                                      } else if (_currentTest == 5) {
                                        _currentAnswer[5] = '2';
                                      } else if (_currentTest == 6) {
                                        _currentAnswer[6] = '2';
                                      } else if (_currentTest == 7) {
                                        _currentAnswer[7] = '2';
                                      } else if (_currentTest == 8) {
                                        _currentAnswer[8] = '2';
                                      } else if (_currentTest == 9) {
                                        _currentAnswer[9] = '2';
                                      }
                                      setState(() {
                                        if (_currentTest < _test.length - 1) {
                                          _currentTest++;
                                        }
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(129, 41),
                                      backgroundColor: const Color(0xffF6F3EB),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(30),
                                        ),
                                      ),
                                    ),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: AutoSizeText(
                                        minFontSize: 10,
                                        maxFontSize: 14,
                                        _test[_currentTest].anwers[1],
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'c',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {
                                  if (_currentTest == 0) {
                                    _currentAnswer[0] = '3';
                                  } else if (_currentTest == 1) {
                                    _currentAnswer[1] = '3';
                                  } else if (_currentTest == 2) {
                                    _currentAnswer[2] = '3';
                                  } else if (_currentTest == 3) {
                                    _currentAnswer[3] = '3';
                                  } else if (_currentTest == 4) {
                                    _currentAnswer[4] = '3';
                                  } else if (_currentTest == 5) {
                                    _currentAnswer[5] = '3';
                                  } else if (_currentTest == 6) {
                                    _currentAnswer[6] = '3';
                                  } else if (_currentTest == 7) {
                                    _currentAnswer[7] = '3';
                                  } else if (_currentTest == 8) {
                                    _currentAnswer[8] = '3';
                                  } else if (_currentTest == 9) {
                                    _currentAnswer[9] = '3';
                                  }
                                  setState(() {
                                    if (_currentTest < _test.length - 1) {
                                      _currentTest++;
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(129, 41),
                                  backgroundColor: const Color(0xffF6F3EB),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                  ),
                                ),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: AutoSizeText(
                                    minFontSize: 10,
                                    maxFontSize: 14,
                                    _test[_currentTest].anwers.length >= 3
                                        ? _test[_currentTest].anwers[2]
                                        : 'Opción no disponible',
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'd',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {
                                  if (_currentTest == 0) {
                                    _currentAnswer[0] = '4';
                                  } else if (_currentTest == 1) {
                                    _currentAnswer[1] = '4';
                                  } else if (_currentTest == 2) {
                                    _currentAnswer[2] = '4';
                                  } else if (_currentTest == 3) {
                                    _currentAnswer[3] = '4';
                                  } else if (_currentTest == 4) {
                                    _currentAnswer[4] = '4';
                                  } else if (_currentTest == 5) {
                                    _currentAnswer[5] = '4';
                                  } else if (_currentTest == 6) {
                                    _currentAnswer[6] = '4';
                                  } else if (_currentTest == 7) {
                                    _currentAnswer[7] = '4';
                                  } else if (_currentTest == 8) {
                                    _currentAnswer[8] = '4';
                                  } else if (_currentTest == 9) {
                                    _currentAnswer[9] = '4';
                                  }
                                  setState(() {
                                    if (_currentTest < _test.length - 1) {
                                      _currentTest++;
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(129, 41),
                                  backgroundColor: const Color(0xffF6F3EB),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                  ),
                                ),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: AutoSizeText(
                                    minFontSize: 10,
                                    maxFontSize: 14,
                                    _test[_currentTest].anwers.length >= 4
                                        ? _test[_currentTest].anwers[3]
                                        : 'Opción no disponible',
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 42,
                              left: 16,
                              bottom: 41,
                            ),
                            child: ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  if (_currentTest < _test.length - 1) {
                                    _currentTest++;
                                  } else if (_currentTest ==
                                      _test.length - 1) {}
                                });
                                debugPrint(_currentAnswer.toString());
                                if (_currentTest == 9 &&
                                    _currentAnswer[0].isNotEmpty &&
                                    _currentAnswer[1].isNotEmpty &&
                                    _currentAnswer[2].isNotEmpty &&
                                    _currentAnswer[3].isNotEmpty &&
                                    _currentAnswer[4].isNotEmpty &&
                                    _currentAnswer[5].isNotEmpty &&
                                    _currentAnswer[6].isNotEmpty &&
                                    _currentAnswer[7].isNotEmpty &&
                                    _currentAnswer[8].isNotEmpty &&
                                    _currentAnswer[9].isNotEmpty) {
                                  final response = await IsResuelveloService()
                                      .saveResuelveloTestAnswers(
                                    token: widget.user.token.toString(),
                                    userId: widget.user.userId.toString(),
                                    nid: int.parse(widget.content.body.nid),
                                    answers: _currentAnswer,
                                  );
                                  myLongPrint('Respuesta del save:$response');
                                  if (response.response.type == 'success') {
                                    await showDialog<void>(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text(
                                            '¡Gracias por participar!',
                                          ),
                                          content: Text.rich(
                                            TextSpan(
                                              text: 'Tu puntaje es: ',
                                              children: [
                                                TextSpan(
                                                  text: response.body.puntos
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            ButtonMain(
                                              text: 'Aceptar',
                                              onPress: ResuelveloView(
                                                user: widget.user,
                                              ),
                                              routeName: '/solve',
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } else {
                                    debugPrint('error');
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(129, 41),
                                backgroundColor: mainColor,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                              ),
                              child: Text(
                                (_currentTest == 9 &&
                                        _currentAnswer[9].isNotEmpty)
                                    ? 'Guardar'
                                    : 'Siguiente',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
