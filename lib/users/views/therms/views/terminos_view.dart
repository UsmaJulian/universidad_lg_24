import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:universidad_lg_24/constants.dart';

class TerminosView extends StatelessWidget {
  const TerminosView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'POLÍTICAS DE CONFIDENCIALIDAD Y PRIVACIDAD',
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: mainColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: const HtmlWidget(
          '<p>Al hacer click y aceptar, usted en calidad de usuario declara tener pleno conocimiento, aceptar y obligarse a cumplir los siguientes los t&eacute;rminos y condiciones de privacidad y protecci&oacute;n de informaci&oacute;n, contenida, recogida y difundida en la aplicaci&oacute;n Universidad LG</p><p>&bull; El usuario se obliga a no compartir con terceros, bajo ninguna forma, modo o circunstancia el c&oacute;digo de usuario designado y contrase&ntilde;a de acceso a la aplicaci&oacute;n Universidad LG.</p><p>&bull; El usuario se compromete a hacer un uso correcto de la informaci&oacute;n contenida en la aplicaci&oacute;n Universidad LG, as&iacute; como a no compartir, bajo ninguna forma, modo o circunstancia, informaci&oacute;n de im&aacute;genes, documentos, evaluaciones, contrase&ntilde;as y/o videos que se expongan o utilicen en la aplicaci&oacute;n Universidad LG.</p><p>&bull; El usuario es responsable de los da&ntilde;os y perjuicios que cause a LG Electronics Per&uacute; S.A. por el incumplimiento de los t&eacute;rminos aceptados.</p>',
        ),
      ),
    );
  }
}
