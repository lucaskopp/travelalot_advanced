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
  final Map<String, String> authHeaders;

  const Authenticated(this.authHeaders);

  @override
  List<Object> get props => [authHeaders];

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
