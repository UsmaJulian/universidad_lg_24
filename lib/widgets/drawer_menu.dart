import 'package:flutter/material.dart';
import 'package:universidad_lg_24/Ayuda/views/ayuda_view.dart';
import 'package:universidad_lg_24/Biblioteca/views/biblioteca_view.dart';
import 'package:universidad_lg_24/Calendario/views/calendario_view.dart';
import 'package:universidad_lg_24/Entrenamiento/views/entrenamiento_view.dart';
import 'package:universidad_lg_24/Evaluaciones/views/evaluacion_view.dart';
import 'package:universidad_lg_24/Home/views/new_home_view.dart';
import 'package:universidad_lg_24/Noticias/views/noticias_view.dart';
import 'package:universidad_lg_24/Ranking/views/ranking_view.dart';
import 'package:universidad_lg_24/Resuelvelo/views/resuelvelo_view.dart';
import 'package:universidad_lg_24/constants.dart';

import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/users/views/profile/perfil_view.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    required this.user,
    super.key,
    this.currenPage,
    this.isHome = false,
  });
  final User? user;
  final String? currenPage;
  final bool isHome;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: bgColor,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 140,
            child: DrawerHeader(
              margin: const EdgeInsets.only(bottom: 20),
              decoration: const BoxDecoration(
                color: bgColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          if (!isHome) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute<void>(
                                builder: (_) {
                                  return NewHomeView(
                                    user: user!,
                                  );
                                },
                              ),
                              (route) => false,
                            );
                          }
                        },
                        child: const Image(
                          image: AssetImage('assets/images/Grupo 77.png'),
                          height: 40,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close),
                        iconSize: 35,
                        color: mainColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: const Center(child: Text('Inicio')),
            onTap: () {
              if (currenPage != 'inicio') {
                Navigator.of(context).pop();
                if (isHome) {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) {
                        return NewHomeView(user: user!);
                      },
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) {
                        return NewHomeView(user: user!);
                      },
                    ),
                  );
                }
              }
              return;
            },
          ),
          Divider(
            color: const Color(
              0xff707070,
            ).withOpacity(0.4),
            thickness: 1,
          ),
          ListTile(
            title: const Center(child: Text('Entrenamiento')),
            onTap: () {
              if (currenPage != 'entrenamiento') {
                Navigator.of(context).pop();
                if (isHome) {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) {
                        return EntrenamientoView(user: user!);
                      },
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) {
                        return EntrenamientoView(user: user!);
                      },
                    ),
                  );
                }
              }
              return;
            },
          ),
          Divider(
            color: const Color(
              0xff707070,
            ).withOpacity(0.4),
            thickness: 1,
          ),
          ListTile(
            title: const Center(child: Text('Evaluación')),
            onTap: () {
              if (currenPage != 'evaluaciones') {
                Navigator.of(context).pop();
                if (isHome) {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) {
                        return EvaluacionView(user: user!);
                      },
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) {
                        return EvaluacionView(user: user!);
                      },
                    ),
                  );
                }
              }
              return;
            },
          ),
          Divider(
            color: const Color(
              0xff707070,
            ).withOpacity(0.4),
            thickness: 1,
          ),
          ListTile(
            title: const Center(child: Text('Biblioteca')),
            onTap: () {
              if (currenPage != 'biblioteca') {
                Navigator.of(context).pop();
                if (isHome) {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) {
                        return BibliotecaView(user: user);
                      },
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) {
                        return BibliotecaView(user: user);
                      },
                    ),
                  );
                }
              }
              return;
            },
          ),
          Divider(
            color: const Color(
              0xff707070,
            ).withOpacity(0.4),
            thickness: 1,
          ),
          ListTile(
            title: const Center(child: Text('Noticias')),
            onTap: () {
              if (currenPage != 'noticias') {
                Navigator.of(context).pop();
                if (isHome) {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) {
                        return NoticiasView(user: user);
                      },
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) {
                        return NoticiasView(user: user);
                      },
                    ),
                  );
                }
              }
              return;
            },
          ),
          Divider(
            color: const Color(
              0xff707070,
            ).withOpacity(0.4),
            thickness: 1,
          ),
          // ListTile(
          //     leading: Icon(Icons.cast_for_education),
          //     title: Text('Streamings'),
          //     onTap: () {
          //       if (currenPage != 'streaming') {
          //         Navigator.of(context).pop();
          //         if (isHome) {
          //           Navigator.push(context,
          //               MaterialPageRoute(builder: (context) {
          //             return StreamingPage(user: user);
          //           }));
          //         } else {
          //           Navigator.pushReplacement(context,
          //               MaterialPageRoute(builder: (context) {
          //             return StreamingPage(user: user);
          //           }));
          //         }
          //       }
          //       return null;
          //     }),
          ListTile(
            title: const Center(child: Text('Resuelvelo con LG')),
            onTap: () {
              if (currenPage != 'resuelvelo') {
                Navigator.of(context).pop();
                if (isHome) {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) {
                        return ResuelveloView(user: user!);
                      },
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) {
                        return ResuelveloView(user: user!);
                      },
                    ),
                  );
                }
              }
              return;
            },
          ),
          Divider(
            color: const Color(
              0xff707070,
            ).withOpacity(0.4),
            thickness: 1,
          ),
          ListTile(
            title: const Center(child: Text('Calendario')),
            onTap: () {
              if (currenPage != 'calendario') {
                Navigator.of(context).pop();
                if (isHome) {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) {
                        return CalendarioView(user: user!);
                      },
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) {
                        return CalendarioView(user: user!);
                      },
                    ),
                  );
                }
              }
              return;
            },
          ),
          Divider(
            color: const Color(
              0xff707070,
            ).withOpacity(0.4),
            thickness: 1,
          ),

          ListTile(
            title: const Center(child: Text('Ranking')),
            onTap: () {
              if (currenPage != 'ranking') {
                Navigator.of(context).pop();
                if (isHome) {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) {
                        return RankingView(user: user);
                      },
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) {
                        return RankingView(user: user);
                      },
                    ),
                  );
                }
              }
              return;
            },
          ),
          Divider(
            color: const Color(
              0xff707070,
            ).withOpacity(0.4),
            thickness: 1,
          ),
          ListTile(
            title: const Center(child: Text('Ayuda')),
            onTap: () {
              if (currenPage != 'ayuda') {
                Navigator.of(context).pop();
                if (isHome) {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) {
                        return AyudaView(user: user);
                      },
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) {
                        return AyudaView(user: user);
                      },
                    ),
                  );
                }
              }
              return;
            },
          ),

          ListTile(
            minTileHeight: 80,
            contentPadding: EdgeInsets.zero,
            tileColor: Colors.white,
            title: Center(
              child: Column(
                children: [
                  const Icon(
                    Icons.person_2_sharp,
                    size: 32,
                    color: Colors.black,
                  ),
                  Text('${user!.name} '),
                ],
              ),
            ),
            onTap: () {
              if (currenPage != 'perfil') {
                Navigator.of(context).pop();
                if (isHome) {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) {
                        return PerfilView(user: user);
                      },
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) {
                        return PerfilView(user: user);
                      },
                    ),
                  );
                }
              }
              return;
            },
          ),
        ],
      ),
    );
  }
}
