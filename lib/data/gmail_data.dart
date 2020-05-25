import 'package:googleapis/gmail/v1.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

import '../models/flight_model.dart';

class GmailData {
  final Map<String, String> authHeaders;
  final GoogleHttpClient httpClient;

  GmailData(this.authHeaders) : httpClient = GoogleHttpClient(authHeaders);

  Future<List<FlightModel>> fetch() async {
    var flights = <FlightModel>[];

    var jsonData = await GmailApi(httpClient).users.messages.list('me', maxResults: 10);

    

    return flights;
  }
}

class GoogleHttpClient extends IOClient {
  Map<String, String> _headers;

  GoogleHttpClient(this._headers) : super();

  @override
  Future<IOStreamedResponse> send(BaseRequest request) =>
      super.send(request..headers.addAll(_headers));

  @override
  Future<Response> head(Object url, {Map<String, String> headers}) =>
      super.head(url, headers: headers..addAll(_headers));
}
