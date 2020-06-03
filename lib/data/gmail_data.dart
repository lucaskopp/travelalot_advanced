import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../interfaces/gmail_interface.dart';

class GmailData implements GmailInterface {
  final Map<String, String> authHeaders;

  GmailData(this.authHeaders);

  Future<void> fetch() async {
//    var flights = <FlightModel>[];

    const url =
        'https://www.googleapis.com/gmail/v1/users/me/messages?q=%7B%22flight%22%20AND%20%22confirmation%22%20AND%20%22itinerary%22%7D&fields=messages';
    Map<String, dynamic> decodedEmailIds;
    List<Map<String, dynamic>> emails = [];

    try {
      final jsonData = await http.get(url, headers: authHeaders);
      decodedEmailIds = json.decode(jsonData.body);
    } catch (error) {
      print(error);
      rethrow;
    }

    // TODO add specific error for different things
//    var test = [
//      {'id': '1724df2dda7d3894', 'threadId': '1724df2dda7d3894'},
//      {'id': '1724df2161af6b43', 'threadId': '1724df2161af6b43'},
//      {'id': '1724defebcd59954', 'threadId': '1724defebcd59954'}
//    ];

    try {
      final messages = decodedEmailIds['messages'];
      await Future.forEach(messages, (element) async {
        emails.add((await _idToEmail(element['id'])));
        print(emails.length);
      });
      emails.forEach((element) {
        print(element.toString());
      });
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> _idToEmail(String id) async {
    final url =
        'https://www.googleapis.com/gmail/v1/users/me/messages/$id?format=raw';
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
}
