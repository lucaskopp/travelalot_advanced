import 'package:meta/meta.dart';

class FlightModel {
  final String carrier;
  final String name;
  final bool roundTrip;
  final String timeOfArrival;
  final String timeOfFlight;
  final String startLocation;
  final String arrivalLocaiton;

  const FlightModel({
    @required this.carrier,
    @required this.name,
    @required this.roundTrip,
    @required this.timeOfArrival,
    @required this.timeOfFlight,
    @required this.startLocation,
    @required this.arrivalLocaiton,
  }) : assert(name != null); // TODO add more assertions

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is FlightModel &&
        o.carrier == carrier &&
        o.name == name &&
        o.roundTrip == roundTrip &&
        o.timeOfArrival == timeOfArrival &&
        o.timeOfFlight == timeOfFlight &&
        o.startLocation == startLocation &&
        o.arrivalLocaiton == arrivalLocaiton;
  }

  @override
  int get hashCode {
    return carrier.hashCode ^
        name.hashCode ^
        roundTrip.hashCode ^
        timeOfArrival.hashCode ^
        timeOfFlight.hashCode ^
        startLocation.hashCode ^
        arrivalLocaiton.hashCode;
  }
}
