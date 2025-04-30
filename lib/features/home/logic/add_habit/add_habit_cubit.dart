import 'package:bloc/bloc.dart';
import 'package:daily_app/constants.dart';
import 'package:daily_app/features/home/data/models/habit_model.dart';
import 'package:daily_app/main.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'add_habit_state.dart';

class AddHabitCubit extends Cubit<AddHabitState> {
  AddHabitCubit() : super(AddHabitInitial());
  void addHabit(Habit habit) async {
    emit(AddHabitLoading());
    try {
      var habitBox = Hive.box<Habit>(Constants.hiveHabitNameBox);
      await habitBox.add(habit);
      await storeHabitsAtStartOfDay();
      print('Habit added: ${habit.name}');

      emit(AddHabitSuccess(message: 'Habit added successfully'));
    } catch (e) {
      emit(AddHabitError(error: 'Failed to add habit'));
    }
  }
}
