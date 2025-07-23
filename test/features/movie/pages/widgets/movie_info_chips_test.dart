import 'package:flutter_test/flutter_test.dart';
import 'package:queerie_test/features/movie/pages/widgets/movie_info_chips.dart';
import '../../../../helpers/root_widget.dart';

void main() {
  testWidgets('MovieInfoChips displays info', (tester) async {
    await tester.pumpWidget(rootWidget(MovieInfoChips(runtime: '2h 30m', genre: 'Sci-Fi', rated: '8.9',)));
    expect(find.text('8.9'), findsOneWidget);
    expect(find.text('Sci-Fi'), findsOneWidget);
    expect(find.text('2h 30m'), findsOneWidget);
  });
}
