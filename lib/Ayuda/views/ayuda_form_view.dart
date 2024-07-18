import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universidad_lg_24/Ayuda/blocs/formulario/formulario_bloc.dart';
import 'package:universidad_lg_24/Ayuda/services/form_ayuda_service.dart';
import 'package:universidad_lg_24/Ayuda/views/widgets/widgets.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/users/models/models.dart';

class AyudaFormView extends StatelessWidget {
  const AyudaFormView({super.key, this.user});
  final User? user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FORMULA TU RESPUESTA',
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: bgColor,
      ),
      body: BlocProvider<FormularioBloc>(
        create: (context) => FormularioBloc(service: IsFormAyudaService()),
        child: ContentFormAyuda(
          user: user,
        ),
      ),
    );
  }
}
