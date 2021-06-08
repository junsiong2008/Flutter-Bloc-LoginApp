import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginapp/blocs/authentication_bloc/events.dart';
import 'package:loginapp/blocs/authentication_bloc/states.dart';
import 'package:loginapp/repository/user_repository.dart';

/// Manage the authentication state of the app
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  AuthenticationBloc(this.userRepository) : super(const AuthenticationInit());

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent e) async* {
    if (e is LoggedIn) {
      yield const AuthenticationSuccess();
    }
    if (e is LoggedOut) {
      yield const AuthenticationLoading();
      await userRepository.logOut();
      yield const AuthenticationRevoked();
    }
  }
}
