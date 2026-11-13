import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../theme/app_strings.dart';
import '../providers/language_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBottomNavBar extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const AppBottomNavBar({required this.navigationShell, super.key});

  static const _items = [
    (
      branch: 0,
      route: '/chat',
      label: 'Chat',
      icon: Icons.chat_bubble_outline,
      tooltip: 'Chat',
    ),
    (
      branch: 1,
      route: '/explore',
      label: 'Explore',
      icon: Icons.explore_outlined,
      tooltip: 'Explore',
    ),
    (
      branch: 2,
      route: '/nearby',
      label: 'Nearby',
      icon: Icons.place_outlined,
      tooltip: 'Nearby',
    ),
  ];

  void _selectTab(
    BuildContext context,
    ({int branch, String route, String label, IconData icon, String tooltip})
    item,
  ) {
    if (navigationShell.currentIndex == item.branch) {
      navigationShell.goBranch(item.branch, initialLocation: true);
    } else {
      context.go(item.route);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final inactiveColor = AppColors.textSecondary(isDark);
    final activeColor = AppColors.accent(isDark);
    final language = ref.watch(languageProvider);
    final labels = ['chat', 'explore', 'nearby'];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface(isDark),
        border: Border(
          top: BorderSide(color: AppColors.borderHairline(isDark)),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 56,
          child: Row(
            children: [
              for (var index = 0; index < _items.length; index++)
                Expanded(
                  child: Semantics(
                    button: true,
                    label: AppStrings.get(language, labels[index]),
                    selected:
                        navigationShell.currentIndex == _items[index].branch,
                    child: Tooltip(
                      message: AppStrings.get(language, labels[index]),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onTap: () => _selectTab(context, _items[index]),
                        child: _NavItem(
                          item: _items[index],
                          label: AppStrings.get(language, labels[index]),
                          isActive:
                              navigationShell.currentIndex ==
                              _items[index].branch,
                          activeColor: activeColor,
                          inactiveColor: inactiveColor,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final ({
    int branch,
    String route,
    String label,
    IconData icon,
    String tooltip,
  })
  item;
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;
  final String label;

  const _NavItem({
    required this.item,
    required this.isActive,
    required this.activeColor,
    required this.inactiveColor,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? activeColor : inactiveColor;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 8,
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              curve: Curves.easeInOut,
              width: isActive ? 24 : 0,
              height: 1.5,
              color: activeColor,
            ),
          ),
        ),
        const SizedBox(height: 2),
        Icon(item.icon, size: 22, color: color),
        const SizedBox(height: 2),
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeInOut,
          style: AppTypography.caption(
            color,
          ).copyWith(fontWeight: FontWeight.w500),
          child: Text(label),
        ),
      ],
    );
  }
}
