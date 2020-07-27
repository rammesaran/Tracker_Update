import 'package:covid_2020_app/app/repository/datarepository.dart';
import 'package:covid_2020_app/app/services/api.dart';
import 'package:covid_2020_app/app/services/api_service.dart';
import 'package:covid_2020_app/app/ui/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => DataRepository(
        service: ApiService(
          api: Api.sanbox(),
        ),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Color(0xFF101010),
          cardColor: Color(0xFF222222),
        ),
        home: DashBoard(),
      ),
    );
  }
}
