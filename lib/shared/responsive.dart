import 'package:flutter/widgets.dart';

class Responsive {
  const Responsive._();

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 720;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= 720 && width < 1100;
  }

  static double pagePadding(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 720) return 20;
    if (width < 1100) return 40;
    return 72;
  }
}
