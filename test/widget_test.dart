import 'package:flutter_test/flutter_test.dart';
import 'package:blind_ai/main.dart';

void main() {
  testWidgets('Blind AI smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that splash screen shows the app name.
    expect(find.text('BLINDAI'), findsOneWidget);
    
    // We can't easily test the full flow due to Firebase and BLoC async initialization,
    // but we've verified the initial state.
  });
}
