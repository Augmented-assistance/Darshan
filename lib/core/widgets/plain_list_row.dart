import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class PlainListRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final bool showDivider;

  const PlainListRow({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Row(
              children: [
                // Thin stroke icon (20px)
                Icon(
                  icon,
                  size: 20,
                  color: AppColors.textSecondary(isDark),
                ),
                const SizedBox(width: 14),

                // Title & Subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTypography.bodyMedium(
                          AppColors.textPrimary(isDark),
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
                          style: AppTypography.caption(
                            AppColors.textSecondary(isDark),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Right Chevron
                Icon(
                  Icons.chevron_right_rounded,
                  size: 20,
                  color: AppColors.textSecondary(isDark).withValues(alpha: 0.6),
                ),
              ],
            ),
          ),

          // 1px Hairline Divider
          if (showDivider)
            Divider(
              height: 1.0,
              thickness: 1.0,
              color: AppColors.borderHairline(isDark),
              indent: 20.0,
              endIndent: 20.0,
            ),
        ],
      ),
    );
  }
}
