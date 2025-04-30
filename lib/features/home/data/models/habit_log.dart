import 'package:hive/hive.dart';

part 'habit_log.g.dart';

@HiveType(typeId: 1)
class HabitLog extends HiveObject {
  @HiveField(0)
  String habitName;

  @HiveField(1)
  DateTime date;

  @HiveField(2)
  bool completed;

  HabitLog({
    required this.habitName,
    required this.date,
    required this.completed,
  });
}
