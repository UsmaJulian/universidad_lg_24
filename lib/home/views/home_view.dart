// import 'package:flutter/material.dart'; // Importa el paquete Flutter para usar los widgets de Material Design.
// import 'package:universidad_lg_24/constants.dart'; // Importa las constantes definidas en el proyecto.
// import 'package:universidad_lg_24/home/widgets/widgets.dart'; // Importa los widgets utilizados en la pantalla de inicio.
// import 'package:universidad_lg_24/users/models/models.dart'; // Importa los modelos de usuario utilizados en el proyecto.
// import 'package:universidad_lg_24/widgets/widgets.dart'; // Importa otros widgets utilizados en el proyecto.

// /// `HomeView` es un widget que representa la pantalla principal
// ///  de la aplicación.
// ///
// /// Este widget es de tipo `StatelessWidget` ya que su contenido no cambia
// ///  una vez construido.
// /// Recibe un objeto `User` opcional que contiene la información del usuario
// ///  actual.
// class HomeView extends StatelessWidget {
//   const HomeView({super.key, this.user});

//   /// `user` es un parámetro opcional de tipo `User` que representa
//   ///  al usuario actual.
//   final User? user;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // Configura la AppBar de la pantalla principal
//       appBar: AppBar(
//         backgroundColor:
//             mainColor, // Establece el color de fondo de la AppBar usando
//         // `mainColor`.
//         title: const Center(
//           child: InkWell(
//             child: Image(
//               image: AssetImage(
//                 'assets/images/new_logo.png',
//               ), // Establece el logo en el centro de la AppBar.
//               height: 35,
//             ),
//           ),
//         ),
//         actions: [
//           Builder(
//             builder: (context) => IconButton(
//               onPressed: () {
//                 Scaffold.of(context)
//                     .openEndDrawer(); // Abre el endDrawer cuando se presiona
//                 // el icono.
//               },
//               icon: const Icon(Icons.person), // Establece el icono de persona.
//             ),
//           ),
//         ],
//       ),
//       backgroundColor: mainColor, // Establece el color de fondo de la pantalla
//       // usando `mainColor`.
//       drawer: DrawerMenuLeft(
//         user: user,
//         isHome: true, // Indica que el DrawerMenuLeft se está utilizando
//         // en la pantalla de inicio.
//       ),
//       endDrawer: DrawerMenuRight(
//         user: user,
//         isHome: true, // Indica que el DrawerMenuRight se está utilizando
//         // en la pantalla de inicio.
//       ),

//       // Configura el cuerpo de la pantalla principal
//       body: Builder(
//         builder: (context) => ColoredBox(
//           color: Colors
//               .white, // Establece el color de fondo del contenido a blanco.
//           child: HomeContent(
//             user: user, // Pasa el usuario actual al widget `HomeContent`.
//           ),
//         ),
//       ),
//     );
//   }
// }
