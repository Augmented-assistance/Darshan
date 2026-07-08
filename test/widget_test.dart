import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smritai/app.dart';

void main() {
  testWidgets('Splash screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: SmritApp(),
      ),
    );

    // Verify that the splash screen shows 'SmritAI'.
    expect(find.text('SmritAI'), findsOneWidget);
  });
}
