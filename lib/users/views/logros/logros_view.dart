import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universidad_lg_24/users/blocs/logros/logros_bloc.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/users/services/logros_services.dart';
import 'package:universidad_lg_24/users/views/logros/widgets/content_logros_view.dart';
import 'package:universidad_lg_24/widgets/global/header_global.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';

class LogrosView extends StatelessWidget {
  const LogrosView({super.key, this.user});
  final User? user;
  @override
  Widget build(BuildContext context) {
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
      body: BlocProvider<LogrosBloc>(
        create: (context) => LogrosBloc(service: IsLogrosService()),
        child: Padding(
          padding: const EdgeInsets.only(top: 128),
          child: ContentLogrosView(user: user),
        ),
      ),
    );
  }
}
