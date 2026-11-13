import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_typography.dart';

class PinnedContextBar extends StatelessWidget {
  final String monumentName;
  final String zone;
  final String? imageUrl;
  final VoidCallback onChangeTap;

  const PinnedContextBar({
    super.key,
    required this.monumentName,
    required this.zone,
    this.imageUrl,
    required this.onChangeTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: AppColors.bgSecondary(isDark),
        border: Border(
          bottom: BorderSide(
            color: AppColors.borderHairline(isDark),
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        children: [
          // Small 1:1 rectangular thumbnail
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.chip),
              color: AppColors.bgPrimary(isDark),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.chip),
              child: imageUrl != null
                  ? Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.account_balance_outlined,
                        size: 18,
                        color: AppColors.textSecondary(isDark),
                      ),
                    )
                  : Icon(
                      Icons.account_balance_outlined,
                      size: 18,
                      color: AppColors.textSecondary(isDark),
                    ),
            ),
          ),
          const SizedBox(width: 12),

          // Monument Name & Zone
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  monumentName,
                  style: AppTypography.bodyMedium(AppColors.textPrimary(isDark)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // "Change" text link
          GestureDetector(
            onTap: onChangeTap,
            child: Text(
              'Change',
              style: AppTypography.caption(AppColors.accent(isDark)).copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
