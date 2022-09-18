import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';

class BarChartWidget extends StatefulWidget {
  const BarChartWidget({Key? key}) : super(key: key);

  @override
  State<BarChartWidget> createState() => _BarChartWidgetState();
}

class Pair<T1, T2> {
  final T1 a;
  final T2 b;

  Pair(this.a, this.b);
}

class _BarChartWidgetState extends State<BarChartWidget> {
  //TODO: replace with actual values
  List<Pair> barChartValues = [
    Pair(15.0, 12.0),
    Pair(11.0, 7.0),
    Pair(5.0, 3.0),
    Pair(5.0, 1.0)
  ];

  Widget _bottomTitles(double value, TitleMeta meta) {
    List<String> months = Languages.of(context)!.months;
    int currentMonth = DateTime.now().month;

    String text;
    // get labels for previous four months
    switch (value.toInt()) {
      case 0: text = months[(currentMonth - 5) % months.length]; break;
      case 1: text = months[(currentMonth - 4) % months.length]; break;
      case 2: text = months[(currentMonth - 3) % months.length]; break;
      case 3: text = months[(currentMonth - 2) % months.length]; break;
      default: text = ''; break;
    }

    return SideTitleWidget(
      child: Text(text, style: Theme.of(context).textTheme.labelMedium),
      axisSide: meta.axisSide,
    );
  }

  Widget _leftTitles(double value, TitleMeta meta) {
    return SideTitleWidget(
      child: Text(
        meta.formattedValue,
        //style: style,
      ),
      axisSide: meta.axisSide,
    );
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return BarChart(
      BarChartData(
        groupsSpace: 40,
        alignment: BarChartAlignment.center,
        barTouchData: BarTouchData(
          enabled: false,
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 35,
              getTitlesWidget: _bottomTitles,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 35,
              getTitlesWidget: _leftTitles,
            ),
          ),
          topTitles: AxisTitles(sideTitles: null),
          rightTitles: AxisTitles(sideTitles: null),
        ),
        barGroups: [
          ...barChartValues.map(
            (values) => BarChartGroupData(
              x: index++,
              barRods: [
                BarChartRodData(
                  toY: values.a,
                  width: 10,
                  borderRadius: const BorderRadius.all(Radius.circular(0)),
                  color: Theme.of(context).colorScheme.primary,
                ),
                BarChartRodData(
                  toY: values.b,
                  width: 10,
                  borderRadius: const BorderRadius.all(Radius.circular(0)),
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
