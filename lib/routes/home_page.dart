import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginapp/blocs/authentication_bloc.dart';
import 'package:loginapp/widgets/login_page.dart';
import 'package:loginapp/widgets/welcome_page.dart';

/// Home widget containing a tab that programmatically swipes between the
/// login form and the welcome page
class HomePage extends StatefulWidget {
  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  /// Sliding animation to show the welcome page
  void loginTransition() {
    if (tabController.index != 1) {
      tabController.animateTo(1);
    }
  }

  /// Sliding transition to show the login page
  void logoutTransition() {
    if (tabController.index != 0) {
      tabController.animateTo(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        // This state is emitted on successful authentication
        if (state is AuthenticationSuccess) {
          loginTransition();
        }

        // This state is emitted on logout
        if (state is AuthenticationRevoked) {
          logoutTransition();
        }

        return TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children: const [
            LoginPage(),
            WelcomePage(),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
