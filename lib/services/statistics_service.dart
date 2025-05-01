import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../features/home/data/models/habit_log.dart';
import '../features/home/data/models/habit_model.dart';

class StatisticsService {
  static Future<Map<String, double>> getHabitsStatistics() async {
    final habitLogBox = await Hive.openBox<HabitLog>(Constants.hiveHabitLogBox);
    final habitNameBox = await Hive.openBox<Habit>(Constants.hiveHabitNameBox);
    Map<String, double> statistics = {};

    // Get list of current habit names
    final currentHabitNames =
        habitNameBox.values.map((habit) => habit.name).toList();

    // Get all habits from Hive
    for (var habitLog in habitLogBox.values) {
      // Only count habits that still exist
      if (habitLog.completed &&
          currentHabitNames.contains(habitLog.habitName)) {
        // If the habit exists in statistics, increment its count
        if (statistics.containsKey(habitLog.habitName)) {
          statistics[habitLog.habitName] = statistics[habitLog.habitName]! + 1;
        } else {
          // If it's the first completion for this habit
          statistics[habitLog.habitName] = 1;
        }
      }
    }

    // If there are no completed habits, add a default value to avoid empty chart
    if (statistics.isEmpty) {
      statistics['No completed habits'] = 1;
    }

    return statistics;
  }

  static List<Color> getHabitColors(int count) {
    // Generate a list of distinct colors based on the number of habits
    return List.generate(count, (index) {
      return Colors.primaries[index % Colors.primaries.length];
    });
  }
}
