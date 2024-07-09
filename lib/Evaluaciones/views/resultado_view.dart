import 'package:flutter/material.dart';
import 'package:universidad_lg_24/Evaluaciones/views/widgets/content_data.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/users/models/models.dart';

class ResultadoView extends StatelessWidget {
  const ResultadoView({super.key, this.user, this.evaluacion});
  final User? user;
  final String? evaluacion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PREGUNTAS Y RESPUETAS',
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: mainColor,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: ContentData(
          user: user,
          evaluacion: evaluacion,
        ),
      ),
    );
  }
}
