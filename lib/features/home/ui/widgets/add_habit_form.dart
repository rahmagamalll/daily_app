import 'package:daily_app/core/theming/colors.dart';
import 'package:daily_app/core/widgets/custom_elevation_button.dart';
import 'package:daily_app/core/widgets/custom_text_form_field.dart';
import 'package:daily_app/features/home/data/models/habit_model.dart';
import 'package:daily_app/features/home/logic/add_habit/add_habit_cubit.dart';
import 'package:daily_app/features/home/logic/all_habit/all_habit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddHabitForm extends StatefulWidget {
  const AddHabitForm({super.key});

  @override
  State<AddHabitForm> createState() => _AddHabitFormState();
}

class _AddHabitFormState extends State<AddHabitForm> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? title, content;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Form(
      key: formKey,
      child: Column(
        children: [
          const SizedBox(height: 60),
          Container(
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[800] : const Color(0xffF3F3F3),
              borderRadius: BorderRadius.all(
                Radius.circular(10.r),
              ),
            ),
            child: CustomTextFormField(
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
              onChanged: (data) => title = data,
              hintText: 'Title',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 20),
          CustomElevationButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Habit newHabit = Habit(
                  name: title!,
                );
                context.read<AddHabitCubit>().addHabit(newHabit);
                context.read<AllHabitCubit>().getAllHabit();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Habit added successfully!'),
                    backgroundColor: ColorsManager.green,
                  ),
                );
              }
            },
            title: 'Add',
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
