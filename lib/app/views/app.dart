import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universidad_lg_24/constants.dart';

import 'package:universidad_lg_24/home/views/globals.dart' as globals;
import 'package:universidad_lg_24/home/views/home_view.dart';
import 'package:universidad_lg_24/l10n/l10n.dart';

import 'package:universidad_lg_24/users/blocs/authentication/authentication_bloc.dart';
import 'package:universidad_lg_24/users/views/login/login_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      navigatorKey: globals.appNavigator,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticatedState) {
            // show home page
            return HomeView(
              user: state.user,
            );
          }
          // otherwise show login page

          if (state is AuthenticationAuthenticatedState) {
            return const LoginView();
          }
          if (state is AuthenticationNotCodeState) {
            return const LoginView();
          }
          // print(state);
          return const Center(
            child: CircularProgressIndicator(color: mainColor),
          );
        },
      ),
    );
  }
}
