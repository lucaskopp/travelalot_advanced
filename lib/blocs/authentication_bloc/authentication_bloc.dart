import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../interfaces/auth_interface.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthInterface _authInterface;

  AuthenticationBloc({@required AuthInterface authInterface})
      : assert(authInterface != null),
        _authInterface = authInterface;

  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await _authInterface.isSignedIn();
      if (isSignedIn) {
        final userName = await _authInterface.getUserEmail();
        yield Authenticated(userName);
      } else {
        yield UnAuthenticated();
      }
    } catch (error) {
      yield UnAuthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    yield Authenticated(await _authInterface.getUserEmail());
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield UnAuthenticated();
    _authInterface.signOut();
  }
}
