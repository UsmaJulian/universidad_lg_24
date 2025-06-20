import 'package:universidad_lg_24/app/views/app.dart';
import 'package:universidad_lg_24/bootstrap.dart';

/// The main entry point for the application.
///
/// This function initializes the application with the appropriate environment
/// based on the build configuration.
///
/// To run in development mode:
/// ```
/// flutter run -t lib/main.dart --dart-define=ENVIRONMENT=development
/// ```
///
/// To run in production mode (default):
/// ```
/// flutter run -t lib/main.dart
/// or
/// flutter build apk --release
/// ```
void main() async {
  // Get environment from compile-time constant or default to production
  const env = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'production',
  );

  // Initialize the app with the determined environment
  await bootstrap(
    environment:
        env == 'development' ? Environment.development : Environment.production,
    appBuilder: (context) => const App(),
  );
}
