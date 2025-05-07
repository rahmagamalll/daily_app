import 'package:daily_app/constants.dart';
import 'package:daily_app/core/helper/hive_fun_helper.dart';
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
  Hive.registerAdapter<Habit>(HabitAdapter());
  await Hive.openBox<Habit>(Constants.hiveHabitNameBox);
  Hive.registerAdapter<HabitLog>(HabitLogAdapter());
  await Hive.openBox<HabitLog>(Constants.hiveHabitLogBox);


  bool isLogin = await SharePrefHelper.getBool(SharedPrefKeys.login);
  bool isdark = await SharePrefHelper.getBool(SharedPrefKeys.isdark);

  await ScreenUtil.ensureScreenSize();

  await HiveFunctionsHelper.storeHabitsAtStartOfDay();

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

