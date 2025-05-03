// ignore: must_be_immutable
import 'package:daily_app/core/theming/colors.dart';
import 'package:daily_app/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

// ignore: must_be_immutable
class CustomPieChart extends StatelessWidget {
  const CustomPieChart({
    super.key,
    required this.finalDegreeOf100,
    required this.monthlyexams,
    required this.bonus,
    required this.homework,
    required this.chartRadius,
    required this.colorList,
    this.centerTextStyle,
  });

  final String finalDegreeOf100;
  final double monthlyexams;
  final double bonus;
  final double homework;
  final double chartRadius;
  final List<Color> colorList;
  final TextStyle? centerTextStyle;

  @override
  Widget build(BuildContext context) {
    return PieChart(
      dataMap: {
        "90% Monthly exams": monthlyexams,
        "2% Bonus": bonus,
        "10% Homework": homework,
      },
      colorList: colorList,
      chartRadius: chartRadius,
      centerText: finalDegreeOf100,
      centerTextStyle: centerTextStyle ??
          TextStylesManager.font16MediumGreyMedium
              .copyWith(color: ColorsManager.green),
      ringStrokeWidth: 9,
      chartType: ChartType.ring,
      animationDuration: const Duration(seconds: 2),
      chartValuesOptions: const ChartValuesOptions(
        showChartValues: false,
        showChartValuesOutside: false,
        showChartValuesInPercentage: true,
        showChartValueBackground: false,
      ),
      legendOptions: LegendOptions(
        legendShape: BoxShape.circle,
        showLegends: false,
        legendTextStyle: TextStylesManager.font12BlackRegular
            .copyWith(fontWeight: FontWeight.w500),
        legendPosition: LegendPosition.right,
        showLegendsInRow: false,
      ),
    );
  }
}
