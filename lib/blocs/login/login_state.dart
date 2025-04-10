part of 'login_bloc.dart';

@immutable
class LoginState {
  final bool isSuccess;
  final bool isFailure;
  final bool isLoading;

  LoginState({
    @required this.isSuccess,
    @required this.isFailure,
    @required this.isLoading,
  });

  factory LoginState.empty() {
    return LoginState(
      isSuccess: false,
      isFailure: false,
      isLoading: false,
    );
  }

  factory LoginState.failure() {
    return LoginState(
      isSuccess: false,
      isFailure: true,
      isLoading: false,
    );
  }

  factory LoginState.success() {
    return LoginState(
      isSuccess: true,
      isFailure: false,
      isLoading: false,
    );
  }

  factory LoginState.loading() {
    return LoginState(
      isSuccess: false,
      isFailure: false,
      isLoading: true,
    );
  }

  @override
  String toString() {
    return '''LoginState {
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      isLoading: $isLoading,
    }''';
  }
}
