part of 'delete_habit_log_cubit.dart';

@immutable
class DeleteHabitLogState {}

class DeleteHabitLogInitial extends DeleteHabitLogState {}

class DeleteHabitLogLoading extends DeleteHabitLogState {}

class DeleteHabitLogSuccess extends DeleteHabitLogState {
  final String message;
  DeleteHabitLogSuccess({required this.message});
}
class DeleteHabitLogError extends DeleteHabitLogState {
  final String error;
  DeleteHabitLogError({required this.error});
}
