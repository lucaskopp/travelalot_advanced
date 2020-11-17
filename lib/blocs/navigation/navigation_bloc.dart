import 'dart:async';

import 'package:bloc/bloc.dart';

enum NavigationEvent { Home, Archived, Settings }

class NavigationBloc extends Bloc<NavigationEvent, NavigationEvent> {
  NavigationBloc() : super(NavigationEvent.Home);

  @override
  Stream<NavigationEvent> mapEventToState(
    NavigationEvent event,
  ) async* {
    if (event == NavigationEvent.Home) {
      yield NavigationEvent.Home;
    }

    if (event == NavigationEvent.Archived) {
      yield NavigationEvent.Archived;
    }

    if (event == NavigationEvent.Settings) {
      yield NavigationEvent.Settings;
    }
  }
}
