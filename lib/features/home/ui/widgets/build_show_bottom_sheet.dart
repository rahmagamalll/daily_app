import 'package:daily_app/features/home/logic/add_habit/add_habit_cubit.dart';
import 'package:daily_app/features/home/logic/all_habit/all_habit_cubit.dart';
import 'package:daily_app/features/home/ui/widgets/add_habit_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class BuildShowBottomSheet extends StatelessWidget {
   BuildShowBottomSheet({required this.context,
    super.key,
  });
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddHabitCubit(),
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: BlocListener<AddHabitCubit, AddHabitState>(
            listener: (context, state) {
              if (state is AddHabitSuccess) {
                Navigator.pop(context);
                context.read<AllHabitCubit>().getAllHabit();
              } else if (state is AddHabitError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
            child: BlocBuilder<AddHabitCubit, AddHabitState>(
              builder: (context, state) {
                return AddHabitForm();
              },
            ),
          ),
        ),
      ),
    );
  }
}
