import 'package:bloc/bloc.dart';
import 'package:daily_app/core/helper/share_pref_helper.dart';
import 'package:daily_app/core/helper/shared_pref_keys.dart';
import 'package:meta/meta.dart';

part 'manage_top_app_bar_state.dart';

class ManageTopAppBarCubit extends Cubit<ManageTopAppBarState> {
  ManageTopAppBarCubit() : super(ManageTopAppBarInitial());

  void updateTopAppBarInfo(String firstName, String lastName, String photo) {
    emit(ManageTopAppBarLoading());
    try {
      SharePrefHelper.setData(SharedPrefKeys.userName, firstName);
      SharePrefHelper.setData(SharedPrefKeys.userLastName, lastName);
      SharePrefHelper.setData(SharedPrefKeys.userPhoto, photo);

      emit(ManageTopAppBarSuccess(
        firstName: firstName,
        lastName: lastName,
        photo: photo,
      ));
    } catch (e) {
      emit(ManageTopAppBarError(error: e.toString()));
    }
  }
}
