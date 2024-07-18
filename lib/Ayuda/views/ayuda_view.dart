import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universidad_lg_24/Ayuda/blocs/ayuda/ayuda_bloc.dart';
import 'package:universidad_lg_24/Ayuda/services/ayuda_service.dart';
import 'package:universidad_lg_24/Ayuda/views/ayuda_form_view.dart';
import 'package:universidad_lg_24/Ayuda/views/widgets/widgets.dart';
import 'package:universidad_lg_24/Home/views/home_view.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/widgets/global/bottom_app_bar_global.dart';
import 'package:universidad_lg_24/widgets/global/header_global.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';

class AyudaView extends StatelessWidget {
  const AyudaView({super.key, this.user});
  final User? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: const Color(0xffF6F3EB),
      appBar: CustomAppBar(),
      endDrawer: DrawerMenu(
        user: user,
        isHome: true, // Indica que el DrawerMenuLeft se está utilizando
        // en la pantalla de inicio.
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 120),
        child: BlocProvider<AyudaBloc>(
          create: (context) => AyudaBloc(
            service: IsAyudaService(),
          ),
          child: ContentAyuda(user: user),
        ),
      ),
      bottomNavigationBar: const CustomBottomAppBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainColor,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) {
                return AyudaFormView(
                  user: user,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
