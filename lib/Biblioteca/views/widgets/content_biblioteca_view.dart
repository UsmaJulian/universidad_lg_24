import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universidad_lg_24/Biblioteca/bloc/biblioteca/biblioteca_bloc.dart';
import 'package:universidad_lg_24/Biblioteca/models/biblioteca_model.dart';
import 'package:universidad_lg_24/Biblioteca/views/widgets/widgets.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/users/models/models.dart';

class ContentBibliotecaView extends StatefulWidget {
  const ContentBibliotecaView({super.key, this.user});
  final User? user;
  @override
  State<StatefulWidget> createState() => _ContentBibliotecaView();
}

class _ContentBibliotecaView extends State<ContentBibliotecaView> {
  String filtro = 'none';
  String categoria = 'none';
  TextEditingController searchController = TextEditingController();
  String searchTerm = '';

  Biblioteca? data;

  @override
  void initState() {
    super.initState();
    _getDataBiblioteca();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BibliotecaBloc, BibliotecaState>(
      listener: (context, state) {
        if (state is BibliotecaChangeFilter) {
          setState(() {
            filtro = state.filtro;
          });
        }
        if (state is BibliotecaChangeCategoria) {
          categoria = state.categoria;
        }
      },
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: BlocBuilder<BibliotecaBloc, BibliotecaState>(
              builder: (context, state) {
                final bibliotecaBloc = BlocProvider.of<BibliotecaBloc>(context);

                if (state is BibliotecaSucess) {
                  data = state.data;
                  return RefreshIndicator(
                    onRefresh: () async {
                      filtro = 'none';
                      bibliotecaBloc.add(
                        GetBibliotecaEvent(
                          user: widget.user!.userId,
                          token: widget.user!.token,
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
                            child: Text(
                              state.data.status!.message.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                decoration: const BoxDecoration(
                                  color: mainColor,
                                ),
                                child: ItemFiltros(
                                  item: state.data.status!.data!.filtros,
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 3,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                decoration: const BoxDecoration(
                                  color: mainColor,
                                ),
                                child: ItemCategorias(
                                  item: state.data.status!.data!.filtrosCate,
                                  filtro: filtro,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          for (final item
                              in state.data.status!.data!.biblioteca!.values)
                            if (item.title!
                                .toLowerCase()
                                .contains(searchTerm.toLowerCase()))
                              ItemBiblioteca(
                                item: item,
                                user: widget.user,
                                filter: filtro,
                                categoria: categoria,
                              ),
                        ],
                      ),
                    ),
                  );
                }

                if (state is BibliotecaChangeFilter ||
                    state is BibliotecaChangeCategoria) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      filtro = 'none';
                      bibliotecaBloc.add(
                        GetBibliotecaEvent(
                          user: widget.user!.userId,
                          token: widget.user!.token,
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
                            child: Text(
                              data!.status!.message.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                decoration: const BoxDecoration(
                                  color: mainColor,
                                ),
                                child: ItemFiltros(
                                  item: data!.status!.data!.filtros,
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 3,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                decoration: const BoxDecoration(
                                  color: mainColor,
                                ),
                                child: ItemCategorias(
                                  item: data!.status!.data!.filtrosCate,
                                  filtro: filtro,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          for (final item
                              in data!.status!.data!.biblioteca!.values)
                            if (item.title!
                                .toLowerCase()
                                .contains(searchTerm.toLowerCase()))
                              ItemBiblioteca(
                                item: item,
                                user: widget.user,
                                filter: filtro,
                                categoria: categoria,
                              ),
                        ],
                      ),
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
  }

  void _getDataBiblioteca() {
    final bibliotecaBloc = BlocProvider.of<BibliotecaBloc>(context);

    bibliotecaBloc.add(
      GetBibliotecaEvent(user: widget.user!.userId, token: widget.user!.token),
    );
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
                hintText: 'Buscar...',
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
    setState(() {
      searchTerm = title;
    });
  }
}
