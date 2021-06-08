import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginapp/blocs/authentication_bloc.dart';
import 'package:loginapp/blocs/credentials_bloc.dart';
import 'package:loginapp/repository/user_repository/firebase_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loginapp/widgets/login_form.dart';

/// First widget to appear whtn the application starts containing
/// the LoginForm form
class LoginPage extends StatelessWidget {
  const LoginPage();

  @override
  Widget build(BuildContext context) {
    final repository = context.select((FirebaseUserRepository r) => r);
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.title),
      ),
      body: BlocProvider<CredentialsBloc>(
        create: (context) => CredentialsBloc(
          authenticationBloc: authBloc,
          userRepository: repository,
        ),
        child: const Center(
          child: LoginForm(),
        ),
      ),
    );
  }
}
