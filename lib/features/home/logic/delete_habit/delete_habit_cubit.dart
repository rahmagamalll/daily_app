import 'package:bloc/bloc.dart';
import 'package:daily_app/constants.dart';
import 'package:daily_app/core/helper/hive_fun_helper.dart';
import 'package:daily_app/features/home/data/models/habit_model.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'delete_habit_state.dart';

class DeleteHabitCubit extends Cubit<DeleteHabitState> {
  DeleteHabitCubit() : super(DeleteHabitInitial());
  void deleteHabit(String habitName) async {
    emit(DeleteHabitLoading());
    try {
      var habitBox = Hive.box<Habit>(Constants.hiveHabitNameBox);
      final habitKey = habitBox.keys.firstWhere(
        (key) => habitBox.get(key)?.name == habitName,
        orElse: () => null,
      );

      if (habitKey != null) {
        await habitBox.delete(habitKey);
      }
      await  HiveFunctionsHelper.saveWeeklyStatistics();
      emit(DeleteHabitSuccess(message: 'Habit deleted successfully'));
    } catch (e) {
      emit(DeleteHabitError(error: 'Failed to delete habit'));
    }
  }
}
