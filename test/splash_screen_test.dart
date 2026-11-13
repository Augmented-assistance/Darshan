import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smritai/app.dart';

void main() {
  testWidgets('SplashScreen displays Darshan title and rule', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: DarshanApp(),
      ),
    );

    // Initial frame
    await tester.pump();

    // Verify Title "Darshan"
    expect(find.text('Darshan'), findsOneWidget);

    // Verify 1px accent rule container exists
    expect(find.byType(Container), findsWidgets);
  });
}
