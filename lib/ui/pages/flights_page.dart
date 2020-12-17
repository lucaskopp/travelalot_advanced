import 'package:flutter/cupertino.dart';

import '../../models/flight_model.dart';
import '../widgets/flight_widget.dart';

class FlightsPage extends StatelessWidget {
  final List<FlightModel> flights;

  FlightsPage(this.flights);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return FlightWidget(flights[index]);
          },
          itemCount: flights.length,
        ),
      ),
    );
  }
}