import 'package:meta/meta.dart';

class FlightModel {
  final String carrier;
  final String name;
  final bool roundTrip;
  final String timeOfArrival;
  final String timeOfFlight;
  final String startLocation;
  final String arrivalLocaiton;
  final String dateReceived;

  const FlightModel({
    @required this.dateReceived,
    @required this.carrier,
    @required this.name,
    @required this.roundTrip,
    @required this.timeOfArrival,
    @required this.timeOfFlight,
    @required this.startLocation,
    @required this.arrivalLocaiton,
  }) : assert(name != null); // TODO add more assertions

}
