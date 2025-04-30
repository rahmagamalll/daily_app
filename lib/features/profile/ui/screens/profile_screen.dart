import 'package:daily_app/core/helper/spacing.dart';
import 'package:daily_app/core/widgets/custom_elevation_button.dart';
import 'package:daily_app/core/widgets/top_app_bar.dart';
import 'package:daily_app/features/home/logic/cubit/manage_top_app_bar_cubit.dart';
import 'package:daily_app/features/profile/ui/widgets/personal_info_form.dart';
import 'package:daily_app/features/profile/ui/widgets/user_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? firstname;
  String? lastname;
  String? imagePathFromGallery;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TopAppBar(title: 'Profile'),
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            verticalSpacing(20),
                            UserImage(onChangedPhoto: (value) {
                              imagePathFromGallery = value;
                            }),
                            verticalSpacing(20),
                            PersonalInfoForm(
                              onChangedFirstName: (value) {
                                firstname = value;
                              },
                              onChangedLastName: (value) {
                                lastname = value;
                              },
                            ),
                          ],
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            verticalSpacing(150),
                            CustomElevationButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context
                                      .read<ManageTopAppBarCubit>()
                                      .updateTopAppBarInfo(
                                        firstname!,
                                        lastname!,
                                        imagePathFromGallery?? '',
                                      );
                                  Navigator.pop(context, true);
                                }
                              },
                              title: 'Save',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
