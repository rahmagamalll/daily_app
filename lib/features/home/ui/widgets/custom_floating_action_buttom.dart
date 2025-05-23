import 'package:daily_app/core/theming/colors.dart';
import 'package:daily_app/features/home/logic/all_habit/all_habit_cubit.dart';
import 'package:daily_app/features/home/ui/widgets/build_show_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomeFloatingActionBotton extends StatelessWidget {
  const CustomeFloatingActionBotton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return FloatingActionButton(
      onPressed: () async {
        await showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: isDark
              ? const Color.fromARGB(255, 31, 30, 30)
              : ColorsManager.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          context: context,
          builder: (context) {
            return BuildShowBottomSheet(
              context: context,
            );
          },
        );
        context.read<AllHabitCubit>().getAllHabit();
      },
      backgroundColor: ColorsManager.softGrey,
      child: Icon(Icons.add, size: 30, color: ColorsManager.black),
    );
  }
}
