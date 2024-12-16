// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universidad_lg_24/Ayuda/views/ayuda_view.dart';
import 'package:universidad_lg_24/Biblioteca/views/biblioteca_view.dart';
import 'package:universidad_lg_24/Calendario/views/calendario_view.dart';
import 'package:universidad_lg_24/Evaluaciones/views/evaluacion_view.dart';
import 'package:universidad_lg_24/Home/views/new_home_view.dart';
import 'package:universidad_lg_24/Noticias/views/noticias_view.dart';
import 'package:universidad_lg_24/Ranking/views/ranking_view.dart';
import 'package:universidad_lg_24/Resuelvelo/views/resuelvelo_view.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/users/blocs/authentication/authentication_bloc.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/users/views/login/login_view.dart';
import 'package:universidad_lg_24/users/views/profile/perfil_view.dart';

class DrawerMenu extends StatefulWidget {
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
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    return Drawer(
      backgroundColor: bgColor,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
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
                          if (!widget.isHome) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute<void>(
                                builder: (_) {
                                  return NewHomeView(
                                    user: widget.user!,
                                  );
                                },
                              ),
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
              if (widget.currenPage != 'inicio') {
                Navigator.of(context).pop();
                if (widget.isHome) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) {
                        return NewHomeView(user: widget.user!);
                      },
                      settings: const RouteSettings(name: '/'),
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) {
                        return NewHomeView(user: widget.user!);
                      },
                      settings: const RouteSettings(name: '/'),
                    ),
                  );
                }
              }
              return;
            },
          ),
          // Divider(
          //   color: const Color(
          //     0xff707070,
          //   ).withOpacity(0.4),
          //   thickness: 1,
          // ),
          // ListTile(
          //   title: const Center(child: Text('Entrenamiento')),
          //   onTap: () {
          //     if (currenPage != 'entrenamiento') {
          //       Navigator.of(context).pop();
          //       if (isHome) {
          //         Navigator.pushReplacement(
          //           context,
          //           MaterialPageRoute<void>(
          //             builder: (context) {
          //               return EntrenamientoView(user: user!);
          //             },
          //           ),
          //         );
          //       } else {
          //         Navigator.pushReplacement(
          //           context,
          //           MaterialPageRoute<void>(
          //             builder: (context) {
          //               return EntrenamientoView(user: user!);
          //             },
          //           ),
          //         );
          //       }
          //     }
          //     return;
          //   },
          // ),
          Divider(
            color: const Color(
              0xff707070,
            ).withOpacity(0.4),
            thickness: 1,
          ),
          ListTile(
            title: const Center(child: Text('Evaluación')),
            onTap: () {
              if (widget.currenPage != 'evaluaciones') {
                Navigator.of(context).pop();
                if (widget.isHome) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) {
                        return EvaluacionView(user: widget.user!);
                      },
                      settings: const RouteSettings(name: '/assessment'),
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) {
                        return EvaluacionView(user: widget.user!);
                      },
                      settings: const RouteSettings(name: '/assessment'),
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
              if (widget.currenPage != 'biblioteca') {
                Navigator.of(context).pop();
                if (widget.isHome) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) {
                        return BibliotecaView(user: widget.user);
                      },
                      settings: const RouteSettings(name: '/library'),
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) {
                        return BibliotecaView(user: widget.user);
                      },
                      settings: const RouteSettings(name: '/library'),
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
              if (widget.currenPage != 'noticias') {
                Navigator.of(context).pop();
                if (widget.isHome) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) {
                        return NoticiasView(user: widget.user);
                      },
                      settings: const RouteSettings(name: '/news'),
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) {
                        return NoticiasView(user: widget.user);
                      },
                      settings: const RouteSettings(name: '/news'),
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
          //           Navigator.pushReplacement(context,
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
              if (widget.currenPage != 'resuelvelo') {
                Navigator.of(context).pop();
                if (widget.isHome) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) {
                        return ResuelveloView(user: widget.user!);
                      },
                      settings: const RouteSettings(name: '/solve'),
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) {
                        return ResuelveloView(user: widget.user!);
                      },
                      settings: const RouteSettings(name: '/solve'),
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
              if (widget.currenPage != 'calendario') {
                Navigator.of(context).pop();
                if (widget.isHome) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) {
                        return CalendarioView(user: widget.user!);
                      },
                      settings: const RouteSettings(name: '/calendar'),
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) {
                        return CalendarioView(user: widget.user!);
                      },
                      settings: const RouteSettings(name: '/calendar'),
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
              if (widget.currenPage != 'ranking') {
                Navigator.of(context).pop();
                if (widget.isHome) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) {
                        return RankingView(user: widget.user);
                      },
                      settings: const RouteSettings(name: '/ranking'),
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) {
                        return RankingView(user: widget.user);
                      },
                      settings: const RouteSettings(name: '/ranking'),
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
              if (widget.currenPage != 'ayuda') {
                Navigator.of(context).pop();
                if (widget.isHome) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) {
                        return AyudaView(user: widget.user);
                      },
                      settings: const RouteSettings(name: '/help'),
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) {
                        return AyudaView(user: widget.user);
                      },
                      settings: const RouteSettings(name: '/help'),
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
                  Text('${widget.user!.name} '),
                ],
              ),
            ),
            onTap: () {
              setState(() {
                _isVisible = !_isVisible;
              });
            },
          ),
          if (_isVisible)
            ColoredBox(
              color: Colors.white,
              child: Divider(
                color: const Color(
                  0xff707070,
                ).withOpacity(0.4),
                thickness: 1,
              ),
            ),
          if (_isVisible)
            Column(
              children: [
                ListTile(
                  title: const Center(child: Text('Editar perfil')),
                  tileColor: Colors.white,
                  onTap: () {
                    if (widget.currenPage != 'perfil') {
                      Navigator.of(context).pop();
                      if (widget.isHome) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute<void>(
                            builder: (context) {
                              return PerfilView(user: widget.user);
                            },
                            settings: const RouteSettings(name: '/profile'),
                          ),
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute<void>(
                            builder: (context) {
                              return PerfilView(user: widget.user);
                            },
                            settings: const RouteSettings(name: '/profile'),
                          ),
                        );
                      }
                    }
                    return;
                  },
                ),
                ListTile(
                  title: const Center(child: Text('Cerrar sesión')),
                  tileColor: Colors.white,
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) {
                          authBloc.add(const UserLoggedOut());
                          return const LoginView();
                        },
                      ),
                    );
                  },
                ),
              ],
            )
          else
            const SizedBox(),
        ],
      ),
    );
  }
}
