import 'package:flutter_test/flutter_test.dart';
import 'package:queerie_test/core/widgets/empty.dart';
import '../../helpers/root_widget.dart';

void main() {
  group('Empty Widget', () {
    testWidgets('shows default no data message when no errorMessage is provided', (WidgetTester tester) async {
      await tester.pumpWidget(rootWidget(const Empty()));
      expect(find.text('No data'), findsOneWidget);
    });

    testWidgets('shows custom errorMessage when provided', (WidgetTester tester) async {
      const errorMsg = 'Something went wrong!';
      await tester.pumpWidget(rootWidget(const Empty(errorMessage: errorMsg)));
      expect(find.text(errorMsg), findsOneWidget);
    });

    testWidgets('shows error message for long error', (WidgetTester tester) async {
      const errorMsg = 'Connection error. Please check your internet connection.';
      await tester.pumpWidget(rootWidget(const Empty(errorMessage: errorMsg)));
      expect(find.text(errorMsg), findsOneWidget);
    });
  });
} 