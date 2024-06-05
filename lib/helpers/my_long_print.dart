import 'package:flutter/material.dart';

/// La función [myLongPrint] se utiliza para imprimir cadenas largas en la consola de depuración.
/// Debido a las limitaciones de longitud en la salida de `debugPrint`, esta función divide la cadena en fragmentos de 1000 caracteres y los imprime secuencialmente.
///
/// Parámetros:
/// - `input`: Cualquier tipo de entrada que se convertirá en una cadena para ser impresa.
///
/// Ejemplo de uso:
/// ```dart
/// myLongPrint('Una cadena muy larga...');
/// ```
///
/// Si la cadena es más corta o igual a 1000 caracteres, se imprime directamente.
/// Si es más larga, se divide en fragmentos de 1000 caracteres y cada fragmento se imprime secuencialmente.
void myLongPrint(dynamic input) {
  // Convertir la entrada a una cadena
  var str = input.toString();

  // Imprimir cada fragmento de 1000 caracteres secuencialmente
  while (str.length > 1000) {
    debugPrint(str.substring(0, 1000)); // Imprimir los primeros 1000 caracteres

    // Eliminar los primeros 1000 caracteres de la cadena
    str = str.substring(1000);
  }

  // Imprimir los caracteres restantes
  debugPrint(str);
}
