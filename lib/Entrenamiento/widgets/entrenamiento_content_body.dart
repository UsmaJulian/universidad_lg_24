import 'package:flutter/material.dart';
import 'package:universidad_lg_24/Entrenamiento/models/models.dart';
import 'package:universidad_lg_24/Entrenamiento/widgets/widgets.dart';

import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/users/models/models.dart';

class EntrenamientoContentBody extends StatefulWidget {
  const EntrenamientoContentBody({
    required this.user,
    super.key,
    this.entrenamientoInfo,
  });
  final User user;
  final EntrenamientoModel? entrenamientoInfo;

  @override
  _EntrenamientoContentBodyState createState() =>
      _EntrenamientoContentBodyState();
}

class _EntrenamientoContentBodyState extends State<EntrenamientoContentBody> {
  TextEditingController searchController = TextEditingController();

  String searchTerm = '';
  int filtro = 0;

  String? dropdownValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropdownValue = widget.entrenamientoInfo?.status?.filtros?[0].tid;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 50),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: const Text(
                  'ENTRENAMIENTO',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Expanded(
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      const TabBar(
                        unselectedLabelColor: mainColor,
                        labelColor: Colors.black54,
                        indicatorColor: mainColor,
                        tabs: [
                          Tab(text: 'BÁSICO'),
                          Tab(text: 'INTERMEDIO'),
                          Tab(text: 'AVANZADO'),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        decoration: const BoxDecoration(color: mainColor),
                        width: double.infinity,
                        child: DropdownButtonFormField<String>(
                          value: dropdownValue,
                          isExpanded: true,
                          elevation: 16,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          ),
                          dropdownColor: mainColor,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue;

                              filtro = int.parse(newValue!);
                            });
                          },
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: mainColor, width: 0),
                            ),
                            // hintText: Text('sss');
                          ),
                          items: widget.entrenamientoInfo?.status?.filtros
                              ?.map((e) {
                            return DropdownMenuItem<String>(
                              value: e.tid,
                              child: Text(
                                e.name.toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: <Widget>[
                            EntrenamientoContentType(
                              data: widget
                                  .entrenamientoInfo?.status?.cursos?.basico,
                              filtro: filtro,
                              user: widget.user,
                              searchTerm: searchTerm,
                            ),
                            //
                            EntrenamientoContentType(
                              data: widget.entrenamientoInfo?.status?.cursos
                                  ?.intermedio,
                              filtro: filtro,
                              user: widget.user,
                              searchTerm: searchTerm,
                            ),
                            EntrenamientoContentType(
                              data: widget
                                  .entrenamientoInfo?.status?.cursos?.avanzado,
                              filtro: filtro,
                              searchTerm: searchTerm,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
            offset: Offset(0, 1),
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

  void search(String value) {
    setState(() {
      searchTerm = value;
    });
  }
}
