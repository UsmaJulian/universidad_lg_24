import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/users/blocs/perfil/perfil_bloc.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/users/services/services.dart';

class FormPerfil extends StatefulWidget {
  const FormPerfil({super.key, this.user});
  final User? user;
  @override
  _FormPerfilState createState() => _FormPerfilState();
}

class _FormPerfilState extends State<FormPerfil> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool _autoValidate = false;
  final _documentoController = TextEditingController();
  final _celularController = TextEditingController();
  String image = '';

  @override
  void initState() {
    super.initState();
    get_data_form();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PerfilBloc, PerfilState>(
      builder: (context, state) {
        if (state is ChangeImage) {
          image = state.path;
        }
        return Form(
          key: _key,
          autovalidateMode: _autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: Column(
            children: [
              TextFormField(
                enabled: false,
                style: const TextStyle(color: Colors.black38),
                initialValue: widget.user!.name,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  labelStyle: TextStyle(color: mainColor),
                  // hintText: '',
                  disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: mainColor,
                    ),
                  ),
                ),
                autocorrect: false,
              ),
              TextFormField(
                style: const TextStyle(color: Colors.black38),
                enabled: false,
                initialValue: widget.user!.email,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  labelStyle: TextStyle(color: mainColor),
                  // hintText: '',
                  disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: mainColor,
                    ),
                  ),
                ),
                autocorrect: false,
              ),
              TextFormField(
                // initialValue: widget.user.documento,
                keyboardType: TextInputType.number,
                controller: _documentoController,
                decoration: const InputDecoration(
                  labelText: 'Documento',
                  labelStyle: TextStyle(color: mainColor),
                  // hintText: '',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: mainColor,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: mainColor,
                    ),
                  ),
                ),
                autocorrect: false,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return '*Campo Requerido';
                  }

                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                // initialValue: widget.user.celular,
                controller: _celularController,
                decoration: const InputDecoration(
                  labelText: 'Celular',
                  labelStyle: TextStyle(color: mainColor),
                  // hintText: '',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: mainColor,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: mainColor,
                    ),
                  ),
                ),
                autocorrect: false,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return '*Campo Requerido';
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: _onButtonPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                ),
                child: const Text(
                  'GUARDAR',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _onButtonPressed() async {
    if (_key.currentState!.validate()) {
      BlocProvider.of<PerfilBloc>(context).add(
        SendPerfilEvent(
          user: widget.user!.userId,
          token: widget.user!.token,
          documento: _documentoController.text,
          celular: _celularController.text,
          imagen: image,
        ),
      );
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  Future<void> get_data_form() async {
    final documento = await UserSecureStorage.getDocumento();
    final celular = await UserSecureStorage.getCelular();

    _documentoController.text = documento!;
    _celularController.text = celular!;
  }
}
