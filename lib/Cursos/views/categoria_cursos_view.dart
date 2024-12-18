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
  final StreamController<List<dynamic>> _streamController = StreamController();
  final TextEditingController searchController = TextEditingController();
  final RefreshController _refreshController = RefreshController();

  String searchTerm = '';
  int _pager = 0;
  String? _selectedCategory;
  final List<String> _categories = [
    'LINEA ISP',
    'LINEA TV',
    'LINEA HA',
    'LINEA AV',
    'LINEA MC',
    'LINEA HE',
    'TECNICA DE VENTAS',
  ];

  List<dynamic> cursosData = [];

  @override
  void initState() {
    super.initState();
    _fetchCursosData();
  }

  Future<void> _fetchCursosData() async {
    try {
      final data = await CursosServices().serviceGetCursoCategoContent(
        widget.user.userId.toString(),
        widget.user.token.toString(),
        widget.query,
        _pager,
      );
      if (data != null && data is Map) {
        setState(() {
          cursosData.addAll(data.values.toList());
        });
        _streamController.add(cursosData);
      }
    } catch (e) {
      debugPrint('Error al obtener los cursos: $e');
      _streamController.addError(e);
    }
  }

  Future<void> _refreshData() async {
    try {
      _pager++;
      final data = await CursosServices().serviceGetCursoCategoContent(
        widget.user.userId.toString(),
        widget.user.token.toString(),
        widget.query,
        _pager,
      );
      if (data != null && data is Map) {
        setState(() {
          cursosData.addAll(data.values.toList());
        });
        _streamController.add(cursosData);
      }
      _refreshController.loadComplete();
    } catch (e) {
      debugPrint('Error al refrescar los datos: $e');
      _refreshController.loadFailed();
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
      endDrawer: DrawerMenu(user: widget.user, isHome: true),
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.17,
          right: 25,
          left: 25,
          bottom: 106,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            searchInput(),
            _buildCategoryDropdown(),
            Expanded(
              child: StreamBuilder<List<dynamic>>(
                stream: _streamController.stream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('No hay cursos disponibles'),
                    );
                  }

                  final filteredCursos = _filteredCursosData(snapshot.data!);

                  return SmartRefresher(
                    enablePullDown: false,
                    enablePullUp: true,
                    header: const WaterDropHeader(),
                    controller: _refreshController,
                    onLoading: _refreshData,
                    child: ListView.builder(
                      itemCount: filteredCursos.length,
                      itemBuilder: (context, index) {
                        return CursoCard(
                          curso: filteredCursos[index] as Map<dynamic, dynamic>,
                          user: widget.user,
                          title: widget.title,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
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
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              textAlign: TextAlign.center,
              onChanged: (value) => setState(() => searchTerm = value),
              decoration: const InputDecoration(
                hintText: 'Buscar',
                hintStyle: TextStyle(fontSize: 16, color: Color(0xff716F6A)),
                border: InputBorder.none,
              ),
            ),
          ),
          InkWell(
            onTap: () => setState(() => searchTerm = searchController.text),
            child: const Icon(Icons.search, color: Color(0xff716F6A)),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return Row(
      children: [
        OutlinedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Volver', style: TextStyle(color: Colors.black)),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: DropdownButtonFormField<String>(
            elevation: 16,
            dropdownColor: mainColor,
            decoration: const InputDecoration(
              fillColor: mainColor,
              filled: true,
              hintText: 'CATEGORÍAS',
              hintStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: mainColor),
              ),
            ),
            value: _selectedCategory,
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
            onChanged: (value) => setState(() => _selectedCategory = value),
          ),
        ),
      ],
    );
  }

  List<dynamic> _filteredCursosData(List<dynamic> data) {
    final categoryFilter =
        _selectedCategory != null && _selectedCategory != 'Todas'
            ? _mapCategoryToId(_selectedCategory!)
            : null;

    return data.where((curso) {
      final matchesCategory =
          categoryFilter == null || curso['categoria'] == categoryFilter;
      final matchesSearch = curso['title']
          .toString()
          .toLowerCase()
          .contains(searchTerm.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  String? _mapCategoryToId(String category) {
    switch (category) {
      case 'LINEA ISP':
        return '181';
      case 'LINEA TV':
        return '30';
      case 'LINEA HA':
        return '3';
      case 'LINEA AV':
        return '1';
      case 'LINEA MC':
        return '72';
      case 'LINEA HE':
        return '123';
      case 'TECNICA DE VENTAS':
        return '76';
      default:
        return null;
    }
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
