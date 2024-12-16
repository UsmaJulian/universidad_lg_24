import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universidad_lg_24/Biblioteca/bloc/biblioteca/biblioteca_bloc.dart';
import 'package:universidad_lg_24/Biblioteca/services/biblioteca_services.dart';
import 'package:universidad_lg_24/Biblioteca/views/widgets/widgets.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/widgets/global/header_global.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';

class BibliotecaView extends StatelessWidget {
  const BibliotecaView({super.key, this.user});
  final User? user;
  @override
  Widget build(BuildContext context) {
    print('actual view: ${ModalRoute.of(context)?.settings.name}');
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: const Color(0xffF6F3EB),
      appBar: CustomAppBar(user: user),
      endDrawer: DrawerMenu(
        user: user,
        isHome: true, // Indica que el DrawerMenuLeft se está utilizando
        // en la pantalla de inicio.
      ),
      body: Padding(
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
        child: BlocProvider<BibliotecaBloc>(
          create: (context) => BibliotecaBloc(service: IsBibliotecaService()),
          child: ContentBibliotecaView(user: user),
        ),
      ),
    );
  }
}
