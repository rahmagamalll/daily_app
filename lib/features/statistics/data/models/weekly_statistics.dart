import 'package:hive/hive.dart';
part 'weekly_statistics.g.dart';

@HiveType(typeId: 2)
class WeeklyStatistics extends HiveObject {
  @HiveField(0)
  final String weekStartDate;

  @HiveField(1)
  final Map<String, double> statistics;

  @HiveField(2)
  final String topHabit;

  @HiveField(3)
  final String leastHabit;

  WeeklyStatistics({
    required this.weekStartDate,
    required this.statistics,
    required this.topHabit,
    required this.leastHabit,
  });
}
