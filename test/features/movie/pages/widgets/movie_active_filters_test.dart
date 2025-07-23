import 'package:flutter_test/flutter_test.dart';
import 'package:queerie_test/features/movie/pages/widgets/movie_active_filters.dart';

import '../../../../helpers/root_widget.dart';

void main() {
  testWidgets('MovieActiveFilters displays year', (tester) async {
    await tester.pumpWidget(
      rootWidget(MovieActiveFilters(
        year: '2023',
        onClearAll: () {},
        onRemoveYear: () {},
      )),
    );
    expect(find.textContaining('2023'), findsOneWidget);
  });
} 