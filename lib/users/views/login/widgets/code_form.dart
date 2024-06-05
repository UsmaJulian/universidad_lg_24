import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:string_extensions/string_extensions.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/users/blocs/authentication/authentication_bloc.dart';
import 'package:universidad_lg_24/users/blocs/login/login_bloc.dart';

class CodeForm extends StatefulWidget {
  const CodeForm({super.key});

  @override
  State<StatefulWidget> createState() => _CodeForm();
}

class _CodeForm extends State<CodeForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _codigodController = TextEditingController();
  bool _autoValidate = false;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    final codigoBloc = BlocProvider.of<LoginBloc>(context);
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);

    oncodigoButtonPressed() {
      if (_key.currentState!.validate()) {
        if (count > 2) {
          authBloc.add(UserLoggedOut());
          _showError('intentos maximos permitidos');
        } else {
          codigoBloc.add(
            CodigoValidateButtonPressedEvent(codigo: _codigodController.text),
          );
        }
      } else {
        setState(() {
          _autoValidate = true;
        });
      }
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailureState) {
          _showError(state.error);
          count++;
        } else {
          setState(() {
            _autoValidate = true;
          });
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        bloc: codigoBloc,
        builder: (context, state) {
          if (state is LoginLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: mainColor,
              ),
            );
          }
          return Form(
            key: _key,
            autovalidateMode: _autoValidate
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.center,
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      color: Colors.white,
                      decorationColor: Colors.white,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Ingresa tu Código',
                      hintStyle: TextStyle(color: Colors.white),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: mainColor,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    controller: _codigodController,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return '*Campo Requerido';
                      } else if (!value.isNumber && value.length != 4) {
                        return 'Ingrese un codigo  Correcto';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: state is LoginLoadingState
                        ? () {}
                        : oncodigoButtonPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      shape: const RoundedRectangleBorder(),
                    ),
                    child: const Text('Validar'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }
}
