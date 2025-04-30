
import 'package:daily_app/constants.dart';
import 'package:daily_app/features/home/data/models/habit_log.dart';
import 'package:hive/hive.dart';

Future<int> getCompletedCountForHabit(String habitName) async {
  var habitLogBox = await Hive.openBox<HabitLog>(Constants.hiveHabitLogBox);

  final count = habitLogBox.values.where(
    (log) => log.habitName == habitName && log.completed,
  ).length;

  return count;
}


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
    print('Error checking habit completion: $e');
    return false;
  }
}
