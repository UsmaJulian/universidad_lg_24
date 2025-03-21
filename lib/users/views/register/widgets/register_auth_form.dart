import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universidad_lg_24/users/blocs/authentication/authentication_bloc.dart';
import 'package:universidad_lg_24/users/blocs/register/register_bloc.dart';
import 'package:universidad_lg_24/users/services/authentication_service.dart';
import 'package:universidad_lg_24/users/views/register/widgets/sign_up_form.dart';
import 'package:universidad_lg_24/widgets/background_image.dart';

class RegisterAuthForm extends StatelessWidget {
  const RegisterAuthForm({
    required this.isRegister,
    super.key,
  });
  final bool isRegister;
  @override
  Widget build(BuildContext context) {
    final authService = RepositoryProvider.of<AuthenticationService>(context);
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    final logo = Container(
      width: 200,
      decoration: const BoxDecoration(
          // border: Border
          ),
      child: const Image(
        image: AssetImage(
          'assets/images/logo-new2.png',
        ),
      ),
    );

    final titulo = Container(
      margin: const EdgeInsets.only(
        bottom: 30,
      ),
      child: const Text(
        'Universidad LG',
        style: TextStyle(
          color: Colors.black,
          fontSize: 25,
        ),
      ),
    );

    // final form = isRegister ? const SignUpForm() : const CodeForm();
    const form = SignUpForm();

    return SizedBox(
      child: BlocProvider<RegisterBloc>(
        create: (context) => RegisterBloc(
          authBloc,
          authenticationBloc: authBloc,
          authenticationService: authService,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            BackgroundImage(
              image: 'assets/images/IMG_3719.PNG',
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin:
                        const EdgeInsets.only(left: 30, right: 30, bottom: 290),
                    child: Column(
                      children: [
                        logo,
                        titulo,
                        form,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
