import 'package:finance/data/model/add_data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../data/utility.dart';

class Chart extends StatefulWidget {
  final int indexX;
  const Chart({super.key, required this.indexX});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<AddData>? a;

  @override
  Widget build(BuildContext context) {
    // Pick dataset based on index
    switch (widget.indexX) {
      case 0:
        a = today();
        break;
      case 1:
        a = week();
        break;
      case 2:
        a = month();
        break;
      case 3:
        a = year();
        break;
    }

    // Fixed 7 days (Mon=1 .. Sun=7)
    List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    // Initialize map with 0 spent for all days
    Map<int, int> dayTotals = {for (int i = 1; i <= 7; i++) i: 0};

    // Sum spending per weekday
    for (var entry in a!) {
      int weekday = entry.dateTime.weekday; // 1=Mon .. 7=Sun
      int amount = int.tryParse(entry.amount) ?? 0; // safe parse
      dayTotals[weekday] = dayTotals[weekday]! + amount;
    }

    // Convert to SalesData list
    List<SalesData> chartData = [
      for (int i = 1; i <= 7; i++) SalesData(weekdays[i - 1], dayTotals[i]!)
    ];

    return Container(
      width: double.infinity,
      height: 300,
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <SplineSeries<SalesData, String>>[
          SplineSeries<SalesData, String>(
            color: const Color.fromARGB(255, 47, 125, 121),
            width: 3,
            dataSource: chartData,
            xValueMapper: (SalesData sales, _) => sales.label,
            yValueMapper: (SalesData sales, _) => sales.value,
          )
        ],
      ),
    );
  }
}

class SalesData {
  SalesData(this.label, this.value);
  final String label;
  final int value;
}
