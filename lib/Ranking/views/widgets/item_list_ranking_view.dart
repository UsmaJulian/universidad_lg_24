import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:universidad_lg_24/Ranking/models/ranking_model.dart';
import 'package:universidad_lg_24/constants.dart';

class ItemListRankingView extends StatelessWidget {
  const ItemListRankingView({super.key, this.item});
  final Datum? item;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10),
            width: MediaQuery.of(context).size.width / 2,
            child: Row(
              children: [
                ClipOval(
                  child: CachedNetworkImage(
                    width: 50,
                    height: 50,
                    imageUrl: item!.uri.toString(),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(
                      color: mainColor,
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      item!.nombre.toString(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 50,
                  alignment: Alignment.center,
                  child: Text(item!.oro.toString()),
                ),
                Container(
                  width: 50,
                  alignment: Alignment.center,
                  child: Text(item!.plata.toString()),
                ),
                Container(
                  width: 50,
                  alignment: Alignment.center,
                  child: Text(item!.bronce.toString()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
