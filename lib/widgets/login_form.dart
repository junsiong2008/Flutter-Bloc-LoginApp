import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loginapp/blocs/credentials_bloc.dart';
import 'package:loginapp/blocs/credentials_bloc/bloc.dart';
import 'package:loginapp/blocs/credentials_bloc/events.dart';
import 'package:loginapp/widgets/separator.dart';

/// Actual login form, with validation, asking for email and password
class LoginForm extends StatefulWidget {
  const LoginForm();

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? validateEmail(String input) {
    if ((input.length > 10) && input.contains('@')) {
      return null;
    } else {
      return AppLocalizations.of(context)!.invalid_field;
    }
  }

  String? validatePassword(String input) {
    if (input.length > 5) {
      return null;
    } else {
      return AppLocalizations.of(context)!.invalid_field;
    }
  }

  void _loginButtonPressed(BuildContext context) {
    BlocProvider.of<CredentialsBloc>(context).add(
      LoginButtonPressed(
        username: emailController.text,
        password: passwordController.text,
      ),
    );
  }

  void _registerButtonPressed(BuildContext context) {
    BlocProvider.of<CredentialsBloc>(context).add(
      RegisterButtonPressed(
        username: emailController.text,
        password: passwordController.text,
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, data) {
        var baseWidth = 250.0;

        // for wider screen, such as tablets
        if (data.maxWidth >= baseWidth) {
          baseWidth = data.maxWidth / 1.4;
        }

        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlutterLogo(
                size: baseWidth,
              ),
              const Separator(50),
              Form(
                key: formKey,
                child: Wrap(
                  direction: Axis.vertical,
                  spacing: 20,
                  children: <Widget>[
                    SizedBox(
                      width: baseWidth - 30,
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email),
                          hintText: AppLocalizations.of(context)!.username,
                        ),
                        validator: (value) => validateEmail(value ?? ""),
                        controller: emailController,
                      ),
                    ),
                    SizedBox(
                      width: baseWidth - 30,
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.vpn_key),
                          hintText: AppLocalizations.of(context)!.password,
                        ),
                        obscureText: true,
                        validator: (value) => validatePassword(value ?? ""),
                        controller: passwordController,
                      ),
                    )
                  ],
                ),
              ),

              const Separator(25),

              // Login
              BlocConsumer<CredentialsBloc, CredentialsState>(
                listener: (context, state) {
                  if (state is CredentialsLoginFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 2),
                        content:
                            Text(AppLocalizations.of(context)!.error_login),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is CredentialsLoginLoading) {
                    return const CircularProgressIndicator();
                  }

                  return ElevatedButton(
                    key: Key("loginButton"),
                    child: Text(AppLocalizations.of(context)!.login),
                    onPressed: () {
                      // final state = formKey.currentState;

                      // if (state?.validate() ?? false) {
                      //   _loginButtonPressed(context);
                      // }
                      if (formKey.currentState?.validate() ?? false) {
                        _loginButtonPressed(context);
                      }
                    },
                  );
                },
              ),

              // Register
              BlocConsumer<CredentialsBloc, CredentialsState>(
                listener: (context, state) {
                  if (state is CredentialsRegisterFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 2),
                        content:
                            Text(AppLocalizations.of(context)!.error_register),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is CredentialsRegisterLoading) {
                    return const CircularProgressIndicator();
                  }

                  return ElevatedButton(
                    key: Key("registerButton"),
                    child: Text(AppLocalizations.of(context)!.register),
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        _registerButtonPressed(context);
                      }
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
