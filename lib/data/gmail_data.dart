import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:travelalot/models/flight_model.dart';
import 'dart:convert';

import '../interfaces/gmail_interface.dart';

class GmailData implements GmailInterface {
  final Map<String, String> authHeaders;

  GmailData(this.authHeaders);

  Future<List<FlightModel>> fetch() async {
    var flights = <FlightModel>[];

    const url =
        'https://www.googleapis.com/gmail/v1/users/me/messages?q=%7B%22flight%22%20AND%20%22airlines%22%20AND%20%22check%22%7D&fields=messages';
    Map<String, dynamic> decodedEmailIds;
    List<Map<String, dynamic>> emails = [];
    List<String> emailData = [];

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

    emailData.forEach((element) {
      print(element);
      // if (element.contains("United Airlines")) {
      //   // make separate method
      //
      // }
    });

    return flights;
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

  String emailToText(Map<String, dynamic> email) {
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
    final String parsedString = parse(document.body.text).documentElement.text;

    return parsedString.replaceAll("\n", " ").replaceAll(RegExp(' +'), ' ');
  }
}
