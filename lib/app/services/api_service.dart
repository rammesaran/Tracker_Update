import 'dart:convert';
import 'package:covid_2020_app/app/services/api.dart';
import 'package:covid_2020_app/app/services/endpoint_data.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final Api api;

  ApiService({@required this.api});

  Future<String> getAccesstoken() async {
    final response = await http.post(api.tokenUri().toString(), headers: {
      "Authorization": "Basic ${api.apiKey}",
    });
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      final accessToken = result['access_token'];
      if (accessToken != null) {
        return accessToken;
      }
    }
    print(
        "the status code ${response.statusCode} and ${response.reasonPhrase}");
    throw response;
  }

  Future<EndPointDataModel> getEndpointData(
      {@required String accesstoken, @required Endpoint endpoint}) async {
    final uri = api.endpointUri(endpoint);
    final response = await http.get(
      uri.toString(),
      headers: {
        "Authorization": "Bearer $accesstoken",
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        final Map<String, dynamic> endpointdata = data[0];
        final String responseJson = _responseJsonKeys[endpoint];
        final int value = endpointdata[responseJson];
        final String dateEndpoint = endpointdata['date'];
        final date = DateTime.tryParse(dateEndpoint);
        if (value != null) {
          return EndPointDataModel(value: value, dateTime: date);
        }
      }
    }
    print(
        "the status code ${response.statusCode} and ${response.reasonPhrase}");
    throw response;
  }

  static Map<Endpoint, String> _responseJsonKeys = {
    Endpoint.cases: 'cases',
    Endpoint.casesSuspected: 'data',
    Endpoint.casesConfirmed: 'data',
    Endpoint.deaths: 'data',
    Endpoint.recovered: 'data',
  };
}
