import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:queerie_test/core/core.dart';
import 'package:queerie_test/features/movie/pages/dashboard/bloc/movie_search_bloc.dart';
import 'package:queerie_test/features/movie/pages/dashboard/bloc/movie_search_event.dart';
import 'package:queerie_test/features/movie/pages/dashboard/bloc/movie_search_state.dart';
import 'package:queerie_test/features/movie/domain/entities/movie_search_result.dart';
import '../../../../../helpers/mocks.mocks.dart';

void main() {
  late MockSearchMovies mockSearchMovies;
  late MovieSearchBloc bloc;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    bloc = MovieSearchBloc(mockSearchMovies);
  });

  blocTest<MovieSearchBloc, MovieSearchState>(
    'emits [MovieSearchLoading, MovieSearchLoaded] when search is successful',
    build: () {
      when(mockSearchMovies.call(
        'matrix',
        page: 1,
        type: null,
        year: null,
      )).thenAnswer((_) async => Right(MovieSearchResultEntity(
        search: [MovieSearchItemEntity(title: 'The Matrix', year: '1999', imdbID: 'tt0133093', type: 'movie', poster: '')],
        totalResults: '1',
        response: 'True',
        error: null,
      )));
      return bloc;
    },
    act: (bloc) => bloc.add(MovieSearchQueryChanged('matrix')),
    expect: () => [
      isA<MovieSearchLoading>(),
      isA<MovieSearchLoaded>(),
    ],
  );

  blocTest<MovieSearchBloc, MovieSearchState>(
    'emits [MovieSearchLoading, MovieSearchEmpty] when search returns empty',
    build: () {
      when(mockSearchMovies.call(
        'empty',
        page: 1,
        type: null,
        year: null,
      )).thenAnswer((_) async => Right(MovieSearchResultEntity(
        search: [],
        totalResults: '0',
        response: 'True',
        error: null,
      )));
      return bloc;
    },
    act: (bloc) => bloc.add(MovieSearchQueryChanged('empty')),
    expect: () => [
      isA<MovieSearchLoading>(),
      isA<MovieSearchEmpty>(),
    ],
  );

  blocTest<MovieSearchBloc, MovieSearchState>(
    'emits [MovieSearchLoading, MovieSearchError] when search fails',
    build: () {
      when(mockSearchMovies.call(
        'fail',
        page: 1,
        type: null,
        year: null,
      )).thenAnswer((_) async => Left(ServerFailure('error')));
      return bloc;
    },
    act: (bloc) => bloc.add(MovieSearchQueryChanged('fail')),
    expect: () => [
      isA<MovieSearchLoading>(),
      isA<MovieSearchError>(),
    ],
  );
} 