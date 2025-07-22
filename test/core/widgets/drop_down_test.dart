import 'package:flutter_test/flutter_test.dart';
import 'package:queerie_test/core/widgets/drop_down.dart';
import '../../helpers/root_widget.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('DropDown renders and selects item', (WidgetTester tester) async {
    String? selected = 'A';
    await tester.pumpWidget(rootWidget(DropDown<String>(
      value: selected,
      items: [
        DropdownMenuItem(value: 'A', child: Text('A')),
        DropdownMenuItem(value: 'B', child: Text('B')),
      ],
      onChanged: (val) => selected = val,
    )));
    expect(find.text('A'), findsOneWidget);
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('B').last);
    await tester.pumpAndSettle();
    expect(selected, 'B');
  });
} 