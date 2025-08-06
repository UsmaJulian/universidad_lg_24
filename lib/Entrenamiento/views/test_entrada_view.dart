import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:universidad_lg_24/Entrenamiento/entrenamiento/entrenamiento_bloc.dart';
import 'package:universidad_lg_24/Entrenamiento/models/test_entrada_model.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/widgets/global/header_global.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';

class TestEntradaView extends StatefulWidget {
  const TestEntradaView({
    required this.user,
    required this.curso,
    required this.leccion,
    super.key,
    this.parent,
  });
  final String? parent;
  final User user;
  final String curso;
  final String leccion;

  @override
  State<TestEntradaView> createState() => _TestEntradaViewState();
}

class _TestEntradaViewState extends State<TestEntradaView> {
  final EntrenamientoBloc _entrenamientoBloc = EntrenamientoBloc();
  int _currentTest = 0;
  final List<String> _currentAnswer = List.filled(10, '');
  List<Pregunta> _preguntas = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTestData();
  }

  Future<void> _loadTestData() async {
    try {
      final testData = await _entrenamientoBloc.getTestEntradaContent(
        token: widget.user.token,
        uid: widget.user.userId,
        curso: widget.curso,
        leccion: widget.leccion,
      );

      if (mounted) {
        setState(() {
          _preguntas = testData?.status?.preguntas?.cast<Pregunta>() ?? [];
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al cargar el test')),
        );
      }
    }
  }

  void _onAnswerSelected(int answerIndex) {
    if (_preguntas.isEmpty || _currentTest >= _preguntas.length) return;

    setState(() {
      _currentAnswer[_currentTest] = (answerIndex + 1).toString();
    });
  }

  void _onNextOrSubmit() {
    if (_preguntas.isEmpty) return;

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
      final response = await _entrenamientoBloc.sendTestEntrada(
        data: Map.fromEntries(
          _currentAnswer
              .asMap()
              .entries
              .where((entry) => entry.value.isNotEmpty)
              .map((entry) => MapEntry(entry.key.toString(), entry.value)),
        ),
        uid: widget.user.userId,
        token: widget.user.token,
        curso: widget.curso,
        leccion: widget.leccion,
      );

      if (mounted) {
        _showResultDialog(response);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al enviar el test')),
        );
      }
    }
  }

  void _showResultDialog(dynamic response) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Resultado del Test'),
        content:
            Text(response?.status?.message.toString() ?? 'Test completado'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Go back to previous screen
            },
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
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
                              'Test de entrada',
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

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          letter,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () => _onAnswerSelected(index),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(129, 41),
            backgroundColor: const Color(0xffF6F3EB),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: AutoSizeText(
              respuesta.texto ?? 'Opción no disponible',
              minFontSize: 10,
              maxFontSize: 14,
              style: const TextStyle(color: Colors.black),
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: ElevatedButton(
        onPressed:
            _currentAnswer[_currentTest].isNotEmpty ? _onNextOrSubmit : null,
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
