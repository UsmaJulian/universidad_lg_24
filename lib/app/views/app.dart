import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universidad_lg_24/Home/views/new_home_view.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/home/views/globals.dart' as globals;
import 'package:universidad_lg_24/l10n/l10n.dart';
import 'package:universidad_lg_24/users/blocs/authentication/authentication_bloc.dart';
import 'package:universidad_lg_24/users/views/login/login_view.dart';

/// La clase [App] representa la aplicación principal.
/// Extiende [StatelessWidget] ya que no mantiene ningún estado interno.
class App extends StatelessWidget {
  /// Constructor para la clase [App].
  const App({super.key});

  /// Construye el widget [App] que configura el [MaterialApp] principal.
  /// Configura el tema, las localizaciones y la lógica de autenticación.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Oculta el banner de modo debug
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context)
              .colorScheme
              .inversePrimary, // Color de fondo de la AppBar
        ),
        useMaterial3: true, // Habilita el uso de Material Design 3
      ),

      localizationsDelegates:
          AppLocalizations.localizationsDelegates, // Delegados de localización
      supportedLocales: AppLocalizations.supportedLocales, // Locales soportados
      navigatorKey: globals.appNavigator, // Clave del navegador global
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticatedState) {
            // Si el usuario está autenticado, mostrar la vista de inicio
            /* return HomeView(
              user: state.user,
            ); */
            return NewHomeView(user: state.user);
          } else if (state is AuthenticationNotAuthenticatedState ||
              state is AuthenticationInitialState ||
              state is AuthenticationNotCodeState) {
            // Si el usuario no está autenticado, mostrar la vista de login
            return const LoginView();
          }

          // Mostrar un indicador de progreso mientras se determina el estado de autenticación
          return const Center(
            child: CircularProgressIndicator(color: mainColor),
          );
        },
      ),
    );
  }
}
