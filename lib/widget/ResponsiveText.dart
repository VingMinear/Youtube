import 'package:flutter/material.dart';
import 'package:m_health_app/utils/style.dart';

/// can be used only with row
class ResponsiveText extends StatelessWidget {
  const ResponsiveText({
    super.key,
    required this.text,
    this.style,
    this.maxLines,
    this.overflow,
  });
  final String text;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        text,
        style: style ?? AppText.normalText(),
        maxLines: maxLines ?? 2,
        overflow: overflow ?? TextOverflow.ellipsis,
      ),
    );
  }
}
