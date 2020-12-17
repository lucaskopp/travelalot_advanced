import 'package:meta/meta.dart';

class FlightModel {
  String carrier;
  String name;
  String timeOfFlight;
  String startLocation;
  String arrivalLocaiton;
  String html;

  FlightModel({
    @required this.carrier,
    @required this.name,
    @required this.timeOfFlight,
    @required this.startLocation,
    @required this.arrivalLocaiton,
    @required this.html,
  }); // TODO add more assertions

}
