import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import '../../core/providers/language_provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_strings.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/monument_list_tile.dart';
import '../monument/providers/monument_provider.dart';

class RecommendationsScreen extends ConsumerStatefulWidget {
  const RecommendationsScreen({super.key});
  @override
  ConsumerState<RecommendationsScreen> createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends ConsumerState<RecommendationsScreen> {
  Position? _position;
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    _loadLocation();
  }

  Future<void> _loadLocation() async {
    if (!await Geolocator.isLocationServiceEnabled()) return;
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) return;
    try {
      final position = await Geolocator.getCurrentPosition();
      if (mounted) setState(() => _position = position);
    } on Exception {
      // The Kathmandu fallback remains available when location lookup fails.
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final language = ref.watch(languageProvider);
    String text(String key) => AppStrings.get(language, key);
    final center = _position == null
        ? const LatLng(27.7172, 85.3240)
        : LatLng(_position!.latitude, _position!.longitude);
    final monuments = ref.watch(monumentRepositoryProvider);
    final distance = const Distance();
    final recommendations = monuments.map((monument) {
      final distanceKm = distance.as(
        LengthUnit.Kilometer,
        center,
        LatLng(monument.latitude, monument.longitude),
      );
      return (monument: monument, distanceKm: distanceKm);
    }).toList()
      ..sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
    final filtered = _selectedFilter == 'Near Me'
        ? recommendations.where((item) => item.distanceKm <= 5).toList()
        : recommendations;

    return Scaffold(
      backgroundColor: AppColors.bgPrimary(isDark),
      appBar: AppBar(
        title: Text(text('nearbyTitle'), style: AppTypography.h3(AppColors.textPrimary(isDark))),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.go('/chat')),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 220,
            child: FlutterMap(
              options: MapOptions(initialCenter: center, initialZoom: 12.5),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.smritai',
                ),
                MarkerLayer(markers: [
                  Marker(
                    point: center,
                    width: 44,
                    height: 44,
                    child: const Icon(Icons.my_location, color: Colors.blue, size: 30),
                  ),
                  ...monuments.map((m) => Marker(
                    point: LatLng(m.latitude, m.longitude),
                    width: 32,
                    height: 32,
                    child: const Icon(Icons.location_on, color: Color(0xFF8C2F1D), size: 28),
                  )),
                ]),
              ],
            ),
          ),
          SizedBox(
            height: 52,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              children: [
                for (final filter in ['All', 'Near Me'])
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(filter == 'All' ? text('all') : text('nearMe')),
                      selected: _selectedFilter == filter,
                      onSelected: (_) => setState(() => _selectedFilter = filter),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final recommendation = filtered[index];
                final monument = recommendation.monument;
                return MonumentListTile(
                  imageUrl: monument.imageUrl,
                  title: monument.name,
                  zone: monument.zone,
                  description: monument.description,
                  distanceText: '${recommendation.distanceKm.toStringAsFixed(1)} km',
                  onTap: () => context.push('/chat', extra: {'monument': monument}),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
