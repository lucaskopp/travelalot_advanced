import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/mail/mail_bloc.dart';
import '../../models/flight_model.dart';
import '../pages/flight_details_page.dart';

class FlightWidget extends StatelessWidget {
  final FlightModel flight;

  FlightWidget(this.flight);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(flight.name),
      onDismissed: (direction) {
        BlocProvider.of<MailBloc>(context).add(RemoveEvent(flight.name));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${flight.name} dismissed"),
          ),
        );
      },
      confirmDismiss: (DismissDirection direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Delete Confirmation"),
              content: const Text("Are you sure you want to delete this item?"),
              actions: <Widget>[
                FlatButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text("Delete")),
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("Cancel"),
                ),
              ],
            );
          },
        );
      },
      child: Card(
        elevation: 10,
        child: ListTile(
          leading: Text('Flight: ${flight.name}'),
          title: Text('${flight.startLocation} to ${flight.arrivalLocaiton}'),
          subtitle: Text(flight.carrier),
          trailing: Text(flight.timeOfFlight),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FlightsDetailsPage(flight.html),
              ),
            );
          },
        ),
      ),
    );
  }
}
