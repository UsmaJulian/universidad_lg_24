// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:universidad_lg_24/Evaluaciones/models/models.dart';
import 'package:universidad_lg_24/Evaluaciones/views/widgets/item_evaluacion.dart';
import 'package:universidad_lg_24/users/models/models.dart';

class ContentEvaluacion extends StatefulWidget {
  ContentEvaluacion({super.key, this.evaluacionInfo, this.user});
  List<EvaluacionItem>? evaluacionInfo;
  User? user;

  @override
  _ContentEvaluacionState createState() => _ContentEvaluacionState();
}

class _ContentEvaluacionState extends State<ContentEvaluacion> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final item in widget.evaluacionInfo!)
          ItemEvaluacion(
            evaluacion: item,
            user: widget.user,
          ),
      ],
    );
  }
}
