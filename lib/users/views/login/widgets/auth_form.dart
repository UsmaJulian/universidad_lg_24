import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universidad_lg_24/users/blocs/authentication/authentication_bloc.dart';
import 'package:universidad_lg_24/users/blocs/login/login_bloc.dart';
import 'package:universidad_lg_24/users/services/services.dart';
import 'package:universidad_lg_24/users/views/login/widgets/code_form.dart';
import 'package:universidad_lg_24/users/views/login/widgets/signIn_form.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';

class AuthForm extends StatelessWidget {
  const AuthForm({
    required this.isLogin,
    super.key,
  });
  final bool isLogin;
  @override
  Widget build(BuildContext context) {
    final authService = RepositoryProvider.of<AuthenticationService>(context);
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);

    final logo = Container(
      width: 200,
      margin: const EdgeInsets.only(bottom: 20),
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

    final form = isLogin ? const SignInForm() : const CodeForm();

    return SizedBox(
      child: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(authBloc, authService),
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
