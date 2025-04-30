import 'package:daily_app/constants.dart';
import 'package:daily_app/core/helper/hive_fun.dart';
import 'package:daily_app/features/home/data/models/habit_log.dart';
import 'package:daily_app/features/home/data/models/habit_model.dart';
import 'package:daily_app/features/home/ui/widgets/daily_item.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

// ignore: must_be_immutable
class HabitsListVeiw extends StatelessWidget {
  HabitsListVeiw({super.key, required this.habitsList});
  List<Habit> habitsList = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Box<HabitLog>>(
      future: Hive.openBox<HabitLog>(Constants.hiveHabitLogBox),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.hasError) {
          return const Center(child: Text('Error loading data'));
        }

        final habitLogBox = snapshot.data!;

        return ListView.builder(
          itemCount: habitsList.length,
          itemBuilder: (context, index) {
            final habit = habitsList[index];
            return FutureBuilder(
              future: Future.wait([
                isHabitCompleted(habit.name, DateTime.now(), habitLogBox),
                getCompletedCountForHabit(habit.name),
              ]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const ListTile(title: Text('loading...'));
                } else if (snapshot.hasError) {
                  return const ListTile(title: Text('Error loading data'));
                } else {
                  final data = snapshot.data as List<dynamic>;
                  final completed = data[0] as bool;
                  final doneCount = data[1] as int;

                  return DailyItem(
                    completed: completed,
                    doneCount: doneCount,
                    habitName: habit.name,
                  );
                }
              },
            );
          },
        );
      },
    );
  }
}

