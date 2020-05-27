import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'mail_event.dart';

part 'mail_state.dart';

class MailBloc extends Bloc<MailEvent, MailState> {
  @override
  MailState get initialState => InitialMailState();

  @override
  Stream<MailState> mapEventToState(MailEvent event) async* {
    // TODO: Add your event logic
  }
}
