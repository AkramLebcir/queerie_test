import 'package:queerie_test/features/movie/domain/entities/movie_search_result.dart';
import 'package:queerie_test/features/movie/pages/widgets/movie_popular_grid.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../helpers/root_widget.dart';

void main() {
  testWidgets('MoviePopularGrid renders with empty list', (tester) async {
    await tester.pumpWidget(
      rootWidget(MoviePopularGrid(popularResults: {}, onCardTap: (MovieSearchItemEntity movie) {  },)),
    );
    expect(find.byType(MoviePopularGrid), findsOneWidget);
  });
} 