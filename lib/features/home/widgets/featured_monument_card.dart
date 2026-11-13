import 'package:flutter/material.dart';
import '../../../core/widgets/photo_frame.dart';
import '../../monument/models/monument_model.dart';

class FeaturedMonumentCard extends StatelessWidget {
  final MonumentModel monument;
  final VoidCallback onTap;

  const FeaturedMonumentCard({
    super.key,
    required this.monument,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: PhotoFrame(
        imageUrl: monument.imageUrl,
        aspectRatio: 16 / 9,
        title: monument.name,
        subtitle: monument.zone,
        onTap: onTap,
      ),
    );
  }
}
