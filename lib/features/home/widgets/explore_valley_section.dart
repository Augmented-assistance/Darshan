import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/editorial_heading.dart';
import '../../monument/models/monument_model.dart';

class ExploreValleySection extends StatelessWidget {
  final List<MonumentModel> monuments;
  final Function(MonumentModel monument) onMonumentTap;
  final VoidCallback onSeeAllTap;

  const ExploreValleySection({
    super.key,
    required this.monuments,
    required this.onMonumentTap,
    required this.onSeeAllTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Editorial Section Heading
        EditorialHeading(
          sectionTag: 'EXPLORE THE VALLEY',
          title: 'UNESCO Heritage Sites',
          actionLabel: 'See All (12)',
          onActionTap: onSeeAllTap,
        ),
        const SizedBox(height: 12),

        // Horizontally Scrollable Row
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            itemCount: monuments.length,
            itemBuilder: (context, index) {
              final monument = monuments[index];

              return Container(
                width: 200,
                margin: const EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                  onTap: () => onMonumentTap(monument),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 4:3 Rectangular Photo Frame
                      AspectRatio(
                        aspectRatio: 4 / 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(AppRadius.largePhoto),
                          child: Image.network(
                            monument.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: AppColors.bgSecondary(isDark),
                                child: Icon(
                                  Icons.account_balance_outlined,
                                  size: 32,
                                  color: AppColors.textSecondary(isDark),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Zone Tag (Small-caps beneath)
                      Text(
                        monument.zone.toUpperCase(),
                        style: AppTypography.overline(AppColors.accent(isDark)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),

                      // Monument Name in Serif Headline
                      Text(
                        monument.name,
                        style: AppTypography.h4(
                          AppColors.textPrimary(isDark),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
