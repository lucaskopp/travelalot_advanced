import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_theme.dart';
import 'blocs/authentication_bloc/authentication_bloc.dart';
import 'blocs/login_bloc/login_bloc.dart';
import 'blocs/naviagation_bloc/navigation_bloc.dart';
import 'blocs/simple_bloc_delegate.dart';
import 'data/auth_data.dart';
import 'ui/pages/login_page.dart';
import 'ui/pages/splash_page.dart';
import 'ui/pages/tab_page.dart';

main() {
  runApp(App());
  BlocSupervisor.delegate = SimpleBlocDelegate();
}

class App extends StatefulWidget {
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationBloc(authInterface: AuthData()),
        ),
        BlocProvider(
          create: (context) => LoginBloc(authInterface: AuthData()),
        ),
        BlocProvider(
          create: (context) => NavigationBloc(),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.buildLightTheme(),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is Uninitialized) {
              BlocProvider.of<AuthenticationBloc>(context).add(AppStarted());
              return SplashPage();
            }

            if (state is UnAuthenticated) {
              return LoginPage();
            }

            if (state is Authenticated) {
              return TabPage(
                headers: state.authHeaders,
              );
            }
            return SplashPage();
          },
        ),
      ),
    );
  }
}
