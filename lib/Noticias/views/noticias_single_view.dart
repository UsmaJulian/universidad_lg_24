import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:universidad_lg_24/Noticias/blocs/single/single_bloc.dart';
import 'package:universidad_lg_24/Noticias/services/services.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/widgets/global/body_footer_global.dart';
import 'package:universidad_lg_24/widgets/global/header_global.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';

class NoticiaSinglePage extends StatelessWidget {
  const NoticiaSinglePage({super.key, this.user, this.nid});
  final User? user;
  final String? nid;

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
        child: BlocProvider<SingleBloc>(
          create: (context) => SingleBloc(
            service: IsServiceNoticiasSingle(),
          ),
          child: _ContentSingleNoticia(user: user, nid: nid),
        ),
      ),
    );
  }
}

class _ContentSingleNoticia extends StatefulWidget {
  const _ContentSingleNoticia({super.key, this.user, this.nid});
  final User? user;
  final String? nid;

  @override
  State<StatefulWidget> createState() => __ContentSingleNoticia();
}

class __ContentSingleNoticia extends State<_ContentSingleNoticia> {
  @override
  void initState() {
    super.initState();
    _loadDataSingleNoticia();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: BlocBuilder<SingleBloc, SingleState>(
        builder: (context, state) {
          final streamingBloc = BlocProvider.of<SingleBloc>(context);

          if (state is SingleSuccess) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 20,
                    ),
                    margin: const EdgeInsets.only(bottom: 20),
                    child: const Text(
                      'NOTICIA',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      state.data.status.data.title,
                      style: const TextStyle(
                        fontSize: 24,
                        height: 1.15,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: HtmlWidget(
                      state.data.status.data.body,
                      textStyle: const TextStyle(color: mainColor),
                    ),
                  ),
                  const BodyFooter(),
                ],
              ),
            );
          }

          if (state is ErrorSingle) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(state.message),
                  TextButton(
                    child: const Text('Volver a intentar'),
                    onPressed: () {
                      streamingBloc.add(
                        GetSingleNoticiaEvent(
                          user: widget.user!.userId,
                          token: widget.user!.token,
                          nid: widget.nid,
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(
              color: mainColor,
            ),
          );
        },
      ),
    );
  }

  void _loadDataSingleNoticia() {
    BlocProvider.of<SingleBloc>(context).add(
      GetSingleNoticiaEvent(
        user: widget.user!.userId,
        token: widget.user!.token,
        nid: widget.nid,
      ),
    );
  }
}
