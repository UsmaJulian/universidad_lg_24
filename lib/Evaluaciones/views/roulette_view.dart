import 'dart:developer';
import 'dart:math' as math;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roulette/roulette.dart';
import 'package:universidad_lg_24/Evaluaciones/bloc/ruleta_bloc/ruleta_bloc.dart';
import 'package:universidad_lg_24/Evaluaciones/services/ruleta_services.dart';
import 'package:universidad_lg_24/Evaluaciones/views/widgets/Arrow.dart';
import 'package:universidad_lg_24/Resuelvelo/views/resuelvelo_view.dart';

import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/widgets/global/bottom_app_bar_global.dart';
import 'package:universidad_lg_24/widgets/global/header_global.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';

class RouletteView extends StatefulWidget {
  const RouletteView({
    required this.user,
    required this.nid,
    required this.trivia,
    super.key,
  });
  final User? user;
  final int nid;
  final String trivia;
  @override
  State<RouletteView> createState() => _RouletteViewState();
}

class _RouletteViewState extends State<RouletteView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static final _random = math.Random();

  final _controller = RouletteController();
  bool canSpin = true;
  // RouletteController? controllerRandom;

  // Future<void> _controllerRandom(
  //   RouletteController controller,
  // ) async {
  //   final offset = _random.nextDouble();
  //   await controller.rollTo(2, offset: offset);
  //   setState(() {
  //     controllerRandom = controller;
  //   });
  // }
  // final prizes = [
  //   'Vale de entretenimiento',
  //   'Cena familiar',
  //   'Vale de entretenimiento',
  //   'Vale de consumo',
  //   'Vale de entretenimiento',
  // ];

  // final colors = <Color>[
  //   const Color(0xFFFD312E),
  //   const Color(0xFFA50034),
  //   const Color(0xFFF0ECE4),
  //   const Color(0xFFFFFFFF),
  //   const Color(0xFF000000),
  // ];

  // late final group = RouletteGroup.uniform(
  //   prizes.length,
  //   colorBuilder: (index) => colors[index],
  //   textBuilder: (index) {
  //     switch (index) {
  //       case 0:
  //         return prizes[0];
  //       case 1:
  //         return prizes[1];
  //       case 2:
  //         return prizes[2];
  //       case 3:
  //         return prizes[3];
  //       case 4:
  //         return prizes[4];
  //       default:
  //         return '';
  //     }
  //   },
  //   textStyleBuilder: (index) {
  //     switch (index) {
  //       case 0:
  //       case 1:
  //       case 4:
  //         return const TextStyle(
  //           fontSize: 20,
  //           color: Colors.white,
  //           fontWeight: FontWeight.bold,
  //         );
  //       case 2:
  //       case 3:
  //         return const TextStyle(
  //           fontSize: 20,
  //           color: Colors.black,
  //           fontWeight: FontWeight.bold,
  //         );
  //     }
  //     return null;
  //   },
  // );

  @override
  void initState() {
    super.initState();
    getRuletaContent();
  }

  Future<void> getRuletaContent() async {
    final userId = widget.user!.userId!;
    final token = widget.user!.token!;
    context
        .read<RuletaBloc>()
        .add(GetRuletaEvent(userId: userId, token: token));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: const Color(0xffF6F3EB),
      appBar: CustomAppBar(user: widget.user),
      endDrawer: DrawerMenu(
        user: widget.user,
        isHome: true,
      ),
      body: BlocBuilder<RuletaBloc, RuletaState>(
        builder: (context, state) {
          log('RuletaBloc state: $state');
          if (state is RuletaInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ErrorRuleta) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (state is RuletaSuccess) {
            final response = state.data;
            log('Ruleta data: ${response.body!.listado}');
            final prizes = response.body!.listado!
                .map((item) => item.name ?? 'Sin premio')
                .toList();

            final colors = response.body!.listado!
                .map((item) => Color(int.parse('0xFF${item.color}')))
                .toList();

            final prizeIds =
                response.body!.listado!.map((item) => item.tid ?? '').toList();

            late final group = RouletteGroup.uniform(
              prizes.length,
              colorBuilder: (index) => colors[index],
              textBuilder: (index) {
                switch (index) {
                  case 0:
                    return prizes[index];
                  case 1:
                    return prizes[index];
                  case 2:
                    return prizes[index];
                  case 3:
                    return prizes[index];
                  case 4:
                    return prizes[index];
                  case 5:
                    return prizes[index];
                  case 6:
                    return prizes[index];
                  default:
                    return '';
                }
              },
              textStyleBuilder: (index) {
                switch (index) {
                  case 0:
                  case 1:
                  case 2:
                  case 3:
                  case 4:
                  case 5:
                  case 6:
                    return const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    );
                }
                return null;
              },
            );

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.17,
                  bottom: MediaQuery.of(context).size.height * 0.2,
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/png/LOGO_FINAL_PREM.png',
                      width: 180,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.05,
                        vertical: MediaQuery.of(context).size.height * 0.02,
                      ),
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Center(
                            child: Roulette(
                              controller: _controller,
                              group: group,
                              style: const RouletteStyle(
                                centerStickSizePercent: 0.05,
                                centerStickerColor: Colors.red,
                                dividerThickness: 0,
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const Arrow(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFD312E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 15,
                          ),
                        ),
                        onPressed: canSpin
                            ? () async {
                                setState(() {
                                  canSpin = false;
                                });
                                final prizeIndex =
                                    _random.nextInt(group.units.length);
                                final offset = _random.nextDouble() * 0.7;

                                _controller.resetAnimation();
                                await _controller.rollTo(
                                  prizeIndex,
                                  offset: offset,
                                );

                                final prizeText = group.units[prizeIndex].text;
                                final tid = prizeIds[prizeIndex];

                                if (context.mounted) {
                                  await showDialog<void>(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          '¡Felicidades ${widget.user?.name ?? ''}!',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 2,
                                        ),
                                        content: Text.rich(
                                          textAlign: TextAlign.center,
                                          TextSpan(
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                            children: [
                                              const TextSpan(
                                                text: 'Has ganado: ',
                                              ),
                                              TextSpan(
                                                text: prizeText!.toUpperCase(),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(
                                                    0xFFFD312E,
                                                  ), // Rojo LG
                                                ),
                                              ),
                                              const TextSpan(
                                                text:
                                                    '.\n\nContacta con el administrador para canjear tu premio.',
                                              ),
                                            ],
                                          ),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () async {
                                              log('Saving prize: $tid, $prizeText');
                                              final saveResponse =
                                                  await RuletaServices()
                                                      .saveRuletaContent(
                                                widget.user!.userId!,
                                                widget.user!.token!,
                                                int.parse(tid),
                                                prizeText,
                                                widget.nid,
                                                widget.trivia,
                                              );
                                              if (saveResponse.response!.type ==
                                                  'success') {
                                                await Navigator.of(context)
                                                    .pushReplacement(
                                                  MaterialPageRoute<void>(
                                                    builder: (context) =>
                                                        ResuelveloView(
                                                      user: widget.user!,
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                ///Mostrar mensaje de error en el bottom
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Error al guardar el premio: ${saveResponse.response!.message}',
                                                      style: const TextStyle(
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                    duration: const Duration(
                                                      seconds: 3,
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                            child: const Text(
                                              'Aceptar',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Color(0xFFFD312E),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              }
                            : null,
                        child: const AutoSizeText(
                          'Girar',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: Text(
              'No se pudo cargar la ruleta',
              style: TextStyle(color: Colors.red),
            ),
          );
        },
      ),
      bottomNavigationBar: const CustomBottomAppBar(),
    );
  }
}
