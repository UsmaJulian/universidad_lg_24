// import 'dart:convert'; // Importa la biblioteca `dart:convert` para trabajar con JSON.
// // import 'package:http/http.dart'
//     // as http; // Importa la biblioteca `http` para hacer solicitudes HTTP.
// import 'package:universidad_lg_24/constants.dart'; // Importa las constantes definidas en el proyecto.
// import 'package:universidad_lg_24/home/models/home_model.dart'; // Importa el modelo `HomeModel`.
// import 'package:universidad_lg_24/users/exceptions/exceptions.dart'; // Importa las excepciones definidas en el proyecto.

/// Clase `HomeService` que maneja las solicitudes de la pantalla de inicio.
class HomeService {
  /// Método `servicegetHomeContent` que obtiene el contenido de inicio del servidor.
  ///
  /// Parámetros:
  /// - `userid`: ID del usuario que solicita el contenido.
  /// - `token`: Token de autenticación del usuario.
  ///
  /// Retorna un `Future` que resuelve en un `HomeModel` con los datos obtenidos.
  ///
  /// Lanza una excepción si hay un error en la solicitud o si la respuesta del servidor indica un error.
  // Future<HomeModel> servicegetHomeContent(String userid, String token) async {
  //   // Realiza una solicitud POST a la URL especificada con los headers y el cuerpo apropiados.
  //   final response = await http.post(
  //     Uri.https(baseUrl, 'app/load-home'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{
  //       'userId': userid,
  //       'token': token,
  //     }),
  //   );

  //   // Verifica si la solicitud fue exitosa (código de estado 200).
  //   if (response.statusCode == 200) {
  //     // Decodifica la respuesta JSON.
  //     final request = json.decode(response.body);

  //     // Verifica si el tipo de estado no es "error".
  //     if (request['response']['type'] != 'error') {
  //       // Crea un objeto `HomeModel` a partir de la respuesta JSON.
  //       final homeFJ = HomeModel.fromJson(
  //         json.decode(response.body) as Map<String, dynamic>,
  //       );
  //       return homeFJ;
  //     } else {
  //       // Lanza una excepción con el mensaje de error del servidor.
  //       throw request['status']['message'].toString();
  //     }
  //   } else {
  //     // Lanza una excepción de autenticación si el código de estado no es 200.
  //     throw AuthenticationException(message: 'Sin internet');
  //   }
  // }
}
