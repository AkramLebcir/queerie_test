import 'package:flutter_test/flutter_test.dart';
import 'package:queerie_test/features/movie/pages/widgets/movie_rating_row.dart';
import '../../../../helpers/root_widget.dart';

void main() {
  testWidgets('MovieRatingRow displays rating', (tester) async {
    await tester.pumpWidget(
      rootWidget(MovieRatingRow(imdbRating: '8.7')),
    );
    expect(find.text('8.7'), findsOneWidget);
  });
} 