import 'package:flutter/foundation.dart';

class EndPointDataModel {
  final int value;
  final DateTime dateTime;

  EndPointDataModel({this.dateTime, @required this.value})
      : assert(value != null);
}
