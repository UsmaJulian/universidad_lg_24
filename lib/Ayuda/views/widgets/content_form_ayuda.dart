import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universidad_lg_24/Ayuda/blocs/formulario/formulario_bloc.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/users/models/models.dart';

class ContentFormAyuda extends StatefulWidget {
  const ContentFormAyuda({super.key, this.user});
  final User? user;

  @override
  State<StatefulWidget> createState() => _ContentFormAyuda();
}

class _ContentFormAyuda extends State<ContentFormAyuda> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<dynamic>> _keySelect =
      GlobalKey<FormFieldState<dynamic>>();

  final _preguntaController = TextEditingController();
  bool _autoValidate = false;
  String? dropdownValue;

  List<Map<String, String>> values = [
    {'label': 'General', 'value': '28'},
    {'label': 'Lavadoras', 'value': '14'},
    {'label': 'Microondas', 'value': '19'},
    {'label': 'Televisores', 'value': '10'},
  ];

  @override
  Widget build(BuildContext context) {
    oncodigoButtonPressed() {
      if (_key.currentState!.validate()) {
        final formBlock = BlocProvider.of<FormularioBloc>(context);
        formBlock.add(
          SendFormularioAyudaEvent(
            user: widget.user!.userId,
            token: widget.user!.token,
            tema: dropdownValue,
            pregunta: _preguntaController.text,
          ),
        );
        _key.currentState!.reset();
        _keySelect.currentState!.reset();
      } else {
        setState(() {
          _autoValidate = true;
        });
      }
    }

    return BlocListener<FormularioBloc, FormularioState>(
      listener: (context, state) {
        print(state);
        if (state is FormularioayudaSuccess) {
          _showResponse(state.message);
        }
        if (state is FormularioayudaError) {
          _showResponse(state.message);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: BlocBuilder<FormularioBloc, FormularioState>(
          builder: (context, state) {
            if (state is FormularioayudaLoad) {
              return const Center(
                child: CircularProgressIndicator(
                  color: mainColor,
                ),
              );
            }

            return SingleChildScrollView(
              child: Form(
                key: _key,
                autovalidateMode: _autoValidate
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: Column(
                  children: [
                    DropdownButtonFormField(
                      key: _keySelect,
                      value: dropdownValue,
                      hint: const Text(
                        'Temas',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return '*Campo Requerido';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: mainColor,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: mainColor),
                        ),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items: values.map((map) {
                        return DropdownMenuItem<String>(
                          value: map['value'].toString(),
                          child: Text(map['label'].toString()),
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      maxLines: 8,
                      controller: _preguntaController,
                      decoration: const InputDecoration(
                        hintText: 'Pregunta',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: mainColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: secondColor),
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
                      onPressed: oncodigoButtonPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        shape: const RoundedRectangleBorder(),
                      ),
                      child: const Text('ENVIAR'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showResponse(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: mainColor,
      ),
    );
  }
}
