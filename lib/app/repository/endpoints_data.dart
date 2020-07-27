import 'package:covid_2020_app/app/services/api.dart';
import 'package:covid_2020_app/app/services/endpoint_data.dart';
import 'package:flutter/foundation.dart';

class EndPointData {
  final Map<Endpoint, EndPointDataModel> values;

  EndPointData({@required this.values});

  EndPointDataModel get getCases => values[Endpoint.cases];
  EndPointDataModel get getCaseSuspected => values[Endpoint.casesSuspected];
  EndPointDataModel get getCaseConfirmed => values[Endpoint.casesConfirmed];
  EndPointDataModel get getDeaths => values[Endpoint.deaths];
  EndPointDataModel get getRecovered => values[Endpoint.recovered];

  @override
  String toString() => 'cases is $getCases';
}
