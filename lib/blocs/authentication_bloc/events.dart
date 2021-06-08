import 'package:equatable/equatable.dart';

/// Events for the AuthenticationBloc bloc
abstract class AuthenticationEvent extends Equatable {
  /// Base class for events fired by AuthenticationBloc
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

/// User logged in with success
class LoggedIn extends AuthenticationEvent {
  const LoggedIn();
}

/// User requested to log out
class LoggedOut extends AuthenticationEvent {
  const LoggedOut();
}
