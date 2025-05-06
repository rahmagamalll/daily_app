import 'package:daily_app/core/helper/spacing.dart';
import 'package:daily_app/features/home/logic/add_habit_log/add_habit_log_cubit.dart';
import 'package:daily_app/features/home/logic/all_habit/all_habit_cubit.dart';
import 'package:daily_app/features/home/ui/widgets/custom_floating_action_buttom.dart';
import 'package:daily_app/features/home/ui/widgets/habits_list_view.dart';
import 'package:daily_app/features/home/ui/widgets/home_top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.toggleTheme});
  final void Function(bool) toggleTheme;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddHabitLogCubit(),
      child: Scaffold(
        floatingActionButton: CustomeFloatingActionBotton(),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                verticalSpacing(8),
                HomeTopAppBar(
                  toggleTheme: widget.toggleTheme,
                ),
                verticalSpacing(20),
                Expanded(
                  child: BlocBuilder<AllHabitCubit, AllHabitState>(
                    builder: (context, state) {
                      if (state is AllHabitError) {
                        return Center(
                          child: Text(state.error),
                        );
                      } else if (state is AllHabitSuccess) {
                        return HabitsListVeiw(
                          habitsList: state.habitList,
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
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
