import 'package:daily_app/core/helper/share_pref_helper.dart';
import 'package:daily_app/core/helper/shared_pref_keys.dart';
import 'package:daily_app/core/helper/spacing.dart';
import 'package:daily_app/core/theming/styles.dart';
import 'package:daily_app/core/widgets/custom_elevation_button.dart';
import 'package:daily_app/features/home/ui/home_screen.dart';
import 'package:daily_app/features/profile/ui/widgets/personal_info_form.dart';
import 'package:daily_app/features/profile/ui/widgets/user_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? firstname;
  String? lastname;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Login',
                  style: TextStylesManager.font18Regular(context),
                ),
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            verticalSpacing(20),
                            UserImage(onChangedPhoto: (String ) {  },),
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
                            verticalSpacing(110),
                            CustomElevationButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  SharePrefHelper.setData(
                                    SharedPrefKeys.userName,
                                    firstname!,
                                  );
                                  SharePrefHelper.setData(
                                    SharedPrefKeys.userLastName,
                                    lastname!,
                                  );
                                  SharePrefHelper.setData(
                                    SharedPrefKeys.login,
                                    true,
                                  );

                               Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>HomeScreen(toggleTheme: (bool ) {  },),
                                  ));
                                }
                              },
                              title: 'Login',
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
