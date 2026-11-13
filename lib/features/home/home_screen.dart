import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/section_divider.dart';
import '../monument/models/monument_model.dart';
import '../monument/providers/monument_provider.dart';
import 'widgets/home_top_bar.dart';
import 'widgets/featured_monument_card.dart';
import 'widgets/secondary_actions_list.dart';
import 'widgets/explore_valley_section.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void _navigateToMonumentDetail(BuildContext context, MonumentModel monument) {
    context.push('/chat', extra: {'monument': monument});
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final featuredMonument = ref.watch(featuredMonumentProvider);
    final monuments = ref.watch(monumentRepositoryProvider);

    return Scaffold(
      backgroundColor: AppColors.bgPrimary(isDark),
      appBar: const HomeTopBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              // Featured Photograph (16:9)
              FeaturedMonumentCard(
                monument: featuredMonument,
                onTap: () => _navigateToMonumentDetail(context, featuredMonument),
              ),
              const SizedBox(height: 16),

              // Primary Action: "Identify a Monument" Rectangular Accent Button
              const SectionDivider(indent: 20, endIndent: 20),
              const SizedBox(height: 8),

              // Secondary Actions Hairline-separated List
              const SecondaryActionsList(),
              const SizedBox(height: 24),

              const SectionDivider(indent: 20, endIndent: 20),
              const SizedBox(height: 16),

              // "Explore the Valley" Horizontal Scrollable Section
              ExploreValleySection(
                monuments: monuments,
                onMonumentTap: (monument) => _navigateToMonumentDetail(context, monument),
                onSeeAllTap: () => context.push('/explore'),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
