import 'package:flutter/material.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/home/widgets/widgets.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, this.user});
  final User? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Center(
          child: InkWell(
            child: Image(
              image: AssetImage('assets/img/new_logo.png'),
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
      backgroundColor: mainColor,
      drawer: DrawerMenuLeft(
        user: user,
        isHome: true,
      ),
      endDrawer: DrawerMenuRight(
        user: user,
        isHome: true,
      ),

      body: Builder(
        builder: (context) => Container(
          color: Colors.white,
          child: HomeContent(
            user: user,
          ),
        ),
      ),
    );
  }
}
