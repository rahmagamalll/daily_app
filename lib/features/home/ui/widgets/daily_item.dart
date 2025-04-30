import 'package:daily_app/core/theming/colors.dart';
import 'package:daily_app/features/home/data/models/habit_log.dart';
import 'package:daily_app/features/home/logic/add_habit_log/add_habit_log_cubit.dart';
import 'package:daily_app/features/home/logic/all_habit/all_habit_cubit.dart';
import 'package:daily_app/features/home/logic/delete_habit/delete_habit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class DailyItem extends StatefulWidget {
  DailyItem({
    super.key,
    required this.habitName,
    required this.completed,
    required this.doneCount,
  });
  String habitName;
  bool completed = false;
  int doneCount = 0;

  @override
  State<DailyItem> createState() => _DailyItemState();
}

class _DailyItemState extends State<DailyItem> {
  late bool isCompleted;

  @override
  void initState() {
    super.initState();
    isCompleted = widget.completed;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.only(right: 16, left: 8, top: 6),
          height: 120,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: ColorsManager.primaryColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isCompleted = !isCompleted;
                        if (isCompleted) {
                          widget.doneCount += 1;
                        } else {
                          widget.doneCount -= 1;
                        }
                      });
                      HabitLog newHabitLog = HabitLog(
                        habitName: widget.habitName,
                        date: DateTime.now(),
                        completed: isCompleted,
                      );
                      context.read<AddHabitLogCubit>().addHabitLog(newHabitLog);
                    },
                    icon: Icon(
                      isCompleted
                          ? Icons.check_box
                          : Icons.check_box_outline_blank_outlined,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.all(3),
                        child: Text(
                          widget.habitName,
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.sp,
                            fontFamily: 'Nunito',
                            decoration: isCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            decorationColor: Colors.black,
                            decorationThickness: 2,
                          ),
                        ),
                      ),
                      subtitle: Text(
                        '${widget.doneCount} times',
                        maxLines: 1,
                        style: TextStyle(
                          // ignore: deprecated_member_use
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 16.sp,
                          fontFamily: 'Nunito',
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          context
                              .read<DeleteHabitCubit>()
                              .deleteHabit(widget.habitName);
                          context.read<AllHabitCubit>().getAllHabit();

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Deleted ${widget.habitName} successfully!',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        },
                        icon: Icon(Icons.delete, size: 30, color: Colors.black),
                        color: ColorsManager.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
