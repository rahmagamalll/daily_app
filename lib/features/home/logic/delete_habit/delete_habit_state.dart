part of 'delete_habit_cubit.dart';

@immutable
class DeleteHabitState {}

class DeleteHabitInitial extends DeleteHabitState {}

class DeleteHabitLoading extends DeleteHabitState {}

class DeleteHabitSuccess extends DeleteHabitState {
  final String message;
  DeleteHabitSuccess({required this.message});
}
class DeleteHabitError extends DeleteHabitState {
  final String error;
  DeleteHabitError({required this.error});
}
