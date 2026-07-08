import 'package:flutter/material.dart';
import '../../../models/place_result.dart';

class InfoPanel extends StatelessWidget {
  final PlaceResult place;
  const InfoPanel({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            place.name,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            place.description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Divider(height: 32),
        ],
      ),
    );
  }
}
