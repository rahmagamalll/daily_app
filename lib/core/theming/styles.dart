import 'package:daily_app/core/theming/font_weight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class TextStylesManager {
  static TextStyle font8Primary(BuildContext context) => TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontSize: 8.sp,
        fontWeight: FontWeightManager.regular,
        fontFamily: 'Nunito',
      );

  static TextStyle font16WhiteMedium() => TextStyle(
        color: Colors.white,
        fontSize: 16.sp,
        fontWeight: FontWeightManager.medium,
        fontFamily: 'Nunito',
      );

  static TextStyle font18Regular(BuildContext context) => TextStyle(
        color: Theme.of(context).textTheme.bodyLarge?.color,
        fontSize: 18.sp,
        fontWeight: FontWeightManager.regular,
        fontFamily: 'Nunito',
      );

  static TextStyle font12Regular(BuildContext context) => TextStyle(
        color: Theme.of(context).textTheme.bodySmall?.color,
        fontSize: 12.sp,
        fontWeight: FontWeightManager.regular,
        fontFamily: 'Nunito',
      );

  static TextStyle font10Regular(BuildContext context) => TextStyle(
        color: Theme.of(context).textTheme.bodySmall?.color,
        fontSize: 10.sp,
        fontWeight: FontWeightManager.regular,
        fontFamily: 'Nunito',
      );

  static TextStyle font14Medium(BuildContext context) => TextStyle(
        color: Theme.of(context).textTheme.bodyMedium?.color,
        fontSize: 14.sp,
        fontWeight: FontWeightManager.medium,
        fontFamily: 'Nunito',
      );

  static TextStyle font16Regular(BuildContext context) => TextStyle(
        color: Theme.of(context).textTheme.bodyMedium?.color,
        fontSize: 16.sp,
        fontWeight: FontWeightManager.regular,
        fontFamily: 'Nunito',
      );

  static TextStyle font14GreyRegular(BuildContext context) => TextStyle(
        color: Theme.of(context).hintColor,
        fontSize: 14.sp,
        fontWeight: FontWeightManager.regular,
        fontFamily: 'Nunito',
      );

  static TextStyle font16GreyRegular(BuildContext context) => TextStyle(
        color: Theme.of(context).hintColor,
        fontSize: 16.sp,
        fontWeight: FontWeightManager.regular,
        fontFamily: 'Nunito',
      );

  static TextStyle font16Medium(BuildContext context) => TextStyle(
        color: Theme.of(context).textTheme.bodyMedium?.color,
        fontSize: 16.sp,
        fontWeight: FontWeightManager.medium,
        fontFamily: 'Nunito',
      );

  static TextStyle font18Bold(BuildContext context) => TextStyle(
        color: Theme.of(context).textTheme.bodyLarge?.color,
        fontSize: 18.sp,
        fontWeight: FontWeightManager.bold,
        fontFamily: 'Nunito',
      );

  static TextStyle font16GreyMedium(BuildContext context) => TextStyle(
        color: Theme.of(context).hintColor,
        fontSize: 16.sp,
        fontWeight: FontWeightManager.medium,
        fontFamily: 'Nunito',
      );

  static TextStyle font18PrimaryBold(BuildContext context) => TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontSize: 18.sp,
        fontWeight: FontWeightManager.bold,
        fontFamily: 'Nunito',
      );

  static TextStyle font14GreyMedium(BuildContext context) => TextStyle(
        color: Theme.of(context).hintColor,
        fontSize: 14.sp,
        fontWeight: FontWeightManager.regular,
        fontFamily: 'Nunito',
      );
}
