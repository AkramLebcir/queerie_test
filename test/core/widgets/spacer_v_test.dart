import 'package:flutter_test/flutter_test.dart';
import 'package:queerie_test/core/widgets/spacer_v.dart';
import '../../helpers/root_widget.dart';

void main() {
  testWidgets('SpacerV renders with default height', (WidgetTester tester) async {
    await tester.pumpWidget(rootWidget(const SpacerV()));
    expect(find.byType(SpacerV), findsOneWidget);
  });
} 