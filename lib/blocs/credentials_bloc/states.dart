import 'package:equatable/equatable.dart';

/// States emitted by CredentialsBloc
abstract class CredentialsState extends Equatable {
  /// States emitted by CredentialBloc when the form is created
  const CredentialsState();

  @override
  List<Object?> get props => [];
}

/// Action required (authentication or registration)
class CredentialsInitial extends CredentialsState {
  const CredentialsInitial();
}

/// Login request awaiting for response
class CredentialsLoginLoading extends CredentialsState {
  const CredentialsLoginLoading();
}

/// Registration request awaitng for response
class CredentialsRegisterLoading extends CredentialsState {
  const CredentialsRegisterLoading();
}

/// Invalid authentication credentials
class CredentialsLoginFailure extends CredentialsState {
  const CredentialsLoginFailure();
}

/// Weak password or invalid email
class CredentialsRegisterFailure extends CredentialsState {
  const CredentialsRegisterFailure();
}
