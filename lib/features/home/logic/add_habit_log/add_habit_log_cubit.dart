import 'package:bloc/bloc.dart';
import 'package:daily_app/constants.dart';
import 'package:daily_app/core/helper/hive_fun_helper.dart';
import 'package:daily_app/features/home/data/models/habit_log.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';


part 'add_habit_log_state.dart';

class AddHabitLogCubit extends Cubit<AddHabitLogState> {
  AddHabitLogCubit() : super(AddHabitLogInitial());

  Future<void> addHabitLog(HabitLog habitLog) async {
    emit(AddHabitLogLoading());
    try {
      var habitLogBox = Hive.box<HabitLog>(Constants.hiveHabitLogBox);

      // البحث عن سجل العادة في نفس اليوم
      final existingLog = habitLogBox.values.firstWhere(
        (log) =>
            log.habitName == habitLog.habitName &&
            log.date.year == habitLog.date.year &&
            log.date.month == habitLog.date.month &&
            log.date.day == habitLog.date.day,
        orElse: () => HabitLog(
          habitName: habitLog.habitName,
          date: habitLog.date,
          completed: habitLog.completed,
        ),
      );
      print('Existing log: $existingLog');

      if (existingLog.completed == habitLog.completed) {
        print(
            'Habit log is already up to date: ${existingLog.habitName} on ${existingLog.date}');
        await HiveFunctionsHelper.saveWeeklyStatistics();
        // إذا كانت حالة العادة لم تتغير، لا حاجة لتحديثها.
        emit(AddHabitLogSuccess(message: 'Habit log is already up to date'));
      } else {
        // إذا كان السجل فارغًا أو يتطلب التحديث، نقوم بتحديثه أو إضافته
        existingLog.completed = habitLog.completed;
        habitLogBox.put(existingLog.key, existingLog); // تحديث السجل
        print(
            'Habit log updated: ${existingLog.habitName} on ${existingLog.date}');
        await HiveFunctionsHelper.saveWeeklyStatistics();
        emit(AddHabitLogSuccess(message: 'Habit log updated successfully'));
      }
    } catch (e) {
      emit(AddHabitLogError(error: 'Failed to add habit log'));
    }
  }
}
