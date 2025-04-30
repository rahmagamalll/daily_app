part of 'add_habit_cubit.dart';

@immutable
class AddHabitState {}

class AddHabitInitial extends AddHabitState {}

class AddHabitLoading extends AddHabitState {}

class AddHabitSuccess extends AddHabitState {
  final String message;
  AddHabitSuccess({required this.message});
}
class AddHabitError extends AddHabitState {
  final String error;
  AddHabitError({required this.error});
}
