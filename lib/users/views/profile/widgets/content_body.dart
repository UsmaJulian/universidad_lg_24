import 'package:flutter/material.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/users/views/profile/widgets/widgets.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';

class ContentBody extends StatelessWidget {
  const ContentBody({
    super.key,
    this.user,
    this.totalpuntos,
    this.oro,
    this.plata,
    this.bronce,
  });
  final User? user;
  final int? totalpuntos;
  final int? oro;
  final int? plata;
  final int? bronce;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'DETALLES DE PERFIL',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            user!.name.toString(),
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            user!.email.toString(),
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            'Puntos: $totalpuntos',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Column(
                children: [
                  const Icon(
                    Icons.emoji_events,
                    color: Color(0xFFfbeb39),
                    size: 50,
                  ),
                  Text(
                    oro.toString(),
                  ),
                ],
              ),
              Column(
                children: [
                  const Icon(
                    Icons.emoji_events,
                    color: Color(0xFFe4e4e4),
                    size: 50,
                  ),
                  Text(
                    plata.toString(),
                  ),
                ],
              ),
              Column(
                children: [
                  const Icon(
                    Icons.emoji_events,
                    color: Color(0xFFf8ac2f),
                    size: 50,
                  ),
                  Text(
                    bronce.toString(),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ButtonMain(
            text: 'RANKING',
            // onpress: StreamingSinglePage(
            //   user: user,
            //   nid: item.nid,
            // ),
          ),
          const SizedBox(
            height: 40,
          ),
          FormPerfil(user: user),
        ],
      ),
    );
  }
}
