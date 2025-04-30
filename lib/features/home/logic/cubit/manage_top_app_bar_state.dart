part of 'manage_top_app_bar_cubit.dart';

@immutable
class ManageTopAppBarState {}

class ManageTopAppBarInitial extends ManageTopAppBarState {}

class ManageTopAppBarLoading extends ManageTopAppBarState {}


class ManageTopAppBarSuccess extends ManageTopAppBarState {
  final String firstName;
  final String lastName;
  final String photo;

  ManageTopAppBarSuccess({
    required this.firstName,
    required this.lastName,
    required this.photo,
  });
}
class ManageTopAppBarError extends ManageTopAppBarState {
  final String error;
  ManageTopAppBarError({required this.error});
}
