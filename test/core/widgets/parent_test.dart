import 'package:flutter_test/flutter_test.dart';
import 'package:queerie_test/core/widgets/parent.dart';
import '../../helpers/root_widget.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('Parent renders child', (WidgetTester tester) async {
    await tester.pumpWidget(rootWidget(const Parent(child: Text('ParentChild'))));
    expect(find.text('ParentChild'), findsOneWidget);
  });
} 