import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/auth_data.dart';

part 'login_state.dart';

enum LoginEvent {
  SignInWithGoogle,
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthData _authRepository;

  LoginBloc({
    @required AuthData authRepository,
  })  : assert(authRepository != null),
        _authRepository = authRepository;

  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event == LoginEvent.SignInWithGoogle) {
      yield* _mapLoginWithGooglePressedToState();
    }
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    try {
      await _authRepository.signInWithGoogle();
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }
}
