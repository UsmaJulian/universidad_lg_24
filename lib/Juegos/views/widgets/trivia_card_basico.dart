import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:universidad_lg_24/Juegos/models/juegos_model.dart';
import 'package:universidad_lg_24/Juegos/services/juegos_services.dart';

import 'package:universidad_lg_24/Juegos/views/trivia_view.dart';
import 'package:universidad_lg_24/helpers/my_long_print.dart';
import 'package:universidad_lg_24/users/models/models.dart';

class TriviaCardBasico extends StatefulWidget {
  const TriviaCardBasico({
    required this.user,
    super.key,
  });
  final User user;

  @override
  State<TriviaCardBasico> createState() => _TriviaCardBasicoState();
}

class _TriviaCardBasicoState extends State<TriviaCardBasico> {
  final StreamController<JuegosModel> _streamController =
      StreamController<JuegosModel>();
  final RefreshController _refreshController = RefreshController();
  int _pager = 1;

  Future<void> _loadInitialData() async {
    try {
      final juegos = await IsJuegosServices().getJuegosBasic(
        user: widget.user.userId,
        token: widget.user.token,
        pager: _pager,
      );
      _streamController.add(juegos);
    } catch (e) {
      _streamController.addError(e);
    }
  }

  Future<void> _refreshData() async {
    try {
      debugPrint('refrescando');
      final juegos = await IsJuegosServices().getJuegosBasic(
        user: widget.user.userId,
        token: widget.user.token,
        pager: _pager++,
      );
      _streamController.add(juegos);
      _refreshController.refreshCompleted();
    } catch (e) {
      _streamController.addError(e);
    }
  }

  @override
  void initState() {
    _loadInitialData();

    super.initState();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<JuegosModel>(
      stream: _streamController.stream,
      builder: (BuildContext context, AsyncSnapshot<JuegosModel> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final juegos = snapshot.data;
          // Aquí puedes construir tu UI con los datos de juegos
          myLongPrint('Juegos básicos: ${juegos!.body!.toSet().toList()}');
          return SmartRefresher(
            // enablePullUp: true,
            header: const WaterDropHeader(),
            controller: _refreshController,
            onRefresh: _refreshData,

            child: ListView.builder(
              itemCount: juegos.body!.toSet().toList().length,
              itemBuilder: (BuildContext context, int index) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(38),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              juegos.body!.toSet().toList()[index].image!,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 19,
                                top: 15,
                              ),
                              child: Text(
                                juegos.body!.toSet().toList()[index].title!,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 19,
                                top: 1,
                              ),
                              child: HtmlWidget(
                                juegos.body!.toSet().toList()[index].content!,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 19,
                                top: 14,
                                bottom: 14,
                              ),
                              child: ElevatedButton(
                                onPressed: (juegos.body!
                                            .toSet()
                                            .toList()[index]
                                            .status
                                            .toString() ==
                                        '0')
                                    ? () async {
                                        final response =
                                            await IsJuegosServices()
                                                .getJuegosContent(
                                          user: widget.user.userId,
                                          token: widget.user.token,
                                          nid: int.parse(
                                            juegos.body!
                                                .toSet()
                                                .toList()[index]
                                                .nid
                                                .toString(),
                                          ),
                                        );
                                        if (response.body!.trivia!.isNotEmpty) {
                                          await Future<void>.delayed(
                                            Duration.zero,
                                          ).then(
                                            (_) => Navigator.push(
                                              context,
                                              MaterialPageRoute<void>(
                                                builder: (context) {
                                                  return TriviaView(
                                                    user: widget.user,
                                                    content: response,
                                                  );
                                                },
                                              ),
                                            ),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'No hay trivias disponibles',
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(129, 41),
                                  backgroundColor: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                    side: BorderSide(),
                                  ),
                                ),
                                child: (juegos.body!
                                            .toSet()
                                            .toList()[index]
                                            .status
                                            .toString() ==
                                        '0')
                                    ? const Text(
                                        'Comenzar',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      )
                                    : const Text(
                                        'Realizada',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: Text('No data'));
        }
      },
    );
  }
}
