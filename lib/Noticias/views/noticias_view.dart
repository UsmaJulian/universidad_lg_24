import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:universidad_lg_24/Noticias/blocs/general/general_bloc.dart';
import 'package:universidad_lg_24/Noticias/services/services.dart';
import 'package:universidad_lg_24/Noticias/views/widgets/widgets.dart';

import 'package:universidad_lg_24/users/models/models.dart';

import 'package:universidad_lg_24/widgets/global/header_global.dart';

import 'package:universidad_lg_24/widgets/widgets.dart';

class NoticiasView extends StatelessWidget {
  const NoticiasView({super.key, this.user});
  final User? user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: CustomAppBar(),
      endDrawer: DrawerMenu(
        user: user,
        isHome: true, // Indica que el DrawerMenuLeft se está utilizando
        // en la pantalla de inicio.
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 120),
        child: BlocProvider<GeneralBloc>(
          create: (context) => GeneralBloc(service: IsNoticiasService()),
          child: ContentNoticiasPage(user: user),
        ),
      ),
    );
  }
}
