import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universidad_lg_24/Evaluaciones/bloc/ruleta_bloc/ruleta_bloc.dart';
import 'package:universidad_lg_24/Resuelvelo/loading_bloc/loading_bloc.dart';
import 'package:universidad_lg_24/home/views/globals.dart' as globals;
import 'package:universidad_lg_24/users/blocs/authentication/authentication_bloc.dart';
import 'package:universidad_lg_24/users/services/services.dart';

/// Represents the different environments the app can run in.
enum Environment {
  /// Development environment with debug tools enabled
  development,

  /// Production environment with optimizations
  production,
}

/// Configuration class that holds environment-specific settings
class AppConfig {
  const AppConfig({
    required this.environment,
    required this.appName,
    this.enableLogging = false,
    this.enableErrorReporting = false,
  });
  final Environment environment;
  final String appName;
  final bool enableLogging;
  final bool enableErrorReporting;

  bool get isDevelopment => environment == Environment.development;
  bool get isProduction => environment == Environment.production;
}

/// Custom BLoC observer that logs state changes and errors
class AppBlocObserver extends BlocObserver {
  const AppBlocObserver({this.enableLogging = false});
  final bool enableLogging;

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    if (enableLogging) {
      developer.log('BLoC Created: ${bloc.runtimeType}');
    }
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    if (enableLogging) {
      developer.log('Event: ${bloc.runtimeType} > ${event.runtimeType}');
    }
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (enableLogging) {
      developer.log('State change: ${bloc.runtimeType} > $change');
    }
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    developer.log(
      'BLoC Error in ${bloc.runtimeType}: $error',
      error: error,
      stackTrace: stackTrace,
    );
    super.onError(bloc, error, stackTrace);
  }
}

/// Global error handler for Flutter framework errors
void _setupErrorHandling(AppConfig config) {
  final logErrors = config.enableLogging;

  // Handle Flutter framework errors
  FlutterError.onError = (details) {
    FlutterError.presentError(details);

    if (logErrors) {
      developer.log(
        'Flutter Error: ${details.exception}',
        error: details.exception,
        stackTrace: details.stack,
        level: 2000, // Error level
      );
    }

    // In production, you might want to report this to a service like Sentry or Firebase Crashlytics
    if (config.enableErrorReporting) {
      // TODO: Implement error reporting service integration
    }
  };

  // Handle uncaught errors
  PlatformDispatcher.instance.onError = (error, stack) {
    if (logErrors) {
      developer.log(
        'Uncaught Error: $error',
        error: error,
        stackTrace: stack,
        level: 2000, // Error level
      );
    }

    // In production, report the error
    if (config.enableErrorReporting) {
      // TODO: Implement error reporting service integration
    }

    return true; // Prevent the error from being thrown again
  };
}

/// Bootstrap the application with the given environment and configuration
///
/// [environment]: The environment to run the app in (development/production)
/// [appBuilder]: A builder function that creates the root widget of the app
Future<void> bootstrap({
  required Environment environment,
  required Widget Function(BuildContext) appBuilder,
}) async {
  // Initialize app configuration based on environment
  final config = _getConfigForEnvironment(environment);

  // Set up error handling and logging
  _setupErrorHandling(config);

  // Initialize BLoC observer with appropriate logging level
  Bloc.observer = AppBlocObserver(enableLogging: config.enableLogging);

  // Enable performance profiling in debug mode
  if (config.isDevelopment) {
    debugProfileBuildsEnabled = true;
    debugProfileBuildsEnabledUserWidgets = true;
  }

  // Run the app with proper error boundaries
  runZonedGuarded(
    () => runApp(
      RepositoryProvider<AuthenticationService>(
        create: (context) => IsAuthenticationService(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthenticationBloc>(
              create: (context) {
                globals.appNavigator = GlobalKey<NavigatorState>();
                final authService =
                    RepositoryProvider.of<AuthenticationService>(context);
                return AuthenticationBloc(authService)..add(AppLoadedEvent());
              },
            ),
            BlocProvider<LoadingBloc>(
              create: (_) => LoadingBloc(),
            ),
            BlocProvider<RuletaBloc>(
              create: (_) => RuletaBloc(),
            ),
          ],
          child: Builder(builder: appBuilder),
        ),
      ),
    ),
    (error, stackTrace) {
      // Handle any uncaught errors
      developer.log(
        'Uncaught Error in runZonedGuarded',
        error: error,
        stackTrace: stackTrace,
        level: 2000, // Error level
      );

      if (config.enableErrorReporting) {
        // TODO: Report error to your error tracking service
      }
    },
  );
}

/// Returns the appropriate configuration based on the environment
AppConfig _getConfigForEnvironment(Environment environment) {
  switch (environment) {
    case Environment.development:
      return AppConfig(
        environment: environment,
        appName: 'Universidad LG (Dev)',
        enableLogging: true,
      );
    case Environment.production:
      return AppConfig(
        environment: environment,
        appName: 'Universidad LG',
        enableErrorReporting: true,
      );
  }
}
