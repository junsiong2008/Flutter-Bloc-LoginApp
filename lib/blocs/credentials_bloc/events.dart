import 'package:equatable/equatable.dart';

/// Events for the  CredentialBloc bloc
abstract class CredentialsEvent extends Equatable {
  /// The username
  final String username;

  /// The password
  final String password;

  /// Events fired by CredentialBloc when a button is pressed.
  /// It provides information taken from the form
  const CredentialsEvent(this.username, this.password);

  @override
  List<Object?> get props => [username, password];
}

/// Event fired when the login button is pressed
class LoginButtonPressed extends CredentialsEvent {
  const LoginButtonPressed({required String username, required String password})
      : super(username, password);
}

/// Events fired when the register button is tapped
class RegisterButtonPressed extends CredentialsEvent {
  const RegisterButtonPressed({
    required String username,
    required String password,
  }) : super(username, password);
}
