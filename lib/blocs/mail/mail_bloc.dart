import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:travelalot/interfaces/gmail_interface.dart';
import 'package:travelalot/models/flight_model.dart';

part 'mail_event.dart';

part 'mail_state.dart';

class MailBloc extends Bloc<MailEvent, MailState> {
  // should not be called MailBloc; holds all flight information
  GmailInterface gmailInterface;

  MailBloc({this.gmailInterface}) : super(LoadingMailState());

  @override
  Stream<MailState> mapEventToState(MailEvent event) async* {
    if (event is FetchEvent) {
      try {
        await gmailInterface.fetch();
        // TODO acutally make this update list
        yield FetchedMailState(gmailInterface.flights);
      } catch (error) {
        print(error);
        yield ErrorMailState(error.toString());
      }
    }

    if (event is RemoveEvent) {
      try {
        gmailInterface.removeFlight(event.confirmationNumber);
        yield FetchedMailState(gmailInterface.flights);
      } catch (error) {
        yield ErrorMailState(error.toString());
      }
    }
  }

  // injection
  set data(GmailInterface data) {
    gmailInterface = data;
  }
}
