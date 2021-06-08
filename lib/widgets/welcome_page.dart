import 'package:flutter/material.dart';
import 'package:loginapp/blocs/authentication_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () =>
                BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut()),
          ),
        ],
      ),
      drawer: const Drawer(),
      body: Center(
        child: Text(
          AppLocalizations.of(context)!.welcome,
          key: Key("HomeMessage"),
        ),
      ),
    );
  }
}
