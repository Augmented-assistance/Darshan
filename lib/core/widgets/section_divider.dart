import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SectionDivider extends StatelessWidget {
  final double indent;
  final double endIndent;

  const SectionDivider({
    super.key,
    this.indent = 0.0,
    this.endIndent = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Divider(
      height: 1.0,
      thickness: 1.0,
      color: AppColors.borderHairline(isDark),
      indent: indent,
      endIndent: endIndent,
    );
  }
}
