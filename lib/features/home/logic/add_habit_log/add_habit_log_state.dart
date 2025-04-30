part of 'add_habit_log_cubit.dart';

@immutable
class AddHabitLogState {}

class AddHabitLogInitial extends AddHabitLogState {}

class AddHabitLogLoading extends AddHabitLogState {}

class AddHabitLogSuccess extends AddHabitLogState {
  final String message;
  AddHabitLogSuccess({required this.message});
}
class AddHabitLogError extends AddHabitLogState {
  final String error;
  AddHabitLogError({required this.error});
}
