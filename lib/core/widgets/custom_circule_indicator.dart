import 'package:daily_app/core/theming/colors.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomCirculeIndicator extends StatelessWidget {
  const CustomCirculeIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(
      color: ColorsManager.primaryColor,
      size: 35,
    );
  }
}
