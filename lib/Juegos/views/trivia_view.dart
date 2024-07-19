import 'package:flutter/material.dart';
import 'package:universidad_lg_24/Juegos/views/juegos_view.dart';

import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/widgets/global/bottom_app_bar_global.dart';
import 'package:universidad_lg_24/widgets/global/header_global.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';

class TriviaView extends StatefulWidget {
  const TriviaView({required this.user, super.key});
  final User user;
  @override
  State<TriviaView> createState() => _TriviaViewState();
}

class _TriviaViewState extends State<TriviaView> {
  int _currentTrivia = 0;
  final List<Map<String, dynamic>> _trivias = [
    {
      'pregunta':
          '¿Cuánto es el ahorro de energía del Compresor linear Inverter en refrigeradoras?',
      'respuestas': [
        '31%',
        '32%',
        '36%',
        'N.A',
      ],
    },
    {
      'pregunta':
          '¿Cuánto es el porcentaje de ahorro de energía del compresor Smart Inverter en refrigeradoras?',
      'respuestas': [
        '36%',
        '37%',
        '32%',
        'N.A',
      ],
    },
    {
      'pregunta':
          '¿Cuánto es el porcentaje de ahorro en las lavadoras Smart Inverter?',
      'respuestas': [
        '36%',
        '37%',
        '32%',
        'N.A',
      ],
    },
    {
      'pregunta':
          '¿Cuánto es La capacidad de horno de nuestras cocinas Lupin 2?',
      'respuestas': [
        '165 Litros',
        '164 Litros',
        '153 Litros',
        'N.A',
      ],
    },
    {
      'pregunta': '¿Cuáles son las capacidades de nuestros hornos Neochef?',
      'respuestas': [
        '26 y 43 Litros',
        '30 y 44 Litros',
        '25 y 42 Litros',
        'N.A',
      ],
    },
  ];
  @override
  Widget build(BuildContext context) {
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
              Row(
                children: [
                  for (var i = 0; i < _trivias.length; i++)
                    GestureDetector(
                      child: Container(
                        width: 41,
                        height: 41,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: (_currentTrivia == i)
                              ? const Color(0xffCBC8C2)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            '${i + 1}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _currentTrivia = i;
                        });
                      },
                    ),
                ],
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
                        _trivias[_currentTrivia]['pregunta'].toString(),
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
                                  setState(() {
                                    if (_currentTrivia < _trivias.length - 1) {
                                      _currentTrivia++;
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
                                child: Text(
                                  _trivias[_currentTrivia]['respuestas'][0]
                                      .toString(),
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
                                      _trivias[_currentTrivia]['respuestas'][1]
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
                                  _trivias[_currentTrivia]['respuestas'][2]
                                      .toString(),
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
                                  _trivias[_currentTrivia]['respuestas'][3]
                                      .toString(),
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
                              onPressed: () {
                                setState(() {
                                  if (_currentTrivia < _trivias.length - 1) {
                                    _currentTrivia++;
                                  } else if (_currentTrivia ==
                                      _trivias.length - 1) {
                                    showDialog<void>(
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
                                  }
                                });
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
                              child: const Text(
                                'Siguiente',
                                style: TextStyle(
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
