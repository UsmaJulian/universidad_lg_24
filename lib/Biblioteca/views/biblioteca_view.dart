import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universidad_lg_24/Biblioteca/bloc/biblioteca/biblioteca_bloc.dart';
import 'package:universidad_lg_24/Biblioteca/services/biblioteca_services.dart';
import 'package:universidad_lg_24/Biblioteca/views/widgets/widgets.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/home/views/home_view.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';

class BibliotecaView extends StatelessWidget {
  const BibliotecaView({super.key, this.user});
  final User? user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Center(
          child: InkWell(
            onTap: () {
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
            },
            child: const Image(
              image: AssetImage('assets/images/new_logo.png'),
              height: 35,
            ),
          ),
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
              icon: const Icon(Icons.person),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      drawer: DrawerMenuLeft(
        user: user,
        currenPage: 'biblioteca',
      ),
      endDrawer: DrawerMenuRight(
        user: user,
      ),
      body: BlocProvider<BibliotecaBloc>(
        create: (context) => BibliotecaBloc(service: IsBibliotecaService()),
        child: ContentBibliotecaView(user: user),
      ),
    );
  }
}
