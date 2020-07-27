import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LastUpdatedTime extends StatelessWidget {
  final String text;

  const LastUpdatedTime({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(),
      ),
    );
  }
}

class LastUpdatedDateFormat {
  DateTime lastUpdatedTime;
  LastUpdatedDateFormat({@required this.lastUpdatedTime});

  String lastUpdatedStatus() {
    if (lastUpdatedTime != null) {
      final formatedDate = DateFormat.yMd().add_Hms();
      final formatedvalue = formatedDate.format(lastUpdatedTime);
      return 'Last updated: $formatedvalue';
    }
    return '';
  }
}
