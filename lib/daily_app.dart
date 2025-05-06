import 'package:daily_app/core/helper/share_pref_helper.dart';
import 'package:daily_app/core/helper/shared_pref_keys.dart';
import 'package:daily_app/features/home/ui/home_screen.dart';
import 'package:daily_app/features/profile/ui/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DailyApp extends StatefulWidget {
  final bool isdark;
  final bool isLogin;

  const DailyApp({super.key, required this.isdark, required this.isLogin});

  @override
  State<DailyApp> createState() => _DailyAppState();
}

class _DailyAppState extends State<DailyApp> {
  late bool isDark;

  @override
  void initState() {
    super.initState();
    isDark = widget.isdark;
  }

  void toggleTheme(bool value) {
    setState(() {
      isDark = value;
    });
    SharePrefHelper.setData(SharedPrefKeys.isdark, value);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
          ),
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
          home: widget.isLogin
              ? HomeScreen(toggleTheme: toggleTheme)
              : LoginScreen(),
        );
      },
    );
  }
}
