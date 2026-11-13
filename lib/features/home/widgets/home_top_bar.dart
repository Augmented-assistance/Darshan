import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class HomeTopBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onProfileTap;

  const HomeTopBar({
    super.key,
    this.onProfileTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      backgroundColor: AppColors.bgPrimary(isDark),
      elevation: 0.0,
      scrolledUnderElevation: 0.0,
      titleSpacing: 20.0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'KATHMANDU HERITAGE',
            style: AppTypography.overline(AppColors.accent(isDark)),
          ),
          const SizedBox(height: 1),
          Text(
            'Darshan',
            style: AppTypography.h3(AppColors.textPrimary(isDark)),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: IconButton(
            icon: Icon(
              Icons.info_outline_rounded,
              size: 22,
              color: AppColors.textPrimary(isDark),
            ),
            onPressed: onProfileTap ??
                () {
                  showAboutDialog(
                    context: context,
                    applicationName: 'Darshan',
                    applicationVersion: '1.0.0',
                    applicationLegalese: '© UNESCO Kathmandu Valley Heritage Identification',
                  );
                },
            tooltip: 'About Darshan',
          ),
        ),
      ],
    );
  }
}
