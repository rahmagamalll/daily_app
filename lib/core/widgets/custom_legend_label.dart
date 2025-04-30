import 'package:daily_app/core/helper/spacing.dart';
import 'package:daily_app/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLegendLabel extends StatelessWidget {
  const CustomLegendLabel(
      {super.key,
      required this.degree,
      required this.backgroundColor,
      required this.typedegree});
  final double degree;
  final Color backgroundColor;
  final String typedegree;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: backgroundColor,
          maxRadius: 4,
        ),
        horizontalSpacing(5),
        Text(
          '$degree% $typedegree',
          style: TextStylesManager.font16BlackMedium.copyWith(fontSize: 12.sp),
        ),
      ],
    );
  }
}
