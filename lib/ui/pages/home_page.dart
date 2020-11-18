import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelalot/blocs/mail/mail_bloc.dart';
import 'package:travelalot/ui/pages/flights_page.dart';

import '../widgets/flight_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MailBloc, MailState>(
      builder: (context, state) {
        if (state is FetchedMailState) {
          print(state.flights);
          return FlightsPage(state.flights);
        }

        if (state is ErrorMailState) {
          // do error code
          print("error");
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
