import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universidad_lg_24/Home/views/home_view.dart';
import 'package:universidad_lg_24/Noticias/blocs/general/general_bloc.dart';
import 'package:universidad_lg_24/Noticias/services/services.dart';
import 'package:universidad_lg_24/Noticias/views/widgets/widgets.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/users/models/models.dart';

import 'package:universidad_lg_24/widgets/widgets.dart';

class NoticiasPage extends StatelessWidget {
  const NoticiasPage({super.key, this.user});
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
        currenPage: 'noticias',
      ),
      endDrawer: DrawerMenuRight(
        user: user,
      ),
      body: BlocProvider<GeneralBloc>(
        create: (context) => GeneralBloc(service: IsNoticiasService()),
        child: ContentNoticiasPage(user: user),
      ),
    );
  }
}
