import 'package:bloc/bloc.dart';
import 'package:daily_app/constants.dart';
import 'package:daily_app/features/home/data/models/habit_model.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'all_habit_state.dart';

class AllHabitCubit extends Cubit<AllHabitState> {
  AllHabitCubit() : super(AllHabitInitial());
  void getAllHabit() {
    emit(AllHabitLoading());
    try {
      var habitBox = Hive.box<Habit>(Constants.hiveHabitNameBox);
      List<Habit> allHabit = habitBox.values.toList();
      print('allHabit: $allHabit');
      emit(AllHabitSuccess(habitList: allHabit));
    } catch (e) {
      print('Error fetching habits: $e');
      emit(AllHabitError(error: 'Failed to fetch habits'));
    }
  }
}
