part of 'mail_bloc.dart';

@immutable
abstract class MailEvent extends Equatable {
  const MailEvent();
}

class FetchEvent extends MailEvent {
  const FetchEvent();

  @override
  List<Object> get props => [];
}

class RemoveEvent extends MailEvent {
  final String confirmationNumber;

  const RemoveEvent(this.confirmationNumber);

  @override
  List<Object> get props => [confirmationNumber];
}
