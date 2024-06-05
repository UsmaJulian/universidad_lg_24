import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/home/views/home_view.dart';
import 'package:universidad_lg_24/users/blocs/authentication/authentication_bloc.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/users/views/login/login_view.dart';

class DrawerMenuRight extends StatelessWidget {
  const DrawerMenuRight({
    super.key,
    this.user,
    this.currenPage,
    this.isHome = false,
  });
  final User? user;
  final String? currenPage;
  final bool isHome;
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
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
                            return HomeView(
                              user: user,
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
                Text(
                  user?.name ?? '',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          /* ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Mi perfil'),
            onTap: () {
              if (currenPage != 'perfil') {
                Navigator.of(context).pop();
                if (isHome) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return PerfilPage(
                          user: user,
                        );
                      },
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return PerfilPage(
                          user: user,
                        );
                      },
                    ),
                  );
                }
              }
              return;
            },
          ), */
          /* ListTile(
            leading: const Icon(Icons.emoji_events),
            title: const Text('Mis logros'),
            onTap: () {
              if (currenPage != 'logros') {
                Navigator.of(context).pop();
                if (isHome) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return PageLogros(
                          user: user,
                        );
                      },
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return PageLogros(
                          user: user,
                        );
                      },
                    ),
                  );
                }
              }
              return;
            },
          ), */
          /* ListTile(
            leading: const Icon(Icons.public),
            title: const Text('Ranking'),
            onTap: () {
              if (currenPage != 'ranking') {
                Navigator.of(context).pop();
                if (isHome) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return PageRanking(
                          user: user,
                        );
                      },
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return PageRanking(
                          user: user,
                        );
                      },
                    ),
                  );
                }
              }
              return;
            },
          ), */
          ListTile(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute<void>(
                  builder: (_) {
                    authBloc.add(UserLoggedOut());
                    return const LoginView();
                  },
                ),
                (route) => false,
              );
            },
            leading: const Icon(Icons.logout),
            title: const Text('Cerrar sesión'),
          ),
        ],
      ),
    );
  }
}
