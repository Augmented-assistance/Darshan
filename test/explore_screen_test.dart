import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smritai/features/explore/explore_screen.dart';

void main() {
  testWidgets('ExploreScreen renders catalogue and zones', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: ExploreScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Heritage Catalogue'), findsOneWidget);
    expect(find.text('Search monuments, zones, or architecture...'), findsOneWidget);
    expect(find.text('Boudhanath Stupa'), findsOneWidget);
  });
}
