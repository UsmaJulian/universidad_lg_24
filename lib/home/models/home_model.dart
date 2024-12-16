// import 'dart:convert';

// /// Función que convierte un string en un objeto `HomeModel`
// ///
// /// Parámetros:
// /// - `str`: Una cadena JSON que representa un objeto `HomeModel`.
// ///
// /// Retorna un objeto `HomeModel` creado a partir del JSON decodificado.
// HomeModel welcomeFromJson(String str) =>
//     HomeModel.fromJson(json.decode(str) as Map<String, dynamic>);

// /// Función que convierte un objeto `HomeModel` a un string JSON.
// ///
// /// Parámetros:
// /// - `data`: Un objeto `HomeModel` que se convertirá a JSON.
// ///
// /// Retorna una cadena JSON que representa el objeto `HomeModel`.
// String welcomeToJson(HomeModel data) => json.encode(data.toJson());

// /// Clase `HomeModel` que representa el modelo de datos principal para la pantalla de inicio.
// class HomeModel {
//   /// Constructor de la clase `HomeModel`.
//   ///
//   /// Parámetros:
//   /// - `status`: Un objeto `Status` que contiene el estado del modelo.
//   HomeModel({
//     this.status,
//   });

//   /// Método de fábrica para crear una instancia de `HomeModel` a partir de un JSON.
//   ///
//   /// Parámetros:
//   /// - `json`: Un mapa que contiene los datos JSON.
//   ///
//   /// Retorna una instancia de `HomeModel`.
//   factory HomeModel.fromJson(Map<String, dynamic> json) {
//     if (json['status'] != null) {
//       return HomeModel(
//         status: Status.fromJson(
//           json['status'] as Map<String, dynamic>,
//         ),
//       );
//     } else {
//       return HomeModel();
//     }
//   }

//   /// Propiedad que contiene el estado del modelo.
//   Status? status;

//   /// Método que convierte una instancia de `HomeModel` a un mapa JSON.
//   ///
//   /// Retorna un mapa que representa el objeto `HomeModel`.
//   Map<String, dynamic> toJson() => {
//         'status': status?.toJson(),
//       };
// }

// /// Clase `Status` que representa el estado del modelo principal.
// class Status {
//   /// Constructor de la clase `Status`.
//   ///
//   /// Parámetros:
//   /// - `type`: Tipo de estado.
//   /// - `code`: Código de estado.
//   /// - `message`: Mensaje de estado.
//   /// - `carrucel`: Lista de objetos `Carrucel`.
//   /// - `noticias`: Lista de objetos `Noticias`.
//   Status({
//     this.type,
//     this.code,
//     this.message,
//     this.carrucel,
//     this.noticias,
//   });

//   /// Método de fábrica para crear una instancia de `Status` a partir de un JSON.
//   ///
//   /// Parámetros:
//   /// - `json`: Un mapa que contiene los datos JSON.
//   ///
//   /// Retorna una instancia de `Status`.
//   factory Status.fromJson(Map<String, dynamic> json) => Status(
//         type: json['type'].toString(),
//         code: int.parse(json['code'].toString()),
//         message: json['message'].toString(),
//         carrucel: List<dynamic>.from(json['carrucel'] as Iterable<dynamic>)
//             .map((x) => Carrucel.fromJson(x as Map<String, dynamic>))
//             .toList(),
//         noticias: List<dynamic>.from(json['noticias'] as Iterable<dynamic>)
//             .map((x) => Noticias.fromJson(x as Map<String, dynamic>))
//             .toList(),
//       );

//   /// Propiedad que contiene el tipo de estado.
//   String? type;

//   /// Propiedad que contiene el código de estado.
//   int? code;

//   /// Propiedad que contiene el mensaje de estado.
//   String? message;

//   /// Propiedad que contiene la lista de objetos `Carrucel`.
//   List<Carrucel>? carrucel;

//   /// Propiedad que contiene la lista de objetos `Noticias`.
//   List<Noticias>? noticias;

