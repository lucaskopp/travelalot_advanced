import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelalot/blocs/authentication/authentication_bloc.dart';


class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('SettingsPage'),
          Column(
            children: <Widget>[
              MaterialButton(
                child: Text('LogOut'),
                textColor: Theme.of(context).accentColor,
                color: Theme.of(context).buttonColor,
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                },
              ),
              MaterialButton(
                child: Text('test'),
                textColor: Theme.of(context).accentColor,
                color: Theme.of(context).buttonColor,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
