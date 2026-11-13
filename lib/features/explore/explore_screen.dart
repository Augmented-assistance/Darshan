import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_strings.dart';
import '../../core/providers/language_provider.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/monument_list_tile.dart';
import '../monument/models/monument_model.dart';
import '../monument/providers/monument_provider.dart';

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final allMonuments = ref.watch(ragKnowledgeBaseProvider);
    final language = ref.watch(languageProvider);
    String text(String key) => AppStrings.get(language, key);

    final filteredMonuments = allMonuments.where((m) {
      final q = _searchQuery.toLowerCase();
      return m.name.toLowerCase().contains(q) ||
          m.zone.toLowerCase().contains(q) ||
          m.description.toLowerCase().contains(q) ||
          m.architecturalStyle.toLowerCase().contains(q);
    }).toList();

    // Group monuments by Zone
    final Map<String, List<MonumentModel>> groupedMonuments = {};
    for (var m in filteredMonuments) {
      groupedMonuments.putIfAbsent(m.zone, () => []).add(m);
    }

    return Scaffold(
      backgroundColor: AppColors.bgPrimary(isDark),
      appBar: AppBar(
        backgroundColor: AppColors.bgPrimary(isDark),
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/chat');
            }
          },
        ),
        title: Text(
          text('heritage'),
          style: AppTypography.h3(AppColors.textPrimary(isDark)),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar at Top
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: AppTextField(
                controller: _searchController,
                hintText: text('search'),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  size: 20,
                  color: AppColors.textSecondary(isDark),
                ),
                onChanged: (val) {
                  setState(() {
                    _searchQuery = val;
                  });
                },
              ),
            ),

            // Grouped List by Zone
            Expanded(
              child: filteredMonuments.isEmpty
                  ? Center(
                      child: Text(
                        '${text('noResults')}${_searchQuery.isEmpty ? '' : ': "$_searchQuery"'}',
                        style: AppTypography.body(AppColors.textSecondary(isDark)),
                      ),
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: groupedMonuments.keys.length,
                      itemBuilder: (context, index) {
                        final zoneName = groupedMonuments.keys.elementAt(index);
                        final zoneMonuments = groupedMonuments[zoneName]!;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Small-caps section header
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                                top: 20.0,
                                bottom: 8.0,
                              ),
                              child: Text(
                                zoneName.toUpperCase(),
                                style: AppTypography.overline(
                                  AppColors.accent(isDark),
                                ),
                              ),
                            ),

                            // Monument Rows
                            ...zoneMonuments.map((monument) {
                              return MonumentListTile(
                                imageUrl: monument.imageUrl,
                                title: monument.name,
                                zone: monument.architecturalStyle,
                                description: monument.description,
                                distanceText: '${monument.distanceKm} km',
                                onTap: () {
                                  context.push('/chat', extra: {'monument': monument});
                                },
                              );
                            }),
                          ],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
