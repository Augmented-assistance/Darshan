import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/plain_list_row.dart';

class SecondaryActionsList extends StatelessWidget {
  const SecondaryActionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PlainListRow(
          icon: Icons.chat_bubble_outline_rounded,
          title: 'Ask Darshan',
          subtitle: 'Ask about heritage, culture & ancient history',
          onTap: () => context.push('/chat'),
        ),
        PlainListRow(
          icon: Icons.place_outlined,
          title: 'Nearby & Recommendations',
          subtitle: 'Monuments & cultural sites near your location',
          onTap: () => context.push('/nearby'),
        ),
        PlainListRow(
          icon: Icons.account_balance_outlined,
          title: 'All Monuments',
          subtitle: 'Browse 12 UNESCO heritage sites in Kathmandu Valley',
          onTap: () => context.push('/explore'),
        ),
        PlainListRow(
          icon: Icons.bookmark_border_rounded,
          title: 'Your Visits',
          subtitle: 'Saved monuments and historical notes',
          showDivider: false,
          onTap: () => context.push('/explore'),
        ),
      ],
    );
  }
}
