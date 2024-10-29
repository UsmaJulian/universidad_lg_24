import 'package:flutter/material.dart';
import 'package:universidad_lg_24/Evaluaciones/models/models.dart';
import 'package:universidad_lg_24/constants.dart';

class ItemRespuetas extends StatelessWidget {
  const ItemRespuetas(this.item, this.cont, {super.key});
  final Item item;
  final int cont;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pregunta  $cont',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: mainColor,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            item.pregunta.toString(),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final rs in item.respuesta!)
                  itemRespueta(
                    item: rs,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class itemRespueta extends StatelessWidget {
  const itemRespueta({super.key, this.item});
  final Respuesta? item;
  @override
  Widget build(BuildContext context) {
    if (item!.estado == 0) {
      return Text(
        item!.respuesta.toString(),
        style: const TextStyle(color: Colors.red),
      );
    } else if (item!.estado == 1) {
      return Text(
        item!.respuesta.toString(),
        style: const TextStyle(color: Colors.green),
      );
    } else {
      return Text(
        item!.respuesta.toString(),
      );
    }
  }
}