//   /// Método que convierte una instancia de `Status` a un mapa JSON.
//   ///
//   /// Retorna un mapa que representa el objeto `Status`.
//   Map<String, dynamic> toJson() => {
//         'type': type,
//         'code': code,
//         'message': message,
//         'carrucel': List<dynamic>.from(carrucel!.map((x) => x.toJson())),
//         'noticias': List<dynamic>.from(noticias!.map((x) => x.toJson())),
//       };
// }

// /// Clase `Carrucel` que representa un elemento del carrusel.
// class Carrucel {
//   /// Constructor de la clase `Carrucel`.
//   ///
//   /// Parámetros:
//   /// - `imagen`: URL de la imagen.
//   /// - `nid`: Identificador único.
//   /// - `title`: Título del elemento.
//   /// - `video`: URL del video (opcional).
//   /// - `lead`: Descripción breve del elemento.
//   Carrucel({
//     this.imagen,
//     this.nid,
//     this.title,
//     this.video,
//     this.lead,
//   });

//   /// Método de fábrica para crear una instancia de `Carrucel` a partir de un JSON.
//   ///
//   /// Parámetros:
//   /// - `json`: Un mapa que contiene los datos JSON.
//   ///
//   /// Retorna una instancia de `Carrucel`.
//   factory Carrucel.fromJson(Map<String, dynamic> json) => Carrucel(
//         imagen: json['imagen'].toString(),
//         nid: json['nid'].toString(),
//         title: json['title'].toString(),
//         video: json['video'].toString(),
//         lead: json['lead'].toString(),
//       );

//   /// Propiedad que contiene la URL de la imagen.
//   String? imagen;

//   /// Propiedad que contiene el identificador único.
//   String? nid;

//   /// Propiedad que contiene el título del elemento.
//   String? title;

//   /// Propiedad que contiene la URL del video.
//   String? video;

//   /// Propiedad que contiene la descripción breve del elemento.
//   String? lead;

//   /// Método que convierte una instancia de `Carrucel` a un mapa JSON.
//   ///
//   /// Retorna un mapa que representa el objeto `Carrucel`.
//   Map<String, dynamic> toJson() => {
//         'imagen': imagen,
//         'nid': nid,
//         'title': title,
//         'video': video,
//         'lead': lead,
//       };
// }

// /// Clase `Noticias` que representa una noticia.
// class Noticias {
//   /// Constructor de la clase `Noticias`.
//   ///
//   /// Parámetros:
//   /// - `imagen`: URL de la imagen.
//   /// - `nid`: Identificador único.
//   /// - `title`: Título de la noticia.
//   /// - `lead`: Descripción breve de la noticia.
//   Noticias({
//     this.imagen,
//     this.nid,
//     this.title,
//     this.lead,
//   });

//   /// Método de fábrica para crear una instancia de `Noticias` a partir de un JSON.
//   ///
//   /// Parámetros:
//   /// - `json`: Un mapa que contiene los datos JSON.
//   ///
//   /// Retorna una instancia de `Noticias`.
//   factory Noticias.fromJson(Map<String, dynamic> json) => Noticias(
//         imagen: json['imagen'].toString(),
//         nid: json['nid'].toString(),
//         title: json['title'].toString(),
//         lead: json['lead'].toString(),
//       );

//   /// Propiedad que contiene la URL de la imagen.
//   String? imagen;

//   /// Propiedad que contiene el identificador único.
//   String? nid;

//   /// Propiedad que contiene el título de la noticia.
//   String? title;

//   /// Propiedad que contiene la descripción breve de la noticia.
//   String? lead;

//   /// Método que convierte una instancia de `Noticias` a un mapa JSON.
//   ///
//   /// Retorna un mapa que representa el objeto `Noticias`.
//   Map<String, dynamic> toJson() => {
//         'imagen': imagen,
//         'nid': nid,
//         'title': title,
//         'lead': lead,
//       };
// }
