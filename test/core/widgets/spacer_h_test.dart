import 'package:flutter_test/flutter_test.dart';
import 'package:queerie_test/core/widgets/spacer_h.dart';
import '../../helpers/root_widget.dart';

void main() {
  testWidgets('SpacerH renders with default width', (WidgetTester tester) async {
    await tester.pumpWidget(rootWidget(const SpacerH()));
    expect(find.byType(SpacerH), findsOneWidget);
  });
} 