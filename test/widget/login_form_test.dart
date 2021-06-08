import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loginapp/blocs/authentication_bloc.dart';
import 'package:loginapp/widgets/welcome_page.dart';
import 'package:mocktail/mocktail.dart';
import 'mock_material.dart';

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

class AuthenticationStateFake extends Fake implements AuthenticationState {}

class AuthenticationEventFake extends Fake implements AuthenticationEvent {}

void main() {
  setUpAll(() {
    registerFallbackValue<AuthenticationState>(AuthenticationStateFake());
    registerFallbackValue<AuthenticationEvent>(AuthenticationEventFake());
  });

  // setUp(() {
  //   authBloc = MockAuthenticationBloc();
  // });

  // whenListen(
  //   authBloc,
  //   Stream.fromIterable(<AuthenticationState>[
  //     AuthenticationLoading(),
  //     AuthenticationSuccess(),
  //   ]),
  // );

  testWidgets("Testing how the authentication behaves", (tester) async {
    final authBloc = MockAuthenticationBloc();
    when(() => authBloc.state).thenReturn(
      AuthenticationSuccess(), // the desired state
    );
    await tester.pumpWidget(
      BlocProvider<AuthenticationBloc>.value(
        value: authBloc,
        child: MockMaterialApp(
          child: const WelcomePage(),
        ),
      ),
    );

    final key = Key("HomeMessage");
    expect(find.byKey(key), findsOneWidget);
  });
}
