import 'package:flutter/material.dart';
import 'package:universidad_lg_24/Juegos/models/juegos_content_model.dart';
import 'package:universidad_lg_24/Juegos/services/juegos_services.dart';

import 'package:universidad_lg_24/Juegos/views/juegos_view.dart';

import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/helpers/my_long_print.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/widgets/global/bottom_app_bar_global.dart';
import 'package:universidad_lg_24/widgets/global/header_global.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';

class TriviaView extends StatefulWidget {
  const TriviaView({required this.user, required this.content, super.key});
  final User user;
  final JuegosContent content;
  @override
  State<TriviaView> createState() => _TriviaViewState();
}

class _TriviaViewState extends State<TriviaView> {
  int _currentTrivia = 0;
  final List<String> _currentAnswer = ['', '', '', '', ''];
  final _trivias = <dynamic>[
    // {
    //   'question':
    //       '¿Cuánto es el ahorro de energía del Compresor linear Inverter en refrigeradoras?',
    //   'anwers': [
    //     '31%',
    //     '32%',
    //     '36%',
    //     'N.A',
    //   ],
    // },
    // {
    //   'question':
    //       '¿Cuánto es el porcentaje de ahorro de energía del compresor Smart Inverter en refrigeradoras?',
    //   'anwers': [
    //     '36%',
    //     '37%',
    //     '32%',
    //     'N.A',
    //   ],
    // },
    // {
    //   'question':
    //       '¿Cuánto es el porcentaje de ahorro en las lavadoras Smart Inverter?',
    //   'anwers': [
    //     '36%',
    //     '37%',
    //     '32%',
    //     'N.A',
    //   ],
    // },
    // {
    //   'question':
    //       '¿Cuánto es La capacidad de horno de nuestras cocinas Lupin 2?',
    //   'anwers': [
    //     '165 Litros',
    //     '164 Litros',
    //     '153 Litros',
    //     'N.A',
    //   ],
    // },
    // {
    //   'question': '¿Cuáles son las capacidades de nuestros hornos Neochef?',
    //   'anwers': [
    //     '26 y 43 Litros',
    //     '30 y 44 Litros',
    //     '25 y 42 Litros',
    //     'N.A',
    //   ],
    // },
  ];
  @override
  void initState() {
    _trivias.addAll(widget.content.body!.trivia!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Current: $_currentTrivia');
    return Scaffold(
      backgroundColor: const Color(0xffF6F3EB),
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: CustomAppBar(),
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
                        return JuegosView(user: widget.user);
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
              const Text(
                'Trivia',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Row(
              //   children: [
              //     for (var i = 0; i < _trivias.length; i++)
              //       GestureDetector(
              //         child: Container(
              //           width: 41,
              //           height: 41,
              //           margin: const EdgeInsets.only(right: 10),
              //           decoration: BoxDecoration(
              //             color: (_currentTrivia == i)
              //                 ? const Color(0xffCBC8C2)
              //                 : Colors.white,
              //             borderRadius: BorderRadius.circular(30),
              //           ),
              //           child: Center(
              //             child: Text(
              //               '${i + 1}',
              //               style: const TextStyle(
              //                 color: Colors.black,
              //                 fontSize: 20,
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             ),
              //           ),
              //         ),
              //         onTap: () {
              //           setState(() {
              //             _currentTrivia = i;
              //           });
              //         },
              //       ),
              //   ],
              // ),
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
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: Text(
                        '${_currentTrivia + 1}/${_trivias.length}',
                        style: const TextStyle(
                          color: Color(0xffAAA8A5),
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 6, left: 38, right: 38),
                      child: Text(
                        _trivias[_currentTrivia].question.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
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
                              const Text(
                                'a',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {
                                  if (_currentTrivia == 0) {
                                    _currentAnswer[0] = '0';
                                  } else if (_currentTrivia == 1) {
                                    _currentAnswer[1] = '0';
                                  } else if (_currentTrivia == 2) {
                                    _currentAnswer[2] = '0';
                                  } else if (_currentTrivia == 3) {
                                    _currentAnswer[3] = '0';
                                  } else if (_currentTrivia == 4) {
                                    _currentAnswer[4] = '0';
                                  }
                                  setState(() {
                                    if (_currentTrivia < _trivias.length - 1) {
                                      _currentTrivia++;
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
                                child: Text(
                                  _trivias[_currentTrivia].anwers[0].toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
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
                                      setState(() {
                                        if (_currentTrivia <
                                            _trivias.length - 1) {
                                          _currentTrivia++;
                                        }
                                      });
                                      if (_currentTrivia == 0) {
                                        _currentAnswer[0] = '1';
                                      } else if (_currentTrivia == 1) {
                                        _currentAnswer[1] = '1';
                                      } else if (_currentTrivia == 2) {
                                        _currentAnswer[2] = '1';
                                      } else if (_currentTrivia == 3) {
                                        _currentAnswer[3] = '1';
                                      } else if (_currentTrivia == 4) {
                                        _currentAnswer[4] = '1';
                                      }
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
                                    child: Text(
                                      _trivias[_currentTrivia]
                                          .anwers[1]
                                          .toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
                                  setState(() {
                                    if (_currentTrivia < _trivias.length - 1) {
                                      _currentTrivia++;
                                    }
                                  });
                                  if (_currentTrivia == 0) {
                                    _currentAnswer[0] = '2';
                                  } else if (_currentTrivia == 1) {
                                    _currentAnswer[1] = '2';
                                  } else if (_currentTrivia == 2) {
                                    _currentAnswer[2] = '2';
                                  } else if (_currentTrivia == 3) {
                                    _currentAnswer[3] = '2';
                                  } else if (_currentTrivia == 4) {
                                    _currentAnswer[4] = '2';
                                  }
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
                                child: Text(
                                  _trivias[_currentTrivia].anwers[2].toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
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
                                  setState(() {
                                    if (_currentTrivia < _trivias.length - 1) {
                                      _currentTrivia++;
                                    }
                                  });
                                  if (_currentTrivia == 0) {
                                    _currentAnswer[0] = '3';
                                  } else if (_currentTrivia == 1) {
                                    _currentAnswer[1] = '3';
                                  } else if (_currentTrivia == 2) {
                                    _currentAnswer[2] = '3';
                                  } else if (_currentTrivia == 3) {
                                    _currentAnswer[3] = '3';
                                  } else if (_currentTrivia == 4) {
                                    _currentAnswer[4] = '3';
                                  }
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
                                child: Text(
                                  _trivias[_currentTrivia].anwers[3].toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
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
                                  if (_currentTrivia < _trivias.length - 1) {
                                    _currentTrivia++;
                                  } else if (_currentTrivia ==
                                      _trivias.length - 1) {}
                                });
                                if (_currentTrivia == 4) {
                                  debugPrint(_currentAnswer.toString());

                                  final response = await IsJuegosServices()
                                      .saveJuegosAnswers(
                                    user: widget.user.userId,
                                    token: widget.user.token,
                                    nid: int.parse(
                                      widget.content.body!.nid.toString(),
                                    ),
                                    answers: _currentAnswer,
                                  );
                                  myLongPrint('Respuesta del save:$response');
                                  if (response.response!.type == 'success') {
                                    await showDialog<void>(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text(
                                            '¡Gracias por participar!',
                                          ),
                                          content: const Text(
                                            'Has completado la trivia',
                                          ),
                                          actions: [
                                            ButtonMain(
                                              text: 'Aceptar',
                                              onPress: JuegosView(
                                                user: widget.user,
                                              ),
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
                                (_currentTrivia == 4) ? 'Guardar' : 'Siguiente',
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
