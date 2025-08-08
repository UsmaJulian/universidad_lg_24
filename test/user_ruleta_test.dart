import 'package:flutter_test/flutter_test.dart';
import 'package:universidad_lg_24/users/models/user.dart';

void main() {
  group('User userRuleta Tests', () {
    test('User constructor should accept userRuleta parameter', () {
      final user = User(
        name: 'Test User',
        email: 'test@test.com',
        userId: 'test123',
        token: 'testToken',
        userRuleta: 1,
      );

      expect(user.userRuleta, equals(1));
      expect(user.userRuleta, isNotNull);
    });

    test('User with null userRuleta should handle gracefully', () {
      final user = User(
        name: 'Test User',
        email: 'test@test.com',
        userId: 'test123',
        token: 'testToken',
      );

      expect(user.userRuleta, isNull);
    });

    test('User toString should include userRuleta', () {
      final user = User(
        name: 'Test User',
        email: 'test@test.com',
        userId: 'test123',
        token: 'testToken',
        userRuleta: 1,
      );

      final userString = user.toString();
      expect(userString, contains('userRuleta: 1'));
    });
  });
}
