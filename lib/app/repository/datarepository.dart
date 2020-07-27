import 'package:covid_2020_app/app/repository/endpoints_data.dart';
import 'package:covid_2020_app/app/services/api.dart';
import 'package:covid_2020_app/app/services/api_service.dart';
import 'package:covid_2020_app/app/services/endpoint_data.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class DataRepository {
  final ApiService service;
  String _accessToken;
  DataRepository({@required this.service});

  Future<EndPointDataModel> getEndPointData(Endpoint point) async =>
      await getDataRefreshinToken<EndPointDataModel>(
          onGetData: () => service.getEndpointData(
              accesstoken: _accessToken, endpoint: point));

  Future<EndPointData> getAllEndPoinstData() async =>
      await getDataRefreshinToken<EndPointData>(
        onGetData: () => getMultpleEndPoints(),
      );

  Future<T> getDataRefreshinToken<T>({Future<T> Function() onGetData}) async {
    try {
      if (_accessToken == null) {
        _accessToken = await service.getAccesstoken();
      }
      return await onGetData();
    } on Response catch (response) {
      if (response.statusCode == 401) {
        _accessToken = await service.getAccesstoken();
        return await onGetData();
      }
      rethrow;
    }
  }

  Future<EndPointData> getMultpleEndPoints() async {
    // final cases = await service.getEndpointData(
    //     accesstoken: _accessToken, endpoint: Endpoint.cases);

    // final recovered = await service.getEndpointData(
    //     accesstoken: _accessToken, endpoint: Endpoint.recovered);

    final values = await Future.wait([
      service.getEndpointData(
          accesstoken: _accessToken, endpoint: Endpoint.cases),
      service.getEndpointData(
          accesstoken: _accessToken, endpoint: Endpoint.casesSuspected),
      service.getEndpointData(
          accesstoken: _accessToken, endpoint: Endpoint.casesConfirmed),
      service.getEndpointData(
          accesstoken: _accessToken, endpoint: Endpoint.deaths),
      service.getEndpointData(
          accesstoken: _accessToken, endpoint: Endpoint.recovered),
    ]);
    return EndPointData(values: {
      Endpoint.cases: values[0],
      Endpoint.casesSuspected: values[1],
      Endpoint.casesConfirmed: values[2],
      Endpoint.deaths: values[3],
      Endpoint.recovered: values[4],
    });
  }
}
