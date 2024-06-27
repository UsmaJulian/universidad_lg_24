import 'package:flutter/material.dart';
import 'package:universidad_lg_24/Biblioteca/models/biblioteca_model.dart';
import 'package:universidad_lg_24/Biblioteca/views/widgets/widgets.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/home/views/home_view.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';

class SingleBibliotecaView extends StatelessWidget {
  const SingleBibliotecaView({super.key, this.user, this.data});
  final User? user;
  final BibliotecaValue? data;
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
      ),
      endDrawer: DrawerMenuRight(
        user: user,
      ),
      body: ContentSingleBibliotecaView(data: data),
    );
  }
}
