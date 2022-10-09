import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/logic/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BarChartWidget extends StatefulWidget {
  const BarChartWidget({Key? key, required this.searchHistoryData})
      : super(key: key);

  final List<dynamic> searchHistoryData;

  @override
  State<BarChartWidget> createState() => _BarChartWidgetState();
}

class ChartValuePair {
  double searchedItemAmount;
  double savedItemAmount;

  ChartValuePair(this.searchedItemAmount, this.savedItemAmount);

  void incrementSearchedItemAmount() => searchedItemAmount++;

  void incrementSavedItemAmount() => savedItemAmount++;
}

class _BarChartWidgetState extends State<BarChartWidget> {
  Map<int, ChartValuePair> barChartValues = {};
  bool? learnMore;

  @override
  initState() {
    super.initState();
    _prepareChartValues();
  }

  void _prepareChartValues() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    bool? learnMoreBool = _prefs.getBool(Constants.prefLearnMore);

    // fill with default values
    Map<int, ChartValuePair> chartData = {};
    int index = DateTime.now().month - 3;
    for (int i = index; i <= DateTime.now().month; i++) {
      chartData[i] = ChartValuePair(0, 0);
    }

    for (dynamic element in widget.searchHistoryData) {
      DateTime searchHistoryDate = DateTime.parse(element["createdAt"]);
      ChartValuePair valuePair = chartData[searchHistoryDate.month]!;
      valuePair.incrementSearchedItemAmount();
      bool sortedCorrectly = element["sorted_correctly"] ?? false;
      if (!sortedCorrectly) valuePair.incrementSavedItemAmount();
    }

    setState(() {
      barChartValues = chartData;
      learnMore = learnMoreBool ?? false;
    });
  }

  Widget _bottomTitles(double value, TitleMeta meta) {
    List<String> months = Languages.of(context)!.months;
    int currentMonth = DateTime.now().month;

    String text;
    // get labels for previous four months
    switch (value.toInt()) {
      case 0:
        text = months[(currentMonth - 4) % months.length];
        break;
      case 1:
        text = months[(currentMonth - 3) % months.length];
        break;
      case 2:
        text = months[(currentMonth - 2) % months.length];
        break;
      case 3:
        text = months[(currentMonth - 1) % months.length];
        break;
      default:
        text = '';
        break;
    }

    return SideTitleWidget(
      child: Text(text, style: Theme.of(context).textTheme.labelMedium),
      axisSide: meta.axisSide,
    );
  }

  Widget _leftTitles(double value, TitleMeta meta) {
    return SideTitleWidget(
      child: Text(meta.formattedValue),
      axisSide: meta.axisSide,
    );
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return barChartValues.isEmpty || learnMore == null
        ? const Center(child: CircularProgressIndicator())
        : BarChart(
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
                ...barChartValues.values.map(
                  (values) => BarChartGroupData(
                    x: index++,
                    barRods: [
                      BarChartRodData(
                        toY: values.searchedItemAmount,
                        width: 10,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(0)),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      if (learnMore!)
                        BarChartRodData(
                          toY: values.savedItemAmount,
                          width: 10,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(0)),
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
