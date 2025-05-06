import 'package:daily_app/constants.dart';
import 'package:daily_app/core/helper/share_pref_helper.dart';
import 'package:daily_app/core/helper/shared_pref_keys.dart';
import 'package:daily_app/daily_app.dart';
import 'package:daily_app/features/home/data/models/habit_log.dart';
import 'package:daily_app/features/home/data/models/habit_model.dart';
import 'package:daily_app/features/statistics/data/models/weekly_statistics.dart';
import 'package:daily_app/features/home/logic/add_habit/add_habit_cubit.dart';
import 'package:daily_app/features/home/logic/add_habit_log/add_habit_log_cubit.dart';
import 'package:daily_app/features/home/logic/all_habit/all_habit_cubit.dart';
import 'package:daily_app/features/home/logic/cubit/manage_top_app_bar_cubit.dart';
import 'package:daily_app/features/home/logic/delete_habit/delete_habit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<WeeklyStatistics>(WeeklyStatisticsAdapter());
  await Hive.openBox<WeeklyStatistics>(Constants.hiveWeeklyStatisticsBox);

  // تسجيل المحولات (Adapters) للأنواع المستخدمة في Hive
  Hive.registerAdapter<Habit>(HabitAdapter());
  await Hive.openBox<Habit>(Constants.hiveHabitNameBox);
  Hive.registerAdapter<HabitLog>(HabitLogAdapter());
  await Hive.openBox<HabitLog>(Constants.hiveHabitLogBox);

  // التحقق مما إذا كان المستخدم قد سجل الدخول
  bool isLogin = await SharePrefHelper.getBool(SharedPrefKeys.login);
  bool isdark = await SharePrefHelper.getBool(SharedPrefKeys.isdark);
  // التأكد من تهيئة ScreenUtil
  await ScreenUtil.ensureScreenSize();

  // تخزين العادات في بداية اليوم
  await storeHabitsAtStartOfDay();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ManageTopAppBarCubit(),
        ),
        BlocProvider(
          create: (context) => AllHabitCubit()..getAllHabit(),
        ),
        BlocProvider(
          create: (context) => AddHabitCubit(),
        ),
        BlocProvider(
          create: (context) => DeleteHabitCubit(),
        ),
        BlocProvider(
          create: (context) => AddHabitLogCubit(),
        ),
      ],
      child: DailyApp(
        isdark: isdark,
        isLogin: isLogin,
      ),
    ),
  );
}

Future<void> storeHabitsAtStartOfDay() async {
  try {
    print('Starting to store habits at the start of the day...');

    var habitNamesBox = await Hive.openBox<Habit>(Constants.hiveHabitNameBox);
    var habitLogBox = await Hive.openBox<HabitLog>(Constants.hiveHabitLogBox);

    final today = DateTime.now();

    for (var habit in habitNamesBox.values) {
      final exists = habitLogBox.values.any(
        (log) =>
            log.habitName == habit.name &&
            log.date.year == today.year &&
            log.date.month == today.month &&
            log.date.day == today.day,
      );

      if (!exists) {
        habitLogBox.add(HabitLog(
          habitName: habit.name,
          date: today,
          completed: false,
        ));
        print('Initialized log for habit: ${habit.name}');
      } else {
        print('Log already exists for habit: ${habit.name}');
      }
    }
  } catch (e) {
    print('Error while storing habit logs: $e');
  }
}
