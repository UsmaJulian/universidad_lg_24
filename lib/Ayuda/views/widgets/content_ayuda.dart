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
  State<StatefulWidget> createState() => _ContentAyuda();
}

class _ContentAyuda extends State<ContentAyuda> {
  @override
  void initState() {
    super.initState();

    _getDataAyuda();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<AyudaBloc, AyudaState>(
        builder: (context, state) {
          final ayudaBloc = BlocProvider.of<AyudaBloc>(context);

          if (state is AyudaSuccess) {
            return SingleChildScrollView(
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
                    // dividerColor: mainColor,

                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        state.data.status?.data?[index].isExpanded =
                            !isExpanded;
                      });
                    },
                    children: state.data.status!.data!
                        .map<ExpansionPanel>((Datum item) {
                      return ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            minVerticalPadding: 8,
                            title: Text(
                              item.title.toString(),
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
                              item.bodyValue.toString(),
                            ),
                          ),
                        ),
                        isExpanded: item.isExpanded!,
                        canTapOnHeader: true,
                      );
                    }).toList(),
                  ),
                ],
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
      ),
    );
  }

  void _getDataAyuda() {
    BlocProvider.of<AyudaBloc>(context).add(
      GetAyudaEvent(user: widget.user!, token: widget.user!.token.toString()),
    );
  }
}
