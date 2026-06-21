import 'package:blind_ai/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const BlindAIApp());

    // Verify that Splash Screen (Eye icon) is present.
    expect(find.byIcon(Icons.remove_red_eye_rounded), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
