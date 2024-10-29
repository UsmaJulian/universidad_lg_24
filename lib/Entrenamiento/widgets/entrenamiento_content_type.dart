import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:universidad_lg_24/Entrenamiento/models/models.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';

class EntrenamientoContentType extends StatelessWidget {
  const EntrenamientoContentType({
    super.key,
    this.data,
    this.filtro,
    this.user,
    this.searchTerm,
  });
  final Map<String, TipoCurso>? data;
  final int? filtro;
  final User? user;
  final String? searchTerm;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: Future.value(data!.values),
              builder: (
                BuildContext context,
                AsyncSnapshot<Iterable<TipoCurso>> snapshot,
              ) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      for (final curso in snapshot.data!)
                        if (curso.title!
                            .toLowerCase()
                            .contains(searchTerm!.toLowerCase()))
                          _ItemCurso(
                            curso: curso,
                            filtro: filtro,
                            user: user,
                          ),
                    ],
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemCurso extends StatelessWidget {
  const _ItemCurso({this.curso, this.filtro, this.user});
  final TipoCurso? curso;
  final int? filtro;
  final User? user;

  @override
  Widget build(BuildContext context) {
    if (filtro == 0) {
      return Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: curso!.portada!,
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
                      ' ${curso!.porcentaje}% Desarrollado',
                      textAlign: TextAlign.left,
                      style: const TextStyle(color: mainColor),
                    ),
                  ),
                  Text(
                    curso!.title!,
                    style: const TextStyle(fontSize: 18),
                  ),
                  ButtonMain(
                    text: 'VER CURSO',
                    /*  onPress: CursoPreviewPage(
                      user: user,
                      nid: curso!.nid,
                    ), */
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else if (filtro == int.parse(curso!.categoria!)) {
      return Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: curso!.portada!,
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
                      ' ${curso!.porcentaje}% Desarrollado',
                      textAlign: TextAlign.left,
                      style: const TextStyle(color: mainColor),
                    ),
                  ),
                  Text(
                    curso!.title!,
                    style: const TextStyle(fontSize: 18),
                  ),
                  ButtonMain(
                    text: 'VER CURSO',
                    /*  onPress: CursoPreviewPage(
                      user: user,
                      nid: curso!.nid,
                    ), */
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
