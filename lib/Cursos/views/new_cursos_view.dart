import 'package:flutter/material.dart';
import 'package:universidad_lg_24/Cursos/views/categoria_cursos_view.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/widgets/global/bottom_app_bar_global.dart';
import 'package:universidad_lg_24/widgets/global/header_global.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';

class NewCursosView extends StatefulWidget {
  const NewCursosView({required this.user, super.key});
  final User user;
  @override
  State<NewCursosView> createState() => _NewCursosViewState();
}

class _NewCursosViewState extends State<NewCursosView> {
  final ScrollController controller = ScrollController();
  final cursosInfo = [
    {
      'image': 'assets/static/basico.png',
      'title': 'Básico',
      'description':
          'Aprende los fundamentos de LG y sus productos. Este curso cubre la historia de la marca, características básicas de los productos y técnicas iniciales de venta. Ideal para comenzar a interactuar con clientes de manera efectiva.',
      'query': 'basico',
    },
    {
      'image': 'assets/static/medio.jpg',
      'title': 'Intermedio',
      'description':
          'Desarrolla habilidades más avanzadas con detalles técnicos de los productos y técnicas de venta sofisticadas. Incluye estrategias de presentación, manejo de objeciones y servicio al cliente para mejorar la efectividad en el cierre de ventas.',
      'query': 'intermedio',
    },
    {
      'image': 'assets/static/avanzado.jpg',
      'title': 'Avanzado',
      'description':
          'Perfecciona tus habilidades con las últimas innovaciones y estrategias avanzadas. Enfocado en liderazgo, coaching, y análisis del rendimiento para optimizar las ventas y guiar a otros promotores.',
      'query': 'avanzado',
    }
  ];
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
        padding:
            const EdgeInsets.only(top: 148, right: 39, left: 39, bottom: 106),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Cursos',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                children: cursosInfo
                    .map(
                      (curso) => CursoCard(
                        user: widget.user,
                        image: curso['image'].toString(),
                        title: curso['title'].toString(),
                        description: curso['description'].toString(),
                        query: curso['query'].toString(),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomAppBar(),
    );
  }
}

class CursoCard extends StatelessWidget {
  const CursoCard({
    required this.image,
    required this.title,
    required this.description,
    required this.query,
    required this.user,
    super.key,
  });
  final User user;
  final String image;
  final String title;
  final String description;
  final String query;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          height: 423,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          description,
          textAlign: TextAlign.justify,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonMain(
              text: title,
              onPress: CategoriaCursosView(
                user: user,
                query: query,
                title: title,
              ),
              routeName: '/course/$title',
            ),
            //Botton Mail(),
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
      ],
    );
  }
}
