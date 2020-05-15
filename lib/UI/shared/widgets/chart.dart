import 'package:covid_19/core/model/summary_country_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartSample extends StatefulWidget {
  final String countryName;
  final List<SummaryCountry> data;

  const BarChartSample({this.countryName, this.data});

  @override
  _BarChartSampleState createState() => _BarChartSampleState();
}

class _BarChartSampleState extends State<BarChartSample> {
  final Color barBackgroundColor = const Color(0xFF0E3360);
  final Duration animDuration = const Duration(milliseconds: 250);
  List<SummaryCountry> get data => widget.data;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: const Color(0xff09274B),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    child: BarChart(
                      mainBarData(data),
                      swapAnimationDuration: animDuration,
                    ),
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

BarChartData mainBarData(List<SummaryCountry> data) {
  return BarChartData(
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
            showTitles: true,
            textStyle: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
            margin: 16,
            getTitles: (double value) {
              return dateToNumber(data[data.length - 7 + value.toInt()].date)
                  .toString();
            }),
        leftTitles: SideTitles(showTitles: false),
      ),
      borderData: FlBorderData(show: false),
      barGroups: showingGroups(data));
}

List<BarChartGroupData> showingGroups(List<SummaryCountry> data) {
  return [
    for (var i = 7; i >= 1; i--)
      BarChartGroupData(x: 10, barRods: [
        BarChartRodData(
            y: activeCount(data[data.length - i - 1].deaths,
                    data[data.length - i].deaths)
                .toDouble()),
      ])
  ];
}

int dateToNumber(String date) {
  return DateTime.parse(date).day;
}

int activeCount(int count1, int count2) {
  return count2 - count1;
}
