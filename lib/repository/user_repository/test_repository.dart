import 'package:loginapp/repository/user_repository.dart';

/// Inside 'repository/user_repository/test_repository.dart'
class TestUserRepository extends UserRepository {
  /// The email of the user
  final String fakeEmail;

  /// Determines whether the methods will fail or not
  final bool succ;

  /// Mock authentication repository (for testing)
  const TestUserRepository({
    required this.fakeEmail,
    required this.succ,
  });

  @override
  Future<bool> authenticate(String username, String password) {
    return Future<bool>.delayed(const Duration(seconds: 1), () => succ);
  }

  @override
  Future<bool> register(String username, String password) {
    return Future<bool>.delayed(const Duration(seconds: 1), () => succ);
  }

  @override
  Future<void> logOut() => Future.delayed(Duration(seconds: 2));

  @override
  String get signedEmail => fakeEmail;
}
