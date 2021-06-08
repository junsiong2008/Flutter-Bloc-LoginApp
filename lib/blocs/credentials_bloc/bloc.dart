import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginapp/blocs/authentication_bloc.dart';
import 'package:loginapp/blocs/credentials_bloc/states.dart';
import 'package:loginapp/blocs/credentials_bloc/events.dart';
import 'package:loginapp/repository/user_repository.dart';

/// Manages the login state of the app
class CredentialsBloc extends Bloc<CredentialsEvent, CredentialsState> {
  /// Data about the user
  final UserRepository userRepository;

  /// The AuthenticationBloc taking care of changing pages
  final AuthenticationBloc authenticationBloc;

  /// Creates a Bloc taking care of managing the login state of the app
  CredentialsBloc({
    required this.authenticationBloc,
    required this.userRepository,
  }) : super(const CredentialsInitial());

  @override
  Stream<CredentialsState> mapEventToState(CredentialsEvent event) async* {
    if (event is LoginButtonPressed) {
      yield* _loginPressed(event);
    }

    if (event is RegisterButtonPressed) {
      yield* _registerPressed(event);
    }
  }

  Stream<CredentialsState> _loginPressed(CredentialsEvent event) async* {
    yield const CredentialsLoginLoading();

    // try {
    //   await userRepository.authenticate(
    //     event.username,
    //     event.password,
    //   );
    //   authenticationBloc.add(LoggedIn());
    // } on PlatformException {
    //   yield const CredentialsLoginFailure();
    // }

    final succ = await userRepository.authenticate(
      event.username,
      event.password,
    );
    if (succ) {
      authenticationBloc.add(LoggedIn());
      yield const CredentialsInitial();
    } else {
      yield const CredentialsLoginFailure();
    }
  }

  Stream<CredentialsState> _registerPressed(CredentialsEvent event) async* {
    yield const CredentialsRegisterLoading();

    // try {
    //   await userRepository.register(
    //     event.username,
    //     event.password,
    //   );

    //   authenticationBloc.add(LoggedIn());
    // } on PlatformException {
    //   yield const CredentialsRegisterFailure();
    // }

    final succ = await userRepository.register(
      event.username,
      event.password,
    );

    if (succ) {
      authenticationBloc.add(LoggedIn());
      yield const CredentialsInitial();
    } else {
      yield const CredentialsRegisterFailure();
    }
  }
}
