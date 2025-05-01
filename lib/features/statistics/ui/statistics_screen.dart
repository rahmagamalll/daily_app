import 'package:daily_app/core/theming/colors.dart';
import 'package:flutter/material.dart';
import '../../../core/widgets/habits_statistics_widget.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Statistics',
          style: TextStyle(fontFamily: 'Nunito'),
        ),
        backgroundColor: ColorsManager.primaryColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const HabitsStatisticsWidget(),
            const SizedBox(height: 20),
            const Text(
              'Habits Statistics',
              style: TextStyle(
                  fontSize: 20, color: Colors.black, fontFamily: 'Nunito'),
            ),
          ],
        ),
      ),


      
    );
  }
}
