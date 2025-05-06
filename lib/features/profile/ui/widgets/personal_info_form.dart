import 'package:daily_app/core/helper/spacing.dart';
import 'package:daily_app/core/theming/styles.dart';
import 'package:daily_app/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalInfoForm extends StatelessWidget {
  final void Function(String)? onChangedFirstName;
  final void Function(String)? onChangedLastName;

  const PersonalInfoForm({
    super.key,
    this.onChangedFirstName,
    this.onChangedLastName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Personal Info',
          style: TextStylesManager.font18Regular(context).copyWith(
            color: theme.textTheme.bodyLarge?.color,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        verticalSpacing(18),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'First name',
                    style: TextStylesManager.font16Regular(context),
                  ),
                  verticalSpacing(10),
                  Container(
                    decoration: BoxDecoration(
                      color:
                          isDark ? Colors.grey[800] : const Color(0xffF3F3F3),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: CustomTextFormField(
                      onChanged: onChangedFirstName,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                      hintText: "first name",
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 13.h,
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                      hintStyle: TextStylesManager.font16Medium(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        verticalSpacing(15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Last name', style: TextStylesManager.font16Regular(context)),
            verticalSpacing(10),
            Container(
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[800] : const Color(0xffF3F3F3),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: CustomTextFormField(
                onChanged: onChangedLastName,
                hintText: "last name",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 13.h,
                ),
                borderRadius: BorderRadius.circular(8.r),
                hintStyle: TextStylesManager.font16Medium(context),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
