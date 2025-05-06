import 'package:daily_app/core/helper/hive_fun_helper.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class HabitsStatisticsWidget extends StatelessWidget {
  const HabitsStatisticsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, double>>(
      future: HiveFunctionsHelper.getHabitsStatistics(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
              child: Text('Error: ${snapshot.error}',
                  style: TextStyle(fontFamily: 'Nunito')));
        }

        final dataMap = snapshot.data ?? {};
        final colorList =  HiveFunctionsHelper.getHabitColors(dataMap.length);

        return PieChart(
          dataMap: dataMap,
          animationDuration: const Duration(milliseconds: 800),
          chartLegendSpacing: 32,
          chartRadius: MediaQuery.of(context).size.width / 3.2,
          colorList: colorList,
          initialAngleInDegree: 0,
          chartType: ChartType.ring,
          ringStrokeWidth: 32,
          centerText: "HABITS",
          legendOptions: const LegendOptions(
            showLegendsInRow: false,
            legendPosition: LegendPosition.right,
            showLegends: true,
            legendShape: BoxShape.circle,
            legendTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Nunito',
            ),
          ),
          chartValuesOptions: const ChartValuesOptions(
            showChartValueBackground: true,
            showChartValues: true,
            showChartValuesInPercentage: false,
            showChartValuesOutside: false,
            decimalPlaces: 1,
          ),
        );
      },
    );
  }
}
