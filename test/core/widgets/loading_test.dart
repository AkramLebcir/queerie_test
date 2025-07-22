import 'package:flutter_test/flutter_test.dart';
import 'package:queerie_test/core/widgets/loading.dart';
import '../../helpers/root_widget.dart';

void main() {
  group('Loading Widget', () {
    testWidgets('shows please wait message when showMessage is true', (WidgetTester tester) async {
      await tester.pumpWidget(rootWidget(const Loading(showMessage: true)));
      expect(find.text('Please Wait...'), findsOneWidget);
    });

    testWidgets('does not show please wait message when showMessage is false', (WidgetTester tester) async {
      await tester.pumpWidget(rootWidget(const Loading(showMessage: false)));
      expect(find.text('Please Wait...'), findsNothing);
    });
  });
} 