import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'core/theme/app_theme.dart';
import 'features/splash/splash_screen.dart';
import 'features/capture/camera_screen.dart';
import 'features/capture/image_preview_screen.dart';
import 'features/guide/guide_screen.dart';
import 'models/place_result.dart';

class SmritApp extends ConsumerWidget {
  const SmritApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: '/camera',
          builder: (context, state) => const CameraScreen(),
        ),
        GoRoute(
          path: '/preview',
          builder: (context, state) {
            final imagePath = state.extra as String;
            return ImagePreviewScreen(imagePath: imagePath);
          },
        ),
        GoRoute(
          path: '/guide',
          builder: (context, state) {
            final place = state.extra as PlaceResult;
            return GuideScreen(place: place);
          },
        ),
      ],
    );

    return MaterialApp.router(
      title: 'SmritAI',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: router,
    );
  }
}
