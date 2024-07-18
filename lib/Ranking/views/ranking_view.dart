import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universidad_lg_24/Ranking/ranking/ranking_bloc.dart';
import 'package:universidad_lg_24/Ranking/services/ranking_services.dart';
import 'package:universidad_lg_24/Ranking/views/widgets/content_ranking_view.dart';

import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/widgets/global/bottom_app_bar_global.dart';
import 'package:universidad_lg_24/widgets/global/header_global.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';

class RankingView extends StatelessWidget {
  const RankingView({super.key, this.user});
  final User? user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: const Color(0xffF6F3EB),
      appBar: CustomAppBar(),
      endDrawer: DrawerMenu(
        user: user,
        isHome: true, // Indica que el DrawerMenuLeft se está utilizando
        // en la pantalla de inicio.
      ),
      body: BlocProvider<RankingBloc>(
        create: (context) => RankingBloc(service: IsRankingService()),
        child: ContentRankingView(user: user),
      ),
      bottomNavigationBar: const CustomBottomAppBar(),
    );
  }
}
