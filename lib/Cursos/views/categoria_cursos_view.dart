import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:universidad_lg_24/Cursos/services/cursos_services.dart';
import 'package:universidad_lg_24/Cursos/views/new_curso_single_view.dart';
import 'package:universidad_lg_24/constants.dart';

import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/widgets/global/bottom_app_bar_global.dart';
import 'package:universidad_lg_24/widgets/global/header_global.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';

class CategoriaCursosView extends StatefulWidget {
  const CategoriaCursosView({
    required this.user,
    required this.query,
    required this.title,
    super.key,
  });
  final User user;
  final String query;
  final String title;

  @override
  State<CategoriaCursosView> createState() => _CategoriaCursosViewState();
}

class _CategoriaCursosViewState extends State<CategoriaCursosView> {
  final StreamController<dynamic> _streamController = StreamController();
  TextEditingController searchController = TextEditingController();
  final RefreshController _refreshController = RefreshController();
  String searchTerm = '';
  int _pager = 0;

  String? _selectedCategory; // Categoría seleccionada
  final List<String> _categories = [
    'LINEA ISP',
    'LINEA TV',
    'LINEA HA',
    'LINEA AV',
    'LINEA MC',
    'LINEA HE',
    'TECNICA DE VENTAS',
  ]; // Lista de categorías

  Map<dynamic, dynamic>? cursosData;
  @override
  void initState() {
    super.initState();
    getCursosData();
  }

  Future<void> getCursosData() async {
    final stringCursoData = await CursosServices().serviceGetCursoCategoContent(
      widget.user.userId.toString(),
      widget.user.token.toString(),
      widget.query,
      _pager,
    );
    cursosData = stringCursoData as Map<dynamic, dynamic>;

    setState(() {});
  }

  Future<void> _refreshData() async {
    try {
      debugPrint('refrescando');
      final data = await CursosServices().serviceGetCursoCategoContent(
        widget.user.userId.toString(),
        widget.user.token.toString(),
        widget.query,
        _pager++,
      );

      _streamController.add(data);
      _refreshController.loadComplete();
    } catch (e) {
      _streamController.addError(e);
    }
  }

  @override
  void dispose() {
    _streamController.close();
    searchController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: const Color(0xffF6F3EB),
      appBar: CustomAppBar(user: widget.user),
      endDrawer: DrawerMenu(
        user: widget.user,
        isHome: true, // Indica que el DrawerMenuLeft se está utilizando
        // en la pantalla de inicio.
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.17,
          right: 25,
          left: 25,
          bottom: 106,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              searchInput(),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      bottom: 10,
                      top: 10,
                    ),
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Volver',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    // DropdownButtonFormField para el filtro de categorías
                    child: DropdownButtonFormField<String>(
                      // isExpanded: true,
                      elevation: 16,

                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                      dropdownColor: mainColor,
                      decoration: const InputDecoration(
                        fillColor: mainColor,
                        filled: true,
                        hintText: 'CATEGORÍAS',
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: mainColor, width: 0),
                        ),
                      ),
                      value: _selectedCategory, // Categoría seleccionada
                      items: _categories
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                category,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                    ),
                  ),
                ],
              ),

              // if (cursosData != null)
              //   for (final curso in cursosData!.values)
              //     if (curso['title']
              //         .toString()
              //         .toLowerCase()
              //         .contains(searchTerm.toLowerCase()))
              //       CursoCard(
              //         curso: curso as Map<dynamic, dynamic>,
              //         user: widget.user,
              //         title: widget.title,
              //       ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: SmartRefresher(
                  enablePullDown: false,
                  enablePullUp: true,
                  header: const WaterDropHeader(),
                  controller: _refreshController,
                  onLoading: _refreshData,
                  child: ListView.builder(
                    itemCount: _filteredCursosData().length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return CursoCard(
                        curso: _filteredCursosData()[index]
                            as Map<dynamic, dynamic>,
                        user: widget.user,
                        title: widget.title,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomAppBar(),
    );
  }

  Widget searchInput() {
    return Container(
      margin: EdgeInsets.zero,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: Color(0xffE6E1D6),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: searchController,
              textAlign: TextAlign.center,
              onChanged: (String value) async {
                search(value);
              },
              decoration: const InputDecoration(
                hintText: 'Buscar',
                hintStyle: TextStyle(fontSize: 16, color: Color(0xff716F6A)),
                border: InputBorder.none,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              search(searchController.text);
              // print(searchController.text);
            },
            child: const SizedBox(
              child: Icon(Icons.search, color: Color(0xff716F6A)),
            ),
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

  List<dynamic> _filteredCursosData() {
    if (_selectedCategory == null || _selectedCategory == 'Todas') {
      return cursosData?.values.toList() ?? [];
    }
    String? seleccion;
    switch (_selectedCategory) {
      case 'LINEA ISP':
        seleccion = '181';
      case 'LINEA TV':
        seleccion = '30';
      case 'LINEA HA':
        seleccion = '3';
      case 'LINEA AV':
        seleccion = '1';
      case 'LINEA MC':
        seleccion = '72';
      case 'LINEA HE':
        seleccion = '123';
      case 'TECNICA DE VENTAS':
        seleccion = '76';
    }

    return cursosData?.values
            .where(
              (curso) => curso['categoria']?.toString() == seleccion,
            )
            .toList() ??
        [];
  }
}

class CursoCard extends StatelessWidget {
  const CursoCard({
    required this.curso,
    required this.user,
    required this.title,
    super.key,
  });
  final Map<dynamic, dynamic> curso;
  final User user;
  final String title;

  @override
  Widget build(BuildContext context) {
    // myLongPrint('cursosData: $curso');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            curso['imagen'].toString(),
            width: 351,
            height: 351,
          ),
        ),
        Text(
          'Nivel $title',
          style: const TextStyle(
            fontSize: 34,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 290,
              child: Text(
                curso['title'].toString(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // GestureDetector(
            //   child: Container(
            //     padding: const EdgeInsets.all(10),
            //     decoration: BoxDecoration(
            //       color: footerColor,
            //       borderRadius: BorderRadius.circular(100),
            //     ),
            //     child: const Icon(
            //       Icons.mail_outline,
            //       color: Colors.white,
            //     ),
            //   ),
            //   onTap: () {},
            // ),
          ],
        ),
        HtmlWidget(
          curso['body'].toString(),
          textStyle: const TextStyle(
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 26),
        ButtonMain(
          text: 'Ver Curso',
          onPress: NewCursoSingleView(user: user, nid: curso['nid'].toString()),
          routeName: '/singleCourse/nivel/$title',
        ),
        const SizedBox(height: 20),
        Divider(
          color: Colors.grey[350],
          thickness: 1,
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
