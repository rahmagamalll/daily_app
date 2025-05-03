import 'package:hive/hive.dart';
import '../constants.dart';
import '../features/home/data/models/habit_log.dart';
import '../features/home/data/models/habit_model.dart';
import '../features/home/data/models/weekly_statistics.dart';

class WeeklyStatisticsService {
  static Future<void> saveWeeklyStatistics() async {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final weekStartStr =
        '${weekStart.year}-${weekStart.month}-${weekStart.day}';

    final statistics = await _calculateWeeklyStatistics();
    final topAndLeast = await _getTopAndLeastHabits(statistics);

    final weeklyStats = WeeklyStatistics(
      weekStartDate: weekStartStr,
      statistics: statistics,
      topHabit: topAndLeast['top']['name'],
      leastHabit: topAndLeast['least']['name'],
    );

    final statsBox = await Hive.openBox<WeeklyStatistics>('weekly_stats');
    await statsBox.put(weekStartStr, weeklyStats);
  }

  static Future<List<WeeklyStatistics>> getAllWeeklyStatistics() async {
    final statsBox = await Hive.openBox<WeeklyStatistics>('weekly_stats');
    return statsBox.values.toList();
  }

  static Future<Map<String, double>> _calculateWeeklyStatistics() async {
    final habitLogBox = await Hive.openBox<HabitLog>(Constants.hiveHabitLogBox);
    final habitNameBox = await Hive.openBox<Habit>(Constants.hiveHabitNameBox);
    Map<String, double> statistics = {};

    final currentHabitNames =
        habitNameBox.values.map((habit) => habit.name).toList();
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final weekEnd = weekStart.add(const Duration(days: 6));

    // احسب لكل العادات حتى اللي count بتاعها صفر
    for (var name in currentHabitNames) {
      statistics[name] = 0;
    }

    for (var habitLog in habitLogBox.values) {
      if (habitLog.completed == true &&
          habitLog.date.isAfter(weekStart.subtract(const Duration(days: 1))) &&
          habitLog.date.isBefore(weekEnd.add(const Duration(days: 1))) &&
          currentHabitNames.contains(habitLog.habitName)) {
        statistics[habitLog.habitName] = statistics[habitLog.habitName]! + 1;
      }
    }

    return statistics;
  }

  static Future<Map<String, dynamic>> _getTopAndLeastHabits(
      Map<String, double> statistics) async {
    // هنا بنستخدم statistics اللي فيها كل العادات حتى اللي count بتاعها صفر
    final sortedHabits = statistics.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    if (sortedHabits.isEmpty) {
      return {
        'top': {'name': 'No habits', 'count': 0},
        'least': {'name': 'No habits', 'count': 0}
      };
    }

    return {
      'top': {
        'name': sortedHabits.first.key,
        'count': sortedHabits.first.value
      },
      'least': {'name': sortedHabits.last.key, 'count': sortedHabits.last.value}
    };
  }
}
