import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smritai/features/chat/chat_screen.dart';

void main() {
  testWidgets('ChatScreen renders the localized empty state', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: ChatScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Hello, visitor'), findsOneWidget);
    expect(find.text('How can I help today?'), findsOneWidget);
    expect(find.text('Who built it?'), findsOneWidget);
  });
}
