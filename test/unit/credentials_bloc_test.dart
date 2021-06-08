import 'package:bloc_test/bloc_test.dart';
import 'package:loginapp/blocs/authentication_bloc.dart';
import 'package:loginapp/blocs/credentials_bloc.dart';
import 'package:loginapp/repository/user_repository/test_repository.dart';

void main() {
  final successRepository = const TestUserRepository(
    fakeEmail: "alberto@goodtest.it",
    succ: true,
  );

  final failedRepository = const TestUserRepository(
    fakeEmail: "alberto@failtest.it",
    succ: false,
  );

  blocTest<CredentialsBloc, CredentialsState>(
    'Successful login',
    build: () => CredentialsBloc(
      authenticationBloc: AuthenticationBloc(successRepository),
      userRepository: successRepository,
    ),
    act: (bloc) async => bloc.add(
      const LoginButtonPressed(
        username: "alberto@goodtest.it",
        password: "123456",
      ),
    ),
    expect: () => <CredentialsState>[
      CredentialsLoginLoading(),
      CredentialsInitial(),
    ],
  );

  blocTest<CredentialsBloc, CredentialsState>(
    'Successful registration',
    build: () => CredentialsBloc(
      authenticationBloc: AuthenticationBloc(successRepository),
      userRepository: successRepository,
    ),
    act: (bloc) async => bloc.add(
      const RegisterButtonPressed(
        username: "alberto@goodtest.it",
        password: "123456",
      ),
    ),
    expect: () => <CredentialsState>[
      CredentialsRegisterLoading(),
      CredentialsInitial(),
    ],
  );

  blocTest<CredentialsBloc, CredentialsState>(
    'Failed login',
    build: () => CredentialsBloc(
      authenticationBloc: AuthenticationBloc(failedRepository),
      userRepository: failedRepository,
    ),
    act: (bloc) async => bloc.add(
      const LoginButtonPressed(
        username: "alberto@goodtest.it",
        password: "123456",
      ),
    ),
    expect: () => <CredentialsState>[
      CredentialsLoginLoading(),
      CredentialsLoginFailure(),
    ],
  );

  blocTest<CredentialsBloc, CredentialsState>(
    'Registration failed',
    build: () => CredentialsBloc(
      authenticationBloc: AuthenticationBloc(failedRepository),
      userRepository: failedRepository,
    ),
    act: (bloc) async => bloc.add(
      const RegisterButtonPressed(
          username: "alberto@goodtest.it", password: "123456"),
    ),
    expect: () => <CredentialsState>[
      CredentialsRegisterLoading(),
      CredentialsRegisterFailure(),
    ],
  );
}
