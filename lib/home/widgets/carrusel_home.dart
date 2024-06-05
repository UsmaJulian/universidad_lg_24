import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/home/models/models.dart';

class CarrucelHome extends StatefulWidget {
  CarrucelHome(this.dataCarrucel, {super.key});

  List<Carrucel>? dataCarrucel;

  @override
  _CarrucelHomeState createState() => _CarrucelHomeState();
}

class _CarrucelHomeState extends State<CarrucelHome> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 200,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          items: widget.dataCarrucel!.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return CachedNetworkImage(
                  alignment: Alignment.topCenter,
                  imageUrl: i.imagen.toString(),
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(
                      color: mainColor,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                );
              },
            );
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.dataCarrucel!.map((url) {
            final index = widget.dataCarrucel!.indexOf(url);
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
              decoration: BoxDecoration(
                border: const Border.fromBorderSide(
                  BorderSide(color: mainColor),
                ),
                shape: BoxShape.circle,
                color: _current == index ? mainColor : Colors.white,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
