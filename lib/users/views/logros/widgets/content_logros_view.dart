import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/users/blocs/logros/logros_bloc.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/widgets/global/body_footer_global.dart';

class ContentLogrosView extends StatefulWidget {
  const ContentLogrosView({super.key, this.user});
  final User? user;

  @override
  _ContentLogrosViewState createState() => _ContentLogrosViewState();
}

class _ContentLogrosViewState extends State<ContentLogrosView> {
  TextEditingController searchController = TextEditingController();
  Logros? data;
  @override
  void initState() {
    super.initState();

    getLogrosData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<LogrosBloc, LogrosState>(
        builder: (context, state) {
          final blocLogros = BlocProvider.of<LogrosBloc>(context);
          if (state is LogrosSuccess) {
            data = state.data;
          }

          if (state is LogrosLoad) {
            return const Center(
              child: CircularProgressIndicator(
                color: mainColor,
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              blocLogros.add(
                GetLogrosEvent(widget.user!.userId!, widget.user!.token!),
              );
            },
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Stack(
                    children: [
                      Column(
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
                            margin: const EdgeInsets.only(top: 50),
                            child: const Text(
                              'MIS LOGROS',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          if (state is LogrosSuccess)
                            for (final item in state.data.status!.data!)
                              Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 20,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      offset: const Offset(0, 1),
                                      blurRadius: 7,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    if (item.medalla == 'sin-copa')
                                      const Icon(
                                        Icons.emoji_events_outlined,
                                        color: Colors.black,
                                        size: 120,
                                      ),
                                    if (item.medalla == 'oro')
                                      const Icon(
                                        Icons.emoji_events,
                                        color: Color(0xFFfbeb39),
                                        size: 120,
                                      ),
                                    if (item.medalla == 'plata')
                                      const Icon(
                                        Icons.emoji_events,
                                        color: Color(0xFFe4e4e4),
                                        size: 120,
                                      ),
                                    if (item.medalla == 'bronce')
                                      const Icon(
                                        Icons.emoji_events,
                                        color: Color(0xFFf8ac2f),
                                        size: 120,
                                      ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('${item.porcentaje} %'),
                                    Text(item.titulo!),
                                  ],
                                ),
                              ),

                          //     for (var item in data.status.data) {
                          //       if (state.title != null) {
                          //         var as = RegExp(state.title, caseSensitive: false)
                          //             .hasMatch(item.titulo);
                          //         print(as);
                          //         print(item.titulo);
                          //       }
                          //     }
                          // }

                          if (state is LogrosSearch)
                            for (final item in data!.status!.data!)
                              if (item.titulo!
                                  .toLowerCase()
                                  .contains(state.title.toLowerCase()))
                                Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20,
                                    horizontal: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        offset: const Offset(0, 1),
                                        blurRadius: 7,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      if (item.medalla == 'sin-copa')
                                        const Icon(
                                          Icons.emoji_events_outlined,
                                          color: Colors.black,
                                          size: 120,
                                        ),
                                      if (item.medalla == 'oro')
                                        const Icon(
                                          Icons.emoji_events,
                                          color: Color(0xFFfbeb39),
                                          size: 120,
                                        ),
                                      if (item.medalla == 'plata')
                                        const Icon(
                                          Icons.emoji_events,
                                          color: Color(0xFFe4e4e4),
                                          size: 120,
                                        ),
                                      if (item.medalla == 'bronce')
                                        const Icon(
                                          Icons.emoji_events,
                                          color: Color(0xFFf8ac2f),
                                          size: 120,
                                        ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text('${item.porcentaje} %'),
                                      Text(item.titulo!),
                                    ],
                                  ),
                                ),
                          const BodyFooter(),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: searchInput(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void getLogrosData() {
    final blocLogros = BlocProvider.of<LogrosBloc>(context);
    blocLogros.add(GetLogrosEvent(widget.user!.userId!, widget.user!.token!));
  }

  Widget searchInput() {
    return Container(
      margin: const EdgeInsets.symmetric(),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: Color(0xfff6f6f6),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black45,
            offset: Offset(0, 2),
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: searchController,
              onChanged: (String value) async {
                search(value);
              },
              decoration: const InputDecoration(
                hintText: 'Buscar Logros',
                hintStyle: TextStyle(fontSize: 16),
                border: InputBorder.none,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              search(searchController.text);
              // print(searchController.text);
            },
            child: Container(child: const Icon(Icons.search, color: mainColor)),
          ),
        ],
      ),
    );
  }

  void search(String title) {
    final blocLogros = BlocProvider.of<LogrosBloc>(context);
    blocLogros.add(SearchLogrosEvent(title));
  }
}
