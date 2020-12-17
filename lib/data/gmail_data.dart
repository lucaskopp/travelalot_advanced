import 'dart:convert';

import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

import '../interfaces/gmail_interface.dart';
import '../models/flight_model.dart';

class GmailData implements GmailInterface {
  // rename into something flight related
  final Map<String, String> authHeaders;

  List<FlightModel> flights = [];

  // this should equal the stored flights

  GmailData(this.authHeaders);

  Future<void> fetch() async {
    const url =
        'https://www.googleapis.com/gmail/v1/users/me/messages?q=%7B%22flight%22%20AND%20%22airlines%22%20AND%20%22check%22%7D&fields=messages';
    Map<String, dynamic> decodedEmailIds;
    List<Map<String, dynamic>> emails = [];
    List<Map<String, String>> emailData = [];

    // The fetching of email ids
    try {
      final jsonData = await http.get(url, headers: authHeaders);
      decodedEmailIds = json.decode(jsonData.body);
    } catch (error) {
      print('No emails were found OR the request was faulty');
      rethrow;
    }

    // TODO add specific error for different things
//    var test = [
//      {'id': '1724df2dda7d3894', 'threadId': '1724df2dda7d3894'},
//      {'id': '1724df2161af6b43', 'threadId': '1724df2161af6b43'},
//      {'id': '1724defebcd59954', 'threadId': '1724defebcd59954'}
//    ];

    // receiving the full emails using the email ids
    try {
      final messages = decodedEmailIds['messages'];
      await Future.forEach(messages, (element) async {
        emails.add((await _idToEmail(element['id'])));
        print(emails.length);
      });
      emails.forEach((element) {
        emailData.add(emailToText(element));
      });
    } catch (error) {
      print(error);
      rethrow;
    }

    List<FlightModel> tempFlights = [];

    emailData.forEach((element) {
      final plainText = element['plainText'];

      FlightModel flightToBeAdded = FlightModel(
        arrivalLocaiton: "not supported",
        startLocation: "not supported",
        carrier: "not supported",
        name: "not supported",
        timeOfFlight: "not supported",
        html: "not supported",
      );

      if (plainText.contains("United Airlines") &&
          plainText.contains(RegExp(r"UA\d\d\d"))) {
        final flightNameExpression = RegExp(r"UA\d\d\d?\d");
        final flightLocationsExpression = RegExp(r"\([A-Z][A-Z][A-Z]\)");
        final flightDatesExpression =
            RegExp(r"\w\w\w,\s\w\w\w\s\d\d,\s\d\d\d\d");
        flightToBeAdded.html = element['html'];
        flightToBeAdded.name =
            flightNameExpression.firstMatch(plainText).group(0);
        flightToBeAdded.carrier = "United Airlines";
        final locations = flightLocationsExpression.allMatches(plainText);
        final dates = flightDatesExpression.allMatches(plainText);
        flightToBeAdded.startLocation = locations.elementAt(0).group(0);
        flightToBeAdded.arrivalLocaiton = locations.elementAt(1).group(0);
        flightToBeAdded.timeOfFlight = dates.elementAt(2).group(0);

        tempFlights.add(flightToBeAdded);
        // should be below if more carriers are added
      }
    });

    flights = tempFlights;
  }

  Future<Map<String, dynamic>> _idToEmail(String id) async {
    final url =
        'https://www.googleapis.com/gmail/v1/users/me/messages/$id?format=full';
    try {
      final jsonData = await http.get(url, headers: authHeaders);
      print('inside _idToEmail');
      final decodedEmail = json.decode(jsonData.body) as Map<String, dynamic>;
      return decodedEmail;
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Map<String, String> emailToText(Map<String, dynamic> email) {
    List<dynamic> parts;
    if (email['payload']['parts'][0]['parts'] == null) {
      parts = email['payload']['parts'];
    } else {
      parts = email['payload']['parts'][0]['parts'];
    }

    var largestSize = 0;
    Map<String, dynamic> largestPart;

    parts.forEach((element) {
      int currentPartSize = element['body']['size'];
      if (currentPartSize > largestSize) {
        largestPart = element;
        largestSize = currentPartSize;
      }
    });

    print(largestSize);

    var textToBeConverted =
        utf8.decode(base64.decode(largestPart['body']['data']));

    final document = parse(textToBeConverted);
    final parsedString = parse(document.body.text).documentElement.text;

    return {
      'plainText':
          parsedString.replaceAll('\n', ' ').replaceAll(RegExp(' +'), ' '),
      'html': textToBeConverted,
    };
  }

  void removeFlight(String id) {
    flights.removeWhere((element) => element.name == id);
  }
}
