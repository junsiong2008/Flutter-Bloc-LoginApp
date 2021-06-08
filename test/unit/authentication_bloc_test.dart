import 'package:bloc_test/bloc_test.dart';
import 'package:loginapp/blocs/authentication_bloc.dart';
import 'package:loginapp/repository/user_repository/test_repository.dart';

void main() {
  final authenticationRepository = const TestUserRepository(
    fakeEmail: "alberto@miola.it",
    succ: true,
  );

  blocTest<AuthenticationBloc, AuthenticationState>(
    'Authentication successful',
    build: () => AuthenticationBloc(authenticationRepository),
    act: (bloc) async => bloc.add(LoggedIn()),
    expect: () => <AuthenticationState>[
      AuthenticationSuccess(),
    ],
  );

  blocTest<AuthenticationBloc, AuthenticationState>(
    "Authentication failed",
    build: () => AuthenticationBloc(authenticationRepository),
    act: (bloc) async => bloc.add(const LoggedOut()),
    expect: () => <AuthenticationState>[
      AuthenticationLoading(),
      AuthenticationRevoked(),
    ],
  );
}
