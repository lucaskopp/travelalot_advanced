import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelalot/blocs/mail/mail_bloc.dart';

import 'app_theme.dart';
import 'blocs/authentication/authentication_bloc.dart';
import 'blocs/login/login_bloc.dart';
import 'blocs/navigation/navigation_bloc.dart';
import 'data/auth_data.dart';
import 'ui/pages/login_page.dart';
import 'ui/pages/splash_page.dart';
import 'ui/pages/tab_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
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
        BlocProvider(
          create: (context) => MailBloc(),
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
