import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:travelalot/blocs/authentication/authentication_bloc.dart';
import 'package:travelalot/blocs/login/login_bloc.dart';

import '../widgets/spaces.dart';
import 'splash_page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.isSuccess) {
            BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          }

          if (state.isFailure) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Login Failure'), Icon(Icons.error)],
                  ),
                  backgroundColor: Colors.red,
                ),
              );
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return state.isLoading ? SplashPage() : buildSignin(context);
          },
        ),
      ),
    );
  }

  Widget buildSignin(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Spacer(flex: 2),
            buildAppName(),
            Spacer(flex: 4),
            buildButton(context),
            Spacer(flex: 3),
          ],
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          blurRadius: 5,
          color: const Color(0xFFD6D7FB),
        )
      ]),
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.07,
      child: SignInButton(
        Buttons.Google,
        text: "Sign up with Google",
        onPressed: () {
          BlocProvider.of<LoginBloc>(context).add(LoginEvent.SignInWithGoogle);
        },
      ),
    );
  }

  Widget buildAppName() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 40),
        child: Column(
          children: <Widget>[
            FlutterLogo(
              size: 100,
            ),
            SpaceH12(),
            Text(
              'travelalot',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
