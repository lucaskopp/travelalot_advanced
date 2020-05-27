part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class AppStarted extends AuthenticationEvent {
  const AppStarted();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'AppStarted';
}

class LoggedIn extends AuthenticationEvent {
  const LoggedIn();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'Login';
}

class LoggedOut extends AuthenticationEvent {
  const LoggedOut();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'LogOut';
}
