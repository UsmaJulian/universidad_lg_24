import 'package:flutter/material.dart';
import 'package:universidad_lg_24/Evaluaciones/views/widgets/evaluacion_content.dart';
import 'package:universidad_lg_24/Home/views/home_view.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';

class EvaluacionView extends StatelessWidget {
  const EvaluacionView({
    required this.user,
    super.key,
  });
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
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
        currenPage: 'evaluaciones',
      ),
      endDrawer: DrawerMenuRight(
        user: user,
      ),
      body: EvaluacionContent(
        user: user,
      ),
    );
  }
}
