import 'package:daily_app/core/helper/spacing.dart';
import 'package:daily_app/core/theming/colors.dart';
import 'package:daily_app/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCheckButton extends StatelessWidget {
  final bool isChecked;
  final VoidCallback onTap;
  final String label;

  const CustomCheckButton({
    super.key,
    required this.isChecked,
    required this.onTap,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            height: 16.h,
            width: 18.w,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(3)),
              color:
                  isChecked ? ColorsManager.primaryColor : Colors.transparent,
              border: Border.all(
                  color: isChecked
                      ? ColorsManager.primaryColor
                      : ColorsManager.mediumGrey),
            ),
            child: isChecked
                ? const Icon(Icons.check, size: 15, color: ColorsManager.white)
                : null,
          ),
        ),
        horizontalSpacing(8),
        Text(label, style: TextStylesManager.font14MediumGrayRegular),
      ],
    );
  }
}
