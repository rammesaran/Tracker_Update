import 'package:covid_2020_app/app/services/api_keys.dart';
import 'package:flutter/foundation.dart';

enum Endpoint {
  cases,
  casesSuspected,
  casesConfirmed,
  deaths,
  recovered,
}

class Api {
  final String apiKey;
  static final String host = "ncov2019-admin.firebaseapp.com";
  Api({@required this.apiKey});

  factory Api.sanbox() => Api(apiKey: APIKeys.sanboxApiKey);

  Uri tokenUri() => Uri(
        scheme: "https",
        host: host,
        path: 'token',
      );

  static Map<Endpoint, String> _paths = {
    Endpoint.cases: 'cases',
    Endpoint.casesSuspected: 'casesSuspected',
    Endpoint.casesConfirmed: 'casesConfirmed',
    Endpoint.deaths: 'deaths',
    Endpoint.recovered: 'recovered',
  };

  Uri endpointUri(Endpoint point) => Uri(
        scheme: "https",
        host: host,
        path: _paths[point],
      );
}
