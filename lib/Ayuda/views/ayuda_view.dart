import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universidad_lg_24/Ayuda/blocs/ayuda/ayuda_bloc.dart';
import 'package:universidad_lg_24/Ayuda/services/ayuda_service.dart';
import 'package:universidad_lg_24/Ayuda/views/ayuda_form_view.dart';
import 'package:universidad_lg_24/Ayuda/views/widgets/widgets.dart';
import 'package:universidad_lg_24/Home/views/home_view.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';

class AyudaView extends StatelessWidget {
  const AyudaView({super.key, this.user});
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
        currenPage: 'ayuda',
      ),
      endDrawer: DrawerMenuRight(
        user: user,
      ),
      body: BlocProvider<AyudaBloc>(
        create: (context) => AyudaBloc(
          service: IsAyudaService(),
        ),
        child: ContentAyuda(user: user),
      ),
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
