import 'package:daily_app/core/routing/routes.dart';
import 'package:daily_app/features/home/ui/home_screen.dart';
import 'package:daily_app/features/profile/ui/screens/login_screen.dart';
import 'package:daily_app/features/profile/ui/screens/profile_screen.dart';
import 'package:daily_app/features/statistics/ui/statistics_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homeScreen:
        return _createPageTransition(
          child:  HomeScreen(
            toggleTheme: (settings.arguments as Function(bool)),
          ),
          transitionType: PageTransitionType.fade,
        );
      case Routes.loginScreen:
        return _createPageTransition(
          child:  LoginScreen(),
          transitionType: PageTransitionType.slide,
        );
      case Routes.profileScreen:
        return _createPageTransition(
          child:  ProfileScreen(),
          transitionType: PageTransitionType.scale,
        );
      case Routes.statScreen:
        return _createPageTransition(
          child: const StatisticsScreen(),
          transitionType: PageTransitionType.scale,
        );

      default:
        return null;
    }
  }

  static PageRouteBuilder _createPageTransition({
    required Widget child,
    PageTransitionType transitionType = PageTransitionType.slide,
  }) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeInOut;

        if (transitionType == PageTransitionType.slide) {
          final slideTween =
              Tween(begin: const Offset(1.0, 0.0), end: Offset.zero).chain(
            CurveTween(curve: curve),
          );
          final slideAnimation = animation.drive(slideTween);
          return SlideTransition(position: slideAnimation, child: child);
        }

        if (transitionType == PageTransitionType.fade) {
          return FadeTransition(opacity: animation, child: child);
        }

        if (transitionType == PageTransitionType.scale) {
          return ScaleTransition(scale: animation, child: child);
        }

        return child;
      },
    );
  }
}

/// Transition Types for Reusability
enum PageTransitionType {
  slide,
  fade,
  scale,
}
