import 'package:flutter_test/flutter_test.dart';
import 'package:queerie_test/core/widgets/button.dart';
import '../../helpers/root_widget.dart';

void main() {
  testWidgets('Button renders and responds to tap', (WidgetTester tester) async {
    bool tapped = false;
    await tester.pumpWidget(rootWidget(Button(
      title: 'Test Button',
      onPressed: () => tapped = true,
    )));
    expect(find.text('TEST BUTTON'), findsOneWidget);
    await tester.tap(find.text('TEST BUTTON'));
    expect(tapped, isTrue);
  });
} 