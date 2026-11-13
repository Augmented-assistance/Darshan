import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smritai/app.dart';

void main() {
  testWidgets('Darshan App initialization test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: DarshanApp(),
      ),
    );
    expect(find.byType(DarshanApp), findsOneWidget);
  });
}
