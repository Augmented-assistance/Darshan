import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class EditorialHeading extends StatelessWidget {
  final String title;
  final String? sectionTag;
  final VoidCallback? onActionTap;
  final String? actionLabel;

  const EditorialHeading({
    super.key,
    required this.title,
    this.sectionTag,
    this.onActionTap,
    this.actionLabel,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (sectionTag != null) ...[
            Text(
              sectionTag!.toUpperCase(),
              style: AppTypography.overline(AppColors.accent(isDark)),
            ),
            const SizedBox(height: 4),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                title,
                style: AppTypography.h2(AppColors.textPrimary(isDark)),
              ),
              if (onActionTap != null && actionLabel != null)
                GestureDetector(
                  onTap: onActionTap,
                  child: Text(
                    actionLabel!,
                    style: AppTypography.caption(AppColors.accent(isDark)).copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
