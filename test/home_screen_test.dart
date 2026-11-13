import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smritai/app.dart';

void main() {
  testWidgets('DarshanApp opens the chat shell', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: DarshanApp(),
      ),
    );

    // Settle splash timer
    await tester.pumpAndSettle(const Duration(milliseconds: 2000));

    // Verify Title & Wordmark
    expect(find.text('Darshan'), findsOneWidget);
    expect(find.text('How can I help today?'), findsOneWidget);
    expect(find.text('Explore'), findsOneWidget);
    expect(find.text('Nearby'), findsOneWidget);
  });
}
