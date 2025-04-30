part of 'all_habit_cubit.dart';

@immutable
class AllHabitState {}

class AllHabitInitial extends AllHabitState {}

class AllHabitLoading extends AllHabitState {}

class AllHabitSuccess extends AllHabitState {
  final List<Habit> habitList;
  AllHabitSuccess({required this.habitList});
}
class AllHabitError extends AllHabitState {
  final String error;
  AllHabitError({required this.error});
}
