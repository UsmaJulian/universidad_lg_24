import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:string_extensions/string_extensions.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/users/blocs/login/login_bloc.dart';
import 'package:universidad_lg_24/users/views/therms/views/terminos_view.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  bool _autoValidate = false;
  bool isObscureText = true;
  bool _checkTherms = false;

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);

    onLoginButtonPressed() {
      if (_key.currentState!.validate()) {
        loginBloc.add(
          LoginInWithEmailButtonPressedEvent(
            email: _emailController.text,
            password: _passwordController.text,
          ),
        );
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
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
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
                    style: const TextStyle(
                      color: Colors.black,
                      decorationColor: Colors.black,
                    ),
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Correo Eletronico',
                      hintStyle: TextStyle(color: Colors.black),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: mainColor,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(),
                      icon: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                    ),
                    controller: _emailController,
                    autocorrect: false,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return '*Campo Requerido';
                      } else if (!value.isMail) {
                        return 'Ingresa con correo electronico valido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    cursorColor: Colors.black,
                    style: const TextStyle(
                      color: Colors.black,
                      decorationColor: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Contraseña',
                      hintStyle: const TextStyle(color: Colors.black),
                      focusedBorder: const UnderlineInputBorder(),
                      enabledBorder: const UnderlineInputBorder(),
                      icon: const Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isObscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            isObscureText = !isObscureText;
                          });
                          print(isObscureText);
                        },
                        color: Colors.black,
                      ),
                    ),
                    obscureText: isObscureText,
                    controller: _passwordController,
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
                  /* CheckboxFormField(
                    initialValue: false,
                    title: InkWell(
                      child: const Text(
                        'Polílicas de confidencialidad y privacidad',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(_terminosRoute());
                      },
                    ),
                    validator: (bool value) {
                      if (value == false) {
                        return '*Campo Requerido';
                      }
                      return null;
                    },
                  ), */
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: _checkTherms,
                        onChanged: (bool? value) {
                          setState(() {
                            _checkTherms = value!;
                          });
                        },
                        activeColor: mainColor,
                      ),
                      InkWell(
                        child: const Text(
                          'Políticas de confidencialidad y privacidad',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(_terminosRoute());
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: state is LoginLoadingState
                        ? () {}
                        : onLoginButtonPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Continuar',
                      style: TextStyle(color: Colors.white),
                    ),
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

  Route<Object?> _terminosRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const TerminosView(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0, 1);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
