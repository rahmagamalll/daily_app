import 'package:flutter/material.dart';
import '../../features/home/data/models/weekly_statistics.dart';
import '../../services/weekly_statistics_service.dart';

class WeeklyStatisticsWidget extends StatelessWidget {
  const WeeklyStatisticsWidget({super.key});

  Future<List<WeeklyStatistics>> _refreshAndGetStats() async {
    await WeeklyStatisticsService.saveWeeklyStatistics();
    return WeeklyStatisticsService.getAllWeeklyStatistics();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<WeeklyStatistics>>(
      future: WeeklyStatisticsService.getAllWeeklyStatistics(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(fontFamily: 'Nunito'),
            ),
          );
        }

        final weeklyStats = snapshot.data!;

        if (weeklyStats.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 60),
              child: Text(
                'No weekly statistics available.',
                style: TextStyle(fontFamily: 'Nunito'),
              ),
            ),
          );
        }

        return Column(
          children: [
            const Text(
              'Current Week Statistics',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildCurrentWeekStats(weeklyStats.last),
            const SizedBox(height: 40),
            const Text(
              'Previous Weeks',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ...weeklyStats.reversed
                .skip(1)
                .map((stats) => _buildPreviousWeekStats(stats))
                .toList(),
          ],
        );
      },
    );
  }

  Widget _buildCurrentWeekStats(WeeklyStatistics stats) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildHabitCard(
                  'Top Habit',
                  stats.topHabit,
                  stats.statistics[stats.topHabit] ?? 0,
                  Icons.arrow_upward,
                  Colors.green,
                ),
                _buildHabitCard(
                  'Least Habit',
                  stats.leastHabit,
                  stats.statistics[stats.leastHabit] ?? 0,
                  Icons.arrow_downward,
                  Colors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviousWeekStats(WeeklyStatistics stats) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Week of ${stats.weekStartDate}',
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildHabitCard(
                  'Top Habit',
                  stats.topHabit,
                  stats.statistics[stats.topHabit] ?? 0,
                  Icons.arrow_upward,
                  Colors.green,
                ),
                _buildHabitCard(
                  'Least Habit',
                  stats.leastHabit,
                  stats.statistics[stats.leastHabit] ?? 0,
                  Icons.arrow_downward,
                  Colors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHabitCard(
    String title,
    String habitName,
    double count,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              habitName,
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Count: $count',
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
