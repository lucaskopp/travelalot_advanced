import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/auth_data.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthData _authData;
  // create interface for data

  AuthenticationBloc({@required AuthData authData})
      : assert(authData != null),
        _authData = authData;

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
      yield* _mapLogOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await _authData.isSignedIn();
      if (isSignedIn) {
        final userName = await _authData.getUserEmail();
        yield Authenticated(userName);
      } else {
        yield UnAuthenticated();
      }
    } catch (error) {
      yield UnAuthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    yield Authenticated(await _authData.getUserEmail());
  }

  Stream<AuthenticationState> _mapLogOutToState() async* {
    yield UnAuthenticated();
    _authData.signOut();
  }

  // TODO make logout LoggedOut
}
