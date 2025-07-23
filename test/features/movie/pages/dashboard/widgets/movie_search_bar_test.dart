import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:queerie_test/features/movie/pages/widgets/movie_search_bar.dart';

import '../../../../../helpers/root_widget.dart';

void main() {
  testWidgets('MovieSearchBar renders and responds to input', (tester) async {
    final controller = TextEditingController();
    await tester.pumpWidget(
      rootWidget(
        MovieSearchBar(
          controller: controller,
          hasText: false,
          onFilter: () {},
          onClear: () {},
          onSearch: () {},
          onSubmitted: (_) {},
        ),
      ),
    );
    expect(find.byType(TextField), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'matrix');
    expect(controller.text, 'matrix');
  });
} 