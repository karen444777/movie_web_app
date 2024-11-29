import 'package:flutter/cupertino.dart';

class Responsive{
  const Responsive();

  bool isMobile(context) => MediaQuery.of(context).size.width < 850;

  bool isTablet(context) => MediaQuery.of(context).size.width >= 850 && MediaQuery.of(context).size.width < 1100;

  bool isDesktop(context) => MediaQuery.of(context).size.width >= 1100;

  bool isLargeDesktop(context) => MediaQuery.of(context).size.width >= 1440;

  bool isExtraLargeDesktop(context) => MediaQuery.of(context).size.width >= 4000;
}