import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/chat/chat_screen.dart';
import '../features/explore/explore_screen.dart';
import '../features/recommendations/recommendations_screen.dart';
import '../features/splash/splash_screen.dart';
import '../features/monument/models/monument_model.dart';
import 'shell.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) => '/chat',
      ),
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          final hiddenRoute = {
            '/capture/analyzing',
            '/capture/result',
            '/capture/low-confidence',
          }.contains(state.uri.path);
          return AppShell(
            navigationShell: navigationShell,
            routeAllowsNavBar: !hiddenRoute,
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/chat',
                builder: (context, state) {
                  final extra = state.extra as Map<String, dynamic>?;
                  return ChatScreen(
                    initialMonument: extra?['monument'] as MonumentModel?,
                    initialPrompt: extra?['prompt'] as String?,
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/explore',
                builder: (context, state) => const ExploreScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/nearby',
                builder: (context, state) => const RecommendationsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
