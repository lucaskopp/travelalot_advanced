import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:travelalot/interfaces/gmail_interface.dart';
import 'package:travelalot/models/flight_model.dart';

part 'mail_event.dart';
part 'mail_state.dart';

class MailBloc extends Bloc<MailEvent, MailState> {
  GmailInterface gmailInterface;

  MailBloc({this.gmailInterface});

  @override
  MailState get initialState => LoadingMailState();

  @override
  Stream<MailState> mapEventToState(MailEvent event) async* {
    if (event is FetchEvent) {
      try {
        var temp = await gmailInterface.fetch();
        // TODO acutally make this update list
        yield FetchedMailState([]);
      } catch (error) {
        print(error);
        yield ErrorMailState(error.toString());
      }
    }
  }

  // injection
  set data(GmailInterface data) {
    gmailInterface = data;
  }
}
