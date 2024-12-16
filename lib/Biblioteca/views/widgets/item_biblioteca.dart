import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:universidad_lg_24/Biblioteca/models/biblioteca_model.dart';
import 'package:universidad_lg_24/Biblioteca/views/single_biblioteca_view.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';

class ItemBiblioteca extends StatelessWidget {
  const ItemBiblioteca({
    super.key,
    this.item,
    this.user,
    this.filter,
    this.categoria,
  });
  final BibliotecaValue? item;
  final User? user;
  final String? filter;
  final String? categoria;
  @override
  Widget build(BuildContext context) {
    if (filter == 'none' && categoria == 'none') {
      return Container(
        // margin: EdgeInsets.only(bottom: 10.0),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        width: double.infinity,
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: item!.uri!,
              placeholder: (context, url) => const CircularProgressIndicator(
                color: mainColor,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Column(
                children: [
                  Text(
                    item!.title.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 15),
                  ButtonMain(
                    text: 'VER MÁS',
                    onPress: SingleBibliotecaView(
                      user: user,
                      data: item,
                    ),
                    routeName: '/library/${item!.title}',
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else if (filter == item!.filtro && categoria == 'none') {
      return Container(
        // margin: EdgeInsets.only(bottom: 10.0),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        width: double.infinity,
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: item!.uri!,
              placeholder: (context, url) => const CircularProgressIndicator(
                color: mainColor,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Column(
                children: [
                  Text(
                    item!.title.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 15),
                  ButtonMain(
                    text: 'VER MÁS',
                    onPress: SingleBibliotecaView(
                      user: user,
                      data: item,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else if (categoria == item!.cate && filter == 'none') {
      return Container(
        // margin: EdgeInsets.only(bottom: 10.0),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        width: double.infinity,
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: item!.uri!,
              placeholder: (context, url) => const CircularProgressIndicator(
                color: mainColor,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Column(
                children: [
                  Text(
                    item!.title.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 15),
                  ButtonMain(
                    text: 'VER MÁS',
                    onPress: SingleBibliotecaView(
                      user: user,
                      data: item,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else if (filter == item!.filtro && categoria == item!.cate) {
      return Container(
        // margin: EdgeInsets.only(bottom: 10.0),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        width: double.infinity,
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: item!.uri!,
              placeholder: (context, url) => const CircularProgressIndicator(
                color: mainColor,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Column(
                children: [
                  Text(
                    item!.title.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 15),
                  ButtonMain(
                    text: 'VER MÁS',
                    onPress: SingleBibliotecaView(
                      user: user,
                      data: item,
                    ),
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
