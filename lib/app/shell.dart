import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'nav_bar_visibility.dart';
import '../core/widgets/app_bottom_nav_bar.dart';

class AppShell extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;
  final bool routeAllowsNavBar;

  const AppShell({
    required this.navigationShell,
    required this.routeAllowsNavBar,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final keyboardIsOpen = MediaQuery.viewInsetsOf(context).bottom > 0;
    final navBarVisible = ref.watch(navBarVisibleProvider);

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: routeAllowsNavBar && navBarVisible && !keyboardIsOpen
          ? AppBottomNavBar(navigationShell: navigationShell)
          : null,
    );
  }
}
