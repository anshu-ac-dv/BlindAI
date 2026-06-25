import 'package:flutter_test/flutter_test.dart';
import 'package:blind_ai/main.dart';

void main() {
  testWidgets('Blind AI home screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our home screen shows the welcome message.
    expect(find.text('Welcome to Blind AI'), findsOneWidget);
    expect(find.text('Blind AI'), findsAtLeastNWidgets(1));
  });
}
