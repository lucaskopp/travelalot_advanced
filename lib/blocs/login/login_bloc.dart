import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../interfaces/auth_interface.dart';

part 'login_state.dart';

enum LoginEvent {
  SignInWithGoogle,
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthInterface _authInterface;

  LoginBloc({
    @required AuthInterface authInterface,
  })  : assert(authInterface != null),
        _authInterface = authInterface, super(LoginState.empty());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    yield LoginState.loading();

    if (event == LoginEvent.SignInWithGoogle) {
      yield* _mapLoginWithGooglePressedToState();
    }
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    try {
      await _authInterface.signInWithGoogle();
      yield LoginState.success();
    } catch (_) {
      print(_);
      yield LoginState.failure();
    }
  }
}
