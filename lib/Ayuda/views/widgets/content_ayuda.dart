import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:universidad_lg_24/Ayuda/blocs/ayuda/ayuda_bloc.dart';
import 'package:universidad_lg_24/Ayuda/models/ayuda_model.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/users/models/models.dart';

class ContentAyuda extends StatefulWidget {
  const ContentAyuda({super.key, this.user});
  final User? user;

  @override
  State<ContentAyuda> createState() => _ContentAyudaState();
}

class _ContentAyudaState extends State<ContentAyuda> {
  List<Datum>? _items; // Lista local para gestionar la expansión
  bool expanded = false;
  @override
  void initState() {
    super.initState();
    _getDataAyuda();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AyudaBloc, AyudaState>(
      builder: (context, state) {
        final ayudaBloc = BlocProvider.of<AyudaBloc>(context);

        if (state is AyudaSuccess) {
          // Inicializar la lista local con los datos del estado si es la primera vez
          _items ??= state.data.status?.data ?? [];

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.1,
              ),
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
                      'AYUDA',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  ExpansionPanelList(
                    elevation: 0,
                    expansionCallback: (int index, bool isExpanded) {
                      if (expanded == false) {
                        expanded = true;
                      } else {
                        expanded = false;
                      }

                      print('isExpanded: $expanded');
                      setState(() {
                        _items![index].isExpanded = expanded;
                      });
                    },
                    children: _items!.map<ExpansionPanel>((Datum item) {
                      return ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            minVerticalPadding: 8,
                            title: Text(
                              item.title ?? '',
                              style: const TextStyle(height: 1.15),
                            ),
                          );
                        },
                        body: ListTile(
                          contentPadding: const EdgeInsets.symmetric(),
                          title: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: mainColor),
                              ),
                            ),
                            child: HtmlWidget(
                              item.bodyValue ?? '',
                            ),
                          ),
                        ),
                        isExpanded: item.isExpanded ?? false,
                        canTapOnHeader: true,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is ErrorAyuda) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(state.message),
                TextButton(
                  child: const Text('Volver a intentar'),
                  onPressed: () {
                    ayudaBloc.add(
                      GetAyudaEvent(
                        token: widget.user!.token.toString(),
                        user: widget.user!,
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
    );
  }

  void _getDataAyuda() {
    BlocProvider.of<AyudaBloc>(context).add(
      GetAyudaEvent(user: widget.user!, token: widget.user!.token.toString()),
    );
  }
}
