import 'package:covid_2020_app/app/services/api.dart';
import 'package:flutter/material.dart';

class CardEndPoint extends StatelessWidget {
  final Endpoint point;
  final int value;

  static Map<Endpoint, String> cardTitle = {
    Endpoint.cases: "cases",
    Endpoint.casesConfirmed: "casesConfimed",
    Endpoint.casesSuspected: "CasesSuspected",
    Endpoint.deaths: "Deaths",
    Endpoint.recovered: "recovered",
  };
  const CardEndPoint({this.point, this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(cardTitle[point],
                  style: Theme.of(context).textTheme.headline6),
              Text(
                value != null ? value.toString() : "",
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
