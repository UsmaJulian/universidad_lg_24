import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/home/models/models.dart';
import 'package:universidad_lg_24/users/models/models.dart';

class NoticiasHome extends StatefulWidget {
  NoticiasHome(this.dataNoticias, this.user, {super.key});
  final User? user;
  List<Noticias>? dataNoticias;

  @override
  _NoticiasHome createState() => _NoticiasHome();
}

class _NoticiasHome extends State<NoticiasHome> {
  CarouselController buttonCarouselController = CarouselController();
  final int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: const Text(
            'NOTICIAS',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
          ),
        ),
        Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 340,
                viewportFraction: 1,
                aspectRatio: 2,
              ),
              carouselController: buttonCarouselController,
              items: widget.dataNoticias!.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return InkWell(
                      onTap: () {
                        /* Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NoticiaSinglePage(
                              user: widget.user,
                              nid: i.nid,
                            ),
                          ),
                        ); */
                      },
                      child: Column(
                        children: [
                          CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: i.imagen.toString(),
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(
                                color: mainColor,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              top: 10,
                              left: 20,
                              right: 20,
                            ),
                            child: Text(
                              i.title.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                height: 1,
                              ),
                              maxLines: 3,
                            ),
                          ),
                          Container(
                            child: Text(
                              i.lead.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                          // Text(i.title),
                        ],
                        // Text(i.title),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: () => buttonCarouselController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linear,
                  ),
                  child: const Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      Text(
                        'ANTERIOR',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: () => buttonCarouselController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linear,
                  ),
                  child: const Column(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                      ),
                      Text(
                        'SIGUIENTE',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
