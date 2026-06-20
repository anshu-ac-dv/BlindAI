import 'package:blind_ai/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Splash screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that Splash Screen text is present.
    expect(find.text('Blind AI'), findsOneWidget);
    expect(find.text('YOUR INTELLIGENT COMPANION'), findsOneWidget);
  });
}
