import 'package:flutter/material.dart';

import '../../models/flight_model.dart';
import '../widgets/flight_widget.dart';

const List<FlightModel> flights = [
  FlightModel(
    arrivalLocaiton: 'Virgina',
    carrier: 'United Airlines',
    name: 'Flight 2346',
    roundTrip: false,
    startLocation: 'Florida',
    timeOfArrival: '2:48pm',
    timeOfFlight: '4:50pm',
  ),
];

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return FlightWidget();
          },
          itemCount: flights.length,
        ),
      ),
    );
  }
}
