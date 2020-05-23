import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelalot/blocs/authentication_bloc/authentication_bloc.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('SettingsPage'),
          MaterialButton(
            child: Text('LogOut'),
            textColor: Theme.of(context).accentColor,
            color: Theme.of(context).buttonColor,
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
            },
          ),
        ],
      ),
    );
  }
}
