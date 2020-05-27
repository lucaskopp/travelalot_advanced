part of 'mail_bloc.dart';

@immutable
abstract class MailState extends Equatable {
  const MailState();
}

class FetchedMailState extends MailState {
  final List<FlightModel> flights;

  const FetchedMailState(this.flights);

  @override
  List<Object> get props => [flights];
}

class LoadingMailState extends MailState {
  const LoadingMailState();

  @override
  List<Object> get props => [];
}

class ErrorMailState extends MailState {
  final String message;

  const ErrorMailState(this.message);

  @override
  List<Object> get props => [message];
}
