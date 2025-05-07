import 'dart:ui';

import 'package:daily_app/constants.dart';
import 'package:daily_app/features/home/data/models/habit_log.dart';
import 'package:daily_app/features/home/data/models/habit_model.dart';
import 'package:daily_app/features/statistics/data/models/weekly_statistics.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HiveFunctionsHelper {

// Store habits at the start of the day
 static Future<void> storeHabitsAtStartOfDay() async {
  try {
    print('Starting to store habits at the start of the day...');

    var habitNamesBox = await Hive.openBox<Habit>(Constants.hiveHabitNameBox);
    var habitLogBox = await Hive.openBox<HabitLog>(Constants.hiveHabitLogBox);

    final today = DateTime.now();

    for (var habit in habitNamesBox.values) {
      final exists = habitLogBox.values.any(
        (log) =>
            log.habitName == habit.name &&
            log.date.year == today.year &&
            log.date.month == today.month &&
            log.date.day == today.day,
      );

      if (!exists) {
        habitLogBox.add(HabitLog(
          habitName: habit.name,
          date: today,
          completed: false,
        ));
        print('Initialized log for habit: ${habit.name}');
      } else {
        print('Log already exists for habit: ${habit.name}');
      }
    }
  } catch (e) {
    print('Error while storing habit logs: $e');
  }
}

//count completed habits for a specific habit name
  Future<int> getCompletedCountForHabit(String habitName) async {
    var habitLogBox = await Hive.openBox<HabitLog>(Constants.hiveHabitLogBox);
    final count = habitLogBox.values
        .where(
          (log) => log.habitName == habitName && log.completed,
        )
        .length;
    return count;
  }

// Check if a habit is completed for a specific date
  Future<bool> isHabitCompleted(
    String habitName,
    DateTime date,
    Box<HabitLog> habitLogBox,
  ) async {
    try {
      final habitLog = habitLogBox.values.firstWhere(
        (log) =>
            log.habitName == habitName &&
            log.date.year == date.year &&
            log.date.month == date.month &&
            log.date.day == date.day,
        orElse: () => throw Exception("No log found"),
      );

      return habitLog.completed;
    } catch (e) {
      // ignore: avoid_print
      print('Error checking habit completion: $e');
      return false;
    }
  }

// get count of completed habits for statistics
  static Future<Map<String, double>> getHabitsStatistics() async {
    final habitLogBox = await Hive.openBox<HabitLog>(Constants.hiveHabitLogBox);
    final habitNameBox = await Hive.openBox<Habit>(Constants.hiveHabitNameBox);
    Map<String, double> statistics = {};

    // Get list of current habit names
    final currentHabitNames =
        habitNameBox.values.map((habit) => habit.name).toList();

    // If the habit exists in statistics, increment its count
    for (var habitLog in habitLogBox.values) {
      if (habitLog.completed &&
          currentHabitNames.contains(habitLog.habitName)) {
        if (statistics.containsKey(habitLog.habitName)) {
          statistics[habitLog.habitName] = statistics[habitLog.habitName]! + 1;
        } else {
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

  // Generate a list of distinct colors based on the number of habits
  static List<Color> getHabitColors(int count) {
    return List.generate(count, (index) {
      return Colors.primaries[index % Colors.primaries.length];
    });
  }

// Save weekly statistics to Hive
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

// Get the weekly statistics for the current week
  static Future<List<WeeklyStatistics>> getAllWeeklyStatistics() async {
    final statsBox = await Hive.openBox<WeeklyStatistics>('weekly_stats');
    return statsBox.values.toList();
  }

// Get the weekly statistics for a specific week
  static Future<Map<String, double>> _calculateWeeklyStatistics() async {
    final habitLogBox = await Hive.openBox<HabitLog>(Constants.hiveHabitLogBox);
    final habitNameBox = await Hive.openBox<Habit>(Constants.hiveHabitNameBox);
    Map<String, double> statistics = {};

    final currentHabitNames =
        habitNameBox.values.map((habit) => habit.name).toList();
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final weekEnd = weekStart.add(const Duration(days: 6));

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

// get top and least habits by sorting the statistics
  static Future<Map<String, dynamic>> _getTopAndLeastHabits(
      Map<String, double> statistics) async {

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
