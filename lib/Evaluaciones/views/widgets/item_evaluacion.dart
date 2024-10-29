// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:universidad_lg_24/Evaluaciones/models/models.dart';
import 'package:universidad_lg_24/Evaluaciones/views/single_evaluacion_view.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';

class ItemEvaluacion extends StatelessWidget {
  ItemEvaluacion({super.key, this.evaluacion, this.user});
  EvaluacionItem? evaluacion;
  User? user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: evaluacion!.portada!,
            placeholder: (context, url) => const CircularProgressIndicator(
              color: mainColor,
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    ' ${evaluacion!.porcentaje}% Desarrollado',
                    textAlign: TextAlign.left,
                    style: const TextStyle(color: mainColor),
                  ),
                ),
                Text(
                  evaluacion!.title!,
                  style: const TextStyle(fontSize: 18),
                ),
                if (evaluacion!.porcentaje == 0)
                  ButtonMain(
                    text: 'VER EVALUACIÓN',
                    onPress: SingleEvaluacionView(
                      user: user,
                      nid: evaluacion!.nid!,
                    ),
                  )
                else
                  ButtonMain(text: 'REALIZADA'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
