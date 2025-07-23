import 'package:flutter_test/flutter_test.dart';
import 'package:queerie_test/features/movie/pages/widgets/movie_detail_info.dart';
import '../../../../../helpers/root_widget.dart';

void main() {
  testWidgets('MovieDetailInfo displays movie details', (tester) async {
    await tester.pumpWidget(
      rootWidget(
        MovieDetailInfo(
          plot: 'A computer hacker learns about the true nature of reality.',
          director: 'Lana Wachowski, Lilly Wachowski',
          writer: 'Lilly Wachowski, Lana Wachowski',
          actors: 'Keanu Reeves, Laurence Fishburne, Carrie-Anne Moss',
          released: '1999',
          awards: 'Won 4 Oscars',
          boxOffice: ' 24171,479,930',
          production: 'Warner Bros. Pictures',
        ),
      ),
    );
    expect(find.textContaining('computer hacker'), findsOneWidget);
    expect(find.textContaining('Lana Wachowski'), findsNWidgets(2));
    expect(find.textContaining('Keanu Reeves'), findsOneWidget);
    expect(find.textContaining('1999'), findsOneWidget);
    expect(find.textContaining('Oscars'), findsOneWidget);
    expect(find.textContaining('Warner Bros.'), findsOneWidget);
  });
} 