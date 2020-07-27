import 'package:covid_2020_app/app/repository/datarepository.dart';
import 'package:covid_2020_app/app/repository/endpoints_data.dart';
import 'package:covid_2020_app/app/services/api.dart';
import 'package:covid_2020_app/app/ui/cards.dart';
import 'package:covid_2020_app/app/ui/last_updated_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  EndPointData _endPointData;
  Future<void> updateData() async {
    final data = Provider.of<DataRepository>(context, listen: false);
    final endPointData = await data.getAllEndPoinstData();
    setState(() {
      _endPointData = endPointData;
    });
  }

  @override
  void initState() {
    updateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final formater = LastUpdatedDateFormat(
        lastUpdatedTime: _endPointData != null
            ? _endPointData.values[Endpoint.cases].dateTime
            : null);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Tracker'),
      ),
      body: RefreshIndicator(
        onRefresh: updateData,
        child: ListView(
          children: <Widget>[
            LastUpdatedTime(
              text: formater.lastUpdatedStatus(),
            ),
            for (var item in Endpoint.values)
              CardEndPoint(
                point: item,
                value: _endPointData != null
                    ? _endPointData.values[item].value
                    : null,
              ),
          ],
        ),
      ),
    );
  }
}
