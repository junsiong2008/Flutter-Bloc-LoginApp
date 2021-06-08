// Inside 'repository/user_repository.dart'
abstract class UserRepository {
  ///Creates the repository for authenticating a user
  const UserRepository();

  /// Email of the signed user
  String get signedEmail;

  /// Login with username and password
  Future<bool> authenticate(String username, String password);

  /// Registration with email and password
  Future<bool> register(String username, String password);

  /// Logout
  Future<void> logOut();
}
