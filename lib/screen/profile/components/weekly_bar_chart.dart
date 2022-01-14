import 'package:fiton/models/daily.dart';
import 'package:fiton/screen/running/model/entry.dart';
import 'package:fiton/services/daily_service.dart';
import 'package:fiton/services/runs_service.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:intl/intl.dart';

class WeeklyBarChart extends StatefulWidget {
  const WeeklyBarChart({Key? key}) : super(key: key);

  @override
  State<WeeklyBarChart> createState() => _WeeklyBarChartState();
}

class _WeeklyBarChartState extends State<WeeklyBarChart> {
  List<Entry> _entry = [];
  List<Daily> _daily = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getDataEntry();
    getDataDaily();
  }

  void getDataEntry() async {
    List userProfilesList = await RunsService().getRunWeeks();
    List<Entry> tempdata =
        userProfilesList.map((item) => Entry.fromMap(item)).toList();
    setState(() {
      _entry = tempdata;
      loading = false;
    });
  }

  void getDataDaily() async {
    List userProfilesList = await DailyService().getDailyWeeks();
    List<Daily> tempdata =
        userProfilesList.map((item) => Daily.fromMap(item)).toList();
    setState(() {
      _daily = tempdata;
      loading = false;
    });
  }

  List<charts.Series<Entry, String>> _createRunData() {
    return [
      charts.Series<Entry, String>(
        data: _entry,
        id: 'Run',
        colorFn: (_, __) => charts.MaterialPalette.teal.shadeDefault,
        domainFn: (Entry entry, _) => DateFormat('EE').format(entry.date),
        measureFn: (Entry entry, _) => entry.distance,
        labelAccessorFn: (Entry entry, _) => '${entry.distance.toInt()}',
      )
    ];
  }

  
  List<charts.Series<Daily, String>> _createSleepData() {
    return [
      charts.Series<Daily, String>(
        data: _daily,
        id: 'Run',
        colorFn: (_, __) => charts.MaterialPalette.teal.shadeDefault,
        domainFn: (Daily daily, _) => DateFormat('EE').format(daily.date),
        measureFn: (Daily daily, _) {
          var format = DateFormat("HH:mm");
          var wake = format.parse(daily.wake);
          var sleep = format.parse(daily.sleep);
          int diff = sleep.difference(wake).inHours;
          if(diff.isNegative)
            return diff+24;
          return diff; 
        },
        labelAccessorFn: (Daily daily, _){
          var format = DateFormat("HH:mm");
          var wake = format.parse(daily.wake);
          var sleep = format.parse(daily.sleep);
          int diff = wake.difference(sleep).inHours;
          if(diff.isNegative)
            return (diff+24).toString();
          return diff.toString(); 
        },
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: loading
            ? CircularProgressIndicator()
            : Container(
                height: 250,
                child: charts.BarChart(
                  _createSleepData(),
                  animate: true,
                  barRendererDecorator: new charts.BarLabelDecorator(),
                  domainAxis: new charts.OrdinalAxisSpec(),
                  primaryMeasureAxis: new charts.NumericAxisSpec(
                    renderSpec: charts.NoneRenderSpec(),
                  ),
                ),
              ),
      ),
    );
  }
}
