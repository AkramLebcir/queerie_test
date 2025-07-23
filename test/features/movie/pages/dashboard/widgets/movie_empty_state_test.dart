import 'package:flutter_test/flutter_test.dart';
import 'package:queerie_test/features/movie/pages/widgets/movie_empty_state.dart';
import '../../../../../helpers/root_widget.dart';

void main() {
  testWidgets('MovieEmptyState displays empty message', (tester) async {
    await tester.pumpWidget(
      rootWidget(
        MovieEmptyState(),
      ),
    );
    expect(find.textContaining('No results'), findsWidgets);
  });
} 