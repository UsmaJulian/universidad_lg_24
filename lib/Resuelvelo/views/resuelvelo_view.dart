import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:universidad_lg_24/constants.dart';

import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/widgets/global/body_footer_global.dart';
import 'package:universidad_lg_24/widgets/global/bottom_app_bar_global.dart';
import 'package:universidad_lg_24/widgets/global/header_global.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';

class ResuelveloView extends StatefulWidget {
  const ResuelveloView({required this.user, super.key});
  final User user;
  @override
  State<ResuelveloView> createState() => _ResuelveloViewState();
}

class _ResuelveloViewState extends State<ResuelveloView> {
  
  final reels = [
    {
      'resource': '',
      'thumbnail': 'assets/static/portada-dos.png',
      'title': 'Próximamente',
      'type': 'imagen',
    },
    {
      'resource': '',
      'thumbnail': 'assets/static/portada-tres.png',
      'title': 'Próximamente',
      'type': 'imagen',
    },
    {
      'resource': '',
      'thumbnail': 'assets/static/portada-dos.png',
      'title': 'Próximamente',
      'type': 'imagen',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: CustomAppBar(),
      endDrawer: DrawerMenu(
        user: widget.user,
        isHome: true, // Indica que el DrawerMenuLeft se está utilizando
        // en la pantalla de inicio.
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 117),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/static/banner-resuelvelo-opt.png'),
              const Padding(
                padding: EdgeInsets.only(top: 0, left: 20, right: 20),
                child: Text('Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna.',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                height: 250,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (final reel in reels)
                    Stack(
                      children: [
                        Container(
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.asset(
                                    reel['thumbnail'].toString(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 15,
                          child: ButtonMain(
                            bgColor: mainColor,
                            text: 'Próximamente',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const BodyFooter(),
            ],
          ),
        ),
      ),
      
    );
  }

}
