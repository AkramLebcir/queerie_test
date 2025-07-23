import 'package:flutter_test/flutter_test.dart';
import 'package:queerie_test/features/features.dart';
import '../../../../helpers/root_widget.dart';
import '../../../../helpers/mocks.mocks.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

void main() {
  testWidgets('MovieDetailPage renders', (tester) async {
    final mockRepository = MockMovieRepository();
    final getMovieDetail = GetMovieDetail(mockRepository);

    when(mockRepository.getMovieDetail('tt0133093')).thenAnswer(
      (_) async => Right(MovieDetailEntity(
        title: 'The Matrix',
        year: '1999',
        rated: '',
        released: '',
        runtime: '',
        genre: '',
        director: '',
        writer: '',
        actors: '',
        plot: '',
        language: '',
        country: '',
        awards: '',
        poster: '',
        metascore: '',
        imdbRating: '',
        imdbVotes: '',
        imdbID: 'tt0133093',
        type: '',
        dvd: '',
        boxOffice: '',
        production: '',
        website: '',
        response: 'True',
        error: null,
      )),
    );

    await tester.pumpWidget(
      rootWidget(MovieDetailPage(imdbID: 'tt0133093', getMovieDetail: getMovieDetail)),
    );
    expect(find.byType(MovieDetailPage), findsOneWidget);
  });
} 