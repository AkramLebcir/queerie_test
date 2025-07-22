import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:queerie_test/core/widgets/toast.dart';
import '../../helpers/root_widget.dart';

void main() {
  group('Toast Widget', () {
    testWidgets('shows error toast', (WidgetTester tester) async {
      await tester.pumpWidget(rootWidget(const Toast(
        icon: Icons.error,
        bgColor: Colors.red,
        message: 'Error occurred',
        textColor: Colors.white,
      )));
      expect(find.text('Error occurred'), findsOneWidget);
      // expect(find.byIcon(Icons.error), findsOneWidget);
    });

    testWidgets('shows success toast', (WidgetTester tester) async {
      await tester.pumpWidget(rootWidget(const Toast(
        icon: Icons.check_circle,
        bgColor: Colors.green,
        message: 'Success!',
        textColor: Colors.white,
      )));
      expect(find.text('Success!'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });

    testWidgets('shows info toast', (WidgetTester tester) async {
      await tester.pumpWidget(rootWidget(const Toast(
        icon: Icons.info,
        bgColor: Colors.blue,
        message: 'Info message',
        textColor: Colors.white,
      )));
      expect(find.text('Info message'), findsOneWidget);
      expect(find.byIcon(Icons.info), findsOneWidget);
    });
  });
} 