part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class Uninitialized extends AuthenticationState {
  const Uninitialized();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'Uninitialized';
}

class Authenticated extends AuthenticationState {
  final String displayName;

  const Authenticated(this.displayName);

  @override
  List<Object> get props => [displayName];

  @override
  String toString() => 'Authenticated';
}

class UnAuthenticated extends AuthenticationState {
  const UnAuthenticated();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'UnAuthenticated';
}
