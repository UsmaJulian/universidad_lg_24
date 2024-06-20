import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universidad_lg_24/Noticias/blocs/general/general_bloc.dart';
import 'package:universidad_lg_24/Noticias/models/models.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';

class ContentNoticiasPage extends StatefulWidget {
  const ContentNoticiasPage({super.key, this.user});
  final User? user;
  @override
  _ContentNoticiasPageState createState() => _ContentNoticiasPageState();
}

class _ContentNoticiasPageState extends State<ContentNoticiasPage> {
  @override
  void initState() {
    super.initState();

    _loadNoticiasData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<GeneralBloc, GeneralState>(
        builder: (context, state) {
          final noticiasBloc = BlocProvider.of<GeneralBloc>(context);

          if (state is GeneralSuccess) {
            return RefreshIndicator(
              onRefresh: () async {
                noticiasBloc.add(
                  GetNoticiasEvent(
                    token: widget.user!.token,
                    user: widget.user!.userId,
                  ),
                );
              },
              child: SingleChildScrollView(
                child: Column(
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
                        'NOTICIAS',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    for (final item in state.data.status.data)
                      _ItemNoticias(item: item, user: widget.user),
                  ],
                ),
              ),
            );
          }

          if (state is ErrorGeneralNoticias) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(state.message),
                  TextButton(
                    child: const Text('Volver a intentar'),
                    onPressed: () {
                      noticiasBloc.add(
                        GetNoticiasEvent(
                          token: widget.user!.token,
                          user: widget.user!.userId,
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

  void _loadNoticiasData() {
    BlocProvider.of<GeneralBloc>(context).add(
      GetNoticiasEvent(token: widget.user!.token, user: widget.user!.userId),
    );
  }
}

class _ItemNoticias extends StatelessWidget {
  const _ItemNoticias({super.key, this.item, this.user});
  final Datum? item;
  final User? user;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // margin: EdgeInsets.only(bottom: 20.0),
      width: double.infinity,
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              CachedNetworkImage(
                imageUrl: item!.uri,
                placeholder: (context, url) => const CircularProgressIndicator(
                  color: mainColor,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Column(
              children: [
                Text(
                  item!.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.25,
                    color: mainColor,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  item!.bodyValue,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 15),
                ButtonMain(
                  text: 'LEER MÁS',
                  // onpress: NoticiaSinglePage(
                  //   user: user,
                  //   nid: item.nid,
                  // ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
