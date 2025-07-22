import 'package:flutter_test/flutter_test.dart';
import 'package:queerie_test/core/widgets/circle_image.dart';
import '../../helpers/root_widget.dart';

void main() {
  testWidgets('CircleImage renders with placeholder', (WidgetTester tester) async {
    await tester.pumpWidget(rootWidget(const CircleImage(url: '')));
    expect(find.byType(CircleImage), findsOneWidget);
  });
} 