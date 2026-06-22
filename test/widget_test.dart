import 'package:blind_ai/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MainApp());

    // Verify that "Empty Project" text is present.
    expect(find.text('Empty Project'), findsOneWidget);
  });
}
