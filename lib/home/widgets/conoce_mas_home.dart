import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:universidad_lg_24/users/blocs/authentication/authentication_bloc.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';

class ConoceMas extends StatelessWidget {
  const ConoceMas({super.key, this.user});
  final User? user;
  @override
  Widget build(BuildContext context) {
    // final authBloc = BlocProvider.of<AuthenticationBloc>(context);

    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20, bottom: 20),
            alignment: Alignment.topLeft,
            child: const Text(
              'CONOCE MÁS DE LO \nQUE TENEMOS PARA TI',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                height: 1,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    BackgroundImage(
                      image: 'assets/img/club.png',
                      height: 240.0,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: const RoundedRectangleBorder(),
                        side: const BorderSide(color: Colors.white),
                      ),
                      onPressed: () {
                        /* Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return EntrenamientoPage(user: user);
                            },
                          ),
                        ); */
                      },
                      child: const Text('ENTRENAMIENTO'),
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    BackgroundImage(
                      image: 'assets/img/biblioteca.png',
                      height: 240.0,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: const RoundedRectangleBorder(),
                        side: const BorderSide(color: Colors.white),
                      ),
                      onPressed: () {
                        /*  Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return BibliotecaPage(user: user);
                            },
                          ),
                        ); */
                      },
                      child: const Text('BIBLIOTECA'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
