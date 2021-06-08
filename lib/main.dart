import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loginapp/blocs/authentication_bloc.dart';
import 'package:loginapp/repository/user_repository/firebase_repository.dart';
import 'package:loginapp/routes.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    Provider<FirebaseUserRepository>(
      create: (_) => FirebaseUserRepository(),
      child: const LoginApp(),
    ),
  );
}

class LoginApp extends StatelessWidget {
  const LoginApp();

  @override
  Widget build(BuildContext context) {
    final repository = context.select((FirebaseUserRepository r) => r);
    return BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(repository);
      },
      child: MaterialApp(
        initialRoute: RouteGenerator.homePage,
        onGenerateRoute: RouteGenerator.generateRoute,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale.fromSubtags(languageCode: "en"),
          Locale.fromSubtags(languageCode: "it"),
        ],
        onGenerateTitle: (context) => AppLocalizations.of(context)!.title,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
