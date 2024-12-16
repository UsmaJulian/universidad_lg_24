import 'package:flutter/material.dart';
import 'package:universidad_lg_24/Ayuda/views/ayuda_view.dart';
import 'package:universidad_lg_24/Biblioteca/views/biblioteca_view.dart';
import 'package:universidad_lg_24/Entrenamiento/views/entrenamiento_view.dart';
import 'package:universidad_lg_24/Evaluaciones/views/evaluacion_view.dart';
import 'package:universidad_lg_24/Home/views/new_home_view.dart';
import 'package:universidad_lg_24/Noticias/views/noticias_view.dart';
import 'package:universidad_lg_24/constants.dart';
// import 'package:universidad_lg_24/home/views/home_view.dart';
import 'package:universidad_lg_24/users/models/models.dart';

class DrawerMenuLeft extends StatelessWidget {
  const DrawerMenuLeft({
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
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            child: DrawerHeader(
              decoration: const BoxDecoration(
                color: mainColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
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
                      image: AssetImage('assets/images/new_logo.png'),
                      height: 40,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.school),
            title: const Text('Entrenamiento'),
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
          ListTile(
            leading: const Icon(Icons.history_edu),
            title: const Text('Evaluación'),
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
          ListTile(
            leading: const Icon(Icons.collections_bookmark),
            title: const Text('Biblioteca'),
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
          ListTile(
            leading: const Icon(Icons.local_activity),
            title: const Text('Noticias'),
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
            leading: const Icon(Icons.help),
            title: const Text('Ayuda'),
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
        ],
      ),
    );
  }
}
