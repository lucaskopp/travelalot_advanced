import 'package:travelalot/models/flight_model.dart';

abstract class GmailInterface {
  List<FlightModel> flights;
  Future<void> fetch();
  void removeFlight(String id);
}
