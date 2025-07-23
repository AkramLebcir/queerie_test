import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:queerie_test/features/movie/pages/widgets/movie_card.dart';

void main() {
  testWidgets('MovieCard displays movie info', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MovieCard(
          title: 'The Matrix',
          year: '1999',
          posterUrl: 'https://example.com/matrix.jpg',
        ),
      ),
    );
    expect(find.text('The Matrix'), findsOneWidget);
    expect(find.text('1999'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });
} 