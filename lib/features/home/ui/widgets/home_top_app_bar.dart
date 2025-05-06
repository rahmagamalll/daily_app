import 'dart:io';

import 'package:daily_app/core/helper/share_pref_helper.dart';
import 'package:daily_app/core/helper/shared_pref_keys.dart';
import 'package:daily_app/core/theming/colors.dart';
import 'package:daily_app/core/theming/styles.dart';
import 'package:daily_app/features/home/logic/cubit/manage_top_app_bar_cubit.dart';
import 'package:daily_app/features/profile/ui/screens/profile_screen.dart';
import 'package:daily_app/features/statistics/ui/statistics_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTopAppBar extends StatefulWidget {
  const HomeTopAppBar({super.key, required this.toggleTheme});
  final void Function(bool) toggleTheme;

  @override
  State<HomeTopAppBar> createState() => _HomeTopAppBarState();
}

class _HomeTopAppBarState extends State<HomeTopAppBar> {
  String? name;
  String? lastName;
  String? userPhoto;
  @override
  void initState() {
    getName();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getName();
  }

  Future<void> getName() async {
    String? fetchedName =
        await SharePrefHelper.getString(SharedPrefKeys.userName);
    String? fetchedLastName =
        await SharePrefHelper.getString(SharedPrefKeys.userLastName);
    String? fetchedUserPhoto =
        await SharePrefHelper.getString(SharedPrefKeys.userPhoto);

    if (fetchedName != name ||
        fetchedLastName != lastName ||
        fetchedUserPhoto != userPhoto) {
      setState(() {
        name = fetchedName;
        lastName = fetchedLastName;
        userPhoto = fetchedUserPhoto;
      });
    }
  }

  Widget buildImage() {
    if (userPhoto != null && userPhoto!.isNotEmpty) {
      return Image.file(
        File(userPhoto!),
        width: 50.r,
        height: 50.r,
        fit: BoxFit.cover,
      );
    }

    return Image.asset(
      'assets/images/user_image.png',
      width: 50.r,
      height: 50.r,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageTopAppBarCubit, ManageTopAppBarState>(
      builder: (context, state) {
        if (state is ManageTopAppBarSuccess) {
          name = state.firstName;
          lastName = state.lastName;
          userPhoto = state.photo;
        }
        return Row(
          children: [
            Text(
              'HI, $name $lastName',
              style: TextStylesManager.font18Bold(context).copyWith(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StatisticsScreen(),
                    ));
              },
              icon: Icon(
                Icons.stacked_bar_chart_rounded,
                size: 35,
                color: ColorsManager.primaryColor,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProfileScreen(
                      onThemeChanged: widget.toggleTheme,
                    ),
                  ),
                );
              },
              child: CircleAvatar(
                radius: 22.r,
                backgroundColor: ColorsManager.primaryColor.withOpacity(0.5),
                child: CircleAvatar(
                  radius: 20.r,
                  backgroundColor: ColorsManager.white,
                  child: ClipOval(child: buildImage()),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
