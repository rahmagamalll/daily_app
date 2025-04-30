import 'package:bloc/bloc.dart';
import 'package:daily_app/constants.dart';
import 'package:daily_app/features/home/data/models/habit_log.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'delete_habit_log_state.dart';

class DeleteHabitLogCubit extends Cubit<DeleteHabitLogState> {
  DeleteHabitLogCubit() : super(DeleteHabitLogInitial());
  void deleteHabitLog(int index) {
    emit(DeleteHabitLogLoading());
    try {
      var habitLogBox = Hive.box<HabitLog>(Constants.hiveHabitLogBox);
      habitLogBox.deleteAt(index);
      emit(DeleteHabitLogSuccess(message: 'Habit log deleted successfully'));
    } catch (e) {
      emit(DeleteHabitLogError(error: 'Failed to delete habit log'));
    }
  }
}
