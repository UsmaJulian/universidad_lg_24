// ignore_for_file: strict_raw_type, must_be_immutable, inference_failure_on_function_return_type

import 'package:flutter/material.dart';
import 'package:universidad_lg_24/Entrenamiento/entrenamiento/entrenamiento_bloc.dart';
import 'package:universidad_lg_24/Entrenamiento/models/test_salida_model.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/widgets/global/header_global.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';

class TestSalidaView extends StatefulWidget {
  const TestSalidaView({
    required this.user,
    required this.curso,
    required this.leccion,
    super.key,
  });
  final User user;
  final String curso;
  final String leccion;

  @override
  State<TestSalidaView> createState() => _TestSalidaViewState();
}

class _TestSalidaViewState extends State<TestSalidaView> {
  final EntrenamientoBloc _entrenamientoBloc = EntrenamientoBloc();
  int _currentTest = 0;
  final List<int?> _selectedAnswers = List.filled(10, null);
  List<StatusPregunta> _preguntas = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTestData();
  }

  Future<void> _loadTestData() async {
    try {
      final testData = await _entrenamientoBloc.getTestSalidaContent(
        token: widget.user.token,
        uid: widget.user.userId,
        curso: widget.curso,
        leccion: widget.leccion,
      );

      if (mounted) {
        setState(() {
          _preguntas =
              testData?.status?.preguntas?.cast<StatusPregunta>() ?? [];
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al cargar el test')),
      );
    }
  }

  void _onAnswerSelected(int answerIndex) {
    if (_preguntas.isEmpty || _currentTest >= _preguntas.length) return;

    setState(() {
      _selectedAnswers[_currentTest] = answerIndex;
    });
  }

  void _onNextOrSubmit() {
    if (_preguntas.isEmpty || _currentTest >= _preguntas.length) return;

    if (_currentTest < _preguntas.length - 1) {
      setState(() {
        _currentTest++;
      });
    } else {
      _submitTest();
    }
  }

  Future<void> _submitTest() async {
    if (_preguntas.isEmpty) return;

    try {
      final response = await _entrenamientoBloc.sendTestSalida(
        data: Map.fromEntries(
          _selectedAnswers
              .asMap()
              .entries
              .where((entry) => entry.value != null)
              .map(
                (entry) => MapEntry(
                  _preguntas[entry.key].id ?? entry.key.toString(),
                  (entry.value! + 1).toString(),
                ),
              ),
        ),
        uid: widget.user.userId,
        token: widget.user.token,
        curso: widget.curso,
        leccion: widget.leccion,
      );

      if (mounted) {
        await showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                response?.status?.message ?? 'Test completado',
                style: const TextStyle(color: mainColor),
              ),
              content: const Text('¡Has completado el test de salida!'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Aceptar'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al enviar el test')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F3EB),
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: CustomAppBar(user: widget.user),
      endDrawer: DrawerMenu(
        user: widget.user,
        isHome: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _preguntas.isEmpty
              ? const Center(child: Text('No hay preguntas disponibles'))
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 166,
                      left: 15,
                      right: 15,
                      bottom: 121,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(129, 41),
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              side: BorderSide(),
                            ),
                          ),
                          child: const Text(
                            'Volver',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Row(
                          children: [
                            Text(
                              'Test de salida',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
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
                            children: _buildTestContent(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }

  List<Widget> _buildTestContent() {
    if (_preguntas.isEmpty || _currentTest >= _preguntas.length) {
      return [
        const Padding(
          padding: EdgeInsets.only(top: 32, bottom: 32),
          child: Text('No hay preguntas disponibles'),
        ),
      ];
    }

    final pregunta = _preguntas[_currentTest];
    final respuestas = pregunta.respuestas?.cast<Respuesta>() ?? [];

    return [
      Padding(
        padding: const EdgeInsets.only(top: 32),
        child: AutoSizeText(
          '${_currentTest + 1}/${_preguntas.length}',
          minFontSize: 41,
          maxFontSize: 45,
          style: const TextStyle(
            color: Color(0xffAAA8A5),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 6, left: 10, right: 10),
        child: AutoSizeText(
          pregunta.texto ?? 'Pregunta sin texto',
          minFontSize: 10,
          maxFontSize: 14,
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
      _buildAnswerOptions(respuestas),
      const SizedBox(height: 20),
      _buildNavigationButton(),
      const SizedBox(height: 20),
    ];
  }

  Widget _buildAnswerOptions(List<Respuesta> respuestas) {
    if (respuestas.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        _buildAnswerOption('a', 0, respuestas),
        const SizedBox(height: 10),
        _buildAnswerOption('b', 1, respuestas),
        const SizedBox(height: 10),
        _buildAnswerOption('c', 2, respuestas),
        const SizedBox(height: 10),
        _buildAnswerOption('d', 3, respuestas),
      ],
    );
  }

  Widget _buildAnswerOption(
    String letter,
    int index,
    List<Respuesta> respuestas,
  ) {
    if (index >= respuestas.length) {
      return const SizedBox.shrink();
    }

    final respuesta = respuestas[index];
    final isSelected = _selectedAnswers[_currentTest] == index;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          letter,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () => _onAnswerSelected(index),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(129, 41),
            backgroundColor: isSelected ? mainColor : const Color(0xffF6F3EB),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: isSelected
                  ? const BorderSide(color: Colors.transparent)
                  : const BorderSide(color: Colors.grey),
            ),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: AutoSizeText(
              respuesta.texto ?? 'Opción no disponible',
              minFontSize: 10,
              maxFontSize: 14,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationButton() {
    if (_preguntas.isEmpty || _currentTest >= _preguntas.length) {
      return const SizedBox.shrink();
    }

    final hasAnswer = _selectedAnswers[_currentTest] != null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: ElevatedButton(
        onPressed: hasAnswer ? _onNextOrSubmit : null,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(129, 41),
          backgroundColor: mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          _currentTest == _preguntas.length - 1 ? 'Guardar' : 'Siguiente',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _entrenamientoBloc.close();
    super.dispose();
  }
}
