import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universidad_lg_24/home/views/home_view.dart';
import 'package:universidad_lg_24/users/blocs/authentication/authentication_bloc.dart';
import 'package:universidad_lg_24/users/views/login/widgets/widget.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            // print('$state login page');
            final authBloc = BlocProvider.of<AuthenticationBloc>(context);
            if (state is AuthenticationAuthenticatedState) {
              return HomeView(
                user: state.user,
              );
            }
            if (state is AuthenticationNotAuthenticatedState) {
              return const AuthForm(
                isLogin: true,
              );
            }
            if (state is AuthenticationNotCodeState) {
              return const AuthForm(isLogin: false);
            }

            if (state is AuthenticationFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(state.message),
                    TextButton(
                      child: const Text('Volver a intentar'),
                      onPressed: () {
                        authBloc.add(AppLoadedEvent());
                      },
                    ),
                  ],
                ),
              );
            }
            // return splash screen
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          },
        ),
      ),
    );
  }
}
