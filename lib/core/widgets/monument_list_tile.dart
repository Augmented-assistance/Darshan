import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_typography.dart';

class MonumentListTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String zone;
  final String description;
  final String? distanceText;
  final VoidCallback onTap;
  final bool showDivider;

  const MonumentListTile({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.zone,
    required this.description,
    this.distanceText,
    required this.onTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.card),
      onTap: onTap,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surface(isDark),
              borderRadius: BorderRadius.circular(AppRadius.card),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Rectangular Thumbnail Photo (4:3 ratio)
                SizedBox(
                  width: 96,
                  height: 72,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.smallImage),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppColors.bgSecondary(isDark),
                          child: Icon(
                            Icons.account_balance_outlined,
                            size: 24,
                            color: AppColors.textSecondary(isDark),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 14),

                // Monument Metadata
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            zone.toUpperCase(),
                            style: AppTypography.overline(AppColors.accent(isDark)),
                          ),
                          if (distanceText != null)
                            Text(
                              distanceText!,
                              style: AppTypography.caption(
                                AppColors.textSecondary(isDark),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        title,
                        style: AppTypography.h4(
                          AppColors.textPrimary(isDark),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: AppTypography.caption(
                          AppColors.textSecondary(isDark),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
