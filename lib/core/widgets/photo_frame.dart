import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_typography.dart';

class PhotoFrame extends StatelessWidget {
  final String imageUrl;
  final double aspectRatio;
  final String? title;
  final String? subtitle;
  final double borderRadius;
  final VoidCallback? onTap;

  const PhotoFrame({
    super.key,
    required this.imageUrl,
    this.aspectRatio = 16 / 9,
    this.title,
    this.subtitle,
    this.borderRadius = AppRadius.largePhoto,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Widget imageWidget = AspectRatio(
      aspectRatio: aspectRatio,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Photo Container
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: AppColors.bgSecondary(isDark),
                  child: Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 1.5,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.accent(isDark),
                        ),
                      ),
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppColors.bgSecondary(isDark),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.account_balance_outlined,
                        size: 32,
                        color: AppColors.textSecondary(isDark),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Monument Photography',
                        style: AppTypography.caption(AppColors.textSecondary(isDark)),
                      ),
                    ],
                  ),
                );
              },
            ),

            // Black-to-transparent scrim only if title is provided
            if (title != null)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Color(0xCC000000),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (subtitle != null) ...[
                        Text(
                          subtitle!.toUpperCase(),
                          style: AppTypography.overline(Colors.white.withValues(alpha: 0.85)),
                        ),
                        const SizedBox(height: 4),
                      ],
                      Text(
                        title!,
                        style: AppTypography.h3(Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: imageWidget,
      );
    }

    return imageWidget;
  }
}
