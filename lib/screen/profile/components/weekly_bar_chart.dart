import 'package:fiton/constant.dart';
import 'package:fiton/models/daily.dart';
import 'package:fiton/models/entry.dart';
import 'package:fiton/services/daily_service.dart';
import 'package:fiton/services/runs_service.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:intl/intl.dart';

class WeeklyBarChart extends StatefulWidget {
  WeeklyBarChart({Key? key, required this.choose}) : super(key: key);
  int choose;
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
        colorFn: (_, __) => charts.MaterialPalette.lime.shadeDefault.darker,
        domainFn: (Entry entry, _) => DateFormat('EE').format(entry.date),
        measureFn: (Entry entry, _) => entry.distance / 1000,
        labelAccessorFn: (Entry entry, _) => '${entry.distance.toInt() / 1000}',
      )
    ];
  }

  List<charts.Series<Daily, String>> _createBurnData() {
    return [
      charts.Series<Daily, String>(
        data: _daily,
        id: 'Burn',
        colorFn: (_, __) =>
            charts.MaterialPalette.deepOrange.shadeDefault.darker,
        domainFn: (Daily daily, _) => DateFormat('EE').format(daily.date),
        measureFn: (Daily daily, _) => daily.burn,
        labelAccessorFn: (Daily daily, _) => '${daily.burn?.toInt()}',
      )
    ];
  }

  List<charts.Series<Daily, String>> _createWeightData() {
    return [
      charts.Series<Daily, String>(
        data: _daily,
        id: 'Sleep',
        colorFn: (_, __) =>
            charts.MaterialPalette.deepOrange.shadeDefault.darker,
        domainFn: (Daily daily, _) => DateFormat('EE').format(daily.date),
        measureFn: (Daily daily, _) => daily.weight,
        labelAccessorFn: (Daily daily, _) => '${daily.weight.toInt()}',
      )
    ];
  }

  List<charts.Series<Daily, String>> _createSleepData() {
    return [
      charts.Series<Daily, String>(
        data: _daily,
        id: 'Weight',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault.darker,
        domainFn: (Daily daily, _) => DateFormat('EE').format(daily.date),
        measureFn: (Daily daily, _) {
          var format = DateFormat("HH:mm");
          var wake = format.parse(daily.wake);
          var sleep = format.parse(daily.sleep);
          int diff = wake.difference(sleep).inHours;
          if (diff.isNegative) return diff + 24;
          return diff;
        },
        labelAccessorFn: (Daily daily, _) {
          var format = DateFormat("HH:mm");
          var wake = format.parse(daily.wake);
          var sleep = format.parse(daily.sleep);
          int diff = wake.difference(sleep).inHours;
          if (diff.isNegative) return (diff + 24).toString();
          return diff.toString();
        },
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: loading
          ? CircularProgressIndicator()
          : Container(
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.circular(12),
              ),
              height: size.height,
              child: charts.BarChart(
                widget.choose == 1
                    ? _createSleepData()
                    : widget.choose == 2
                        ? _createWeightData()
                        : widget.choose == 3
                            ? _createRunData()
                            : _createBurnData(),
                animate: true,
                barRendererDecorator: new charts.BarLabelDecorator(),
                domainAxis: new charts.OrdinalAxisSpec(),
                primaryMeasureAxis: new charts.NumericAxisSpec(
                  renderSpec: charts.NoneRenderSpec(),
                ),
                behaviors: [
                  charts.ChartTitle(
                    widget.choose == 1
                        ? "Hours of Sleep"
                        : widget.choose == 2
                            ? "Weight Body"
                            : widget.choose == 3
                                ? "Kilometers of Run"
                                : "Burned Calories",
                    behaviorPosition: charts.BehaviorPosition.top,
                    titleOutsideJustification:
                        charts.OutsideJustification.middle,
                    innerPadding: 18,
                  ),
                ],
              ),
            ),
    );
  }
}
