import 'package:flutter/material.dart';

import 'colors.dart';

BoxDecoration cardBoxDecoration({
  double? raduis,
  Color? color,
  List<BoxShadow>? boxShadow,
}) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(raduis ?? 8),
    color: color ?? Colors.grey.shade300,
    boxShadow: boxShadow ?? const [],
  );
}

BoxDecoration cardDecoration(
    {double? raduis,
    Color? color,
    List<BoxShadow>? boxShadow,
    Gradient? gradient}) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(raduis ?? 12),
    boxShadow: boxShadow ?? AppColor.boxShadow,
    color: color ?? AppColor.whiteColor,
    gradient: gradient,
  );
}
