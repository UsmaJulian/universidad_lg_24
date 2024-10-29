import 'package:flutter/material.dart'; // Importa el paquete Flutter para usar los widgets de Material Design.

/// Declaración de una variable global `appNavigator` de tipo `GlobalKey<NavigatorState>`.
///
/// `GlobalKey` es una llave global que se puede usar para identificar de forma única un widget en el árbol de widgets.
///
/// `NavigatorState` es el estado asociado con un widget `Navigator`, que se usa para manejar la navegación de rutas en la aplicación.
///
/// Esta variable `appNavigator` puede ser utilizada para acceder al estado del `Navigator` desde cualquier lugar de la aplicación,
/// permitiendo controlar la navegación (por ejemplo, empujar o sacar rutas) sin necesidad de un contexto de Build.
///
/// Ejemplo de uso:
/// ```dart
/// appNavigator?.currentState?.pushNamed('/ruta');
/// ```
///
/// Nota: La variable `appNavigator` es declarada como nullable (puede ser nula), por eso el uso de `?`.
GlobalKey<NavigatorState>? appNavigator;
