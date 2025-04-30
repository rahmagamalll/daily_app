
import 'package:daily_app/core/routing/app_router.dart';
import 'package:daily_app/core/routing/routes.dart';
import 'package:daily_app/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DailyApp extends StatelessWidget {
  const DailyApp({super.key, required this.isLogin});
  final bool isLogin;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: ColorsManager.white,
            appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromARGB(255, 170, 47, 47),
            ),
            textSelectionTheme: TextSelectionThemeData(
              selectionHandleColor: ColorsManager.primaryColor,
            ),
          ),
          onGenerateRoute: AppRouter.generateRoute,
          initialRoute:
              isLogin == true ? Routes.homeScreen : Routes.loginScreen,
        ));
  }
}
