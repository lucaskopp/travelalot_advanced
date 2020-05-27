import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:travelalot/models/flight_model.dart';

part 'mail_event.dart';
part 'mail_state.dart';

class MailBloc extends Bloc<MailEvent, MailState> {
  @override
  MailState get initialState => LoadingMailState();

  @override
  Stream<MailState> mapEventToState(MailEvent event) async* {
    // TODO: Add your event logic
  }
}
