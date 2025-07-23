import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:queerie_test/features/movie/domain/usecases/search_movies.dart';
import 'package:queerie_test/features/movie/domain/entities/movie_search_result.dart';
import 'package:queerie_test/features/movie/data/models/movie_search_result.dart';
import '../../../../helpers/json_reader.dart';
import '../../../../helpers/paths.dart';
import '../../../../helpers/mocks.mocks.dart';
import 'package:queerie_test/core/error/failure.dart';

void main() {
  late SearchMovies usecase;
  late MockMovieRepository mockRepository;

  setUp(() {
    mockRepository = MockMovieRepository();
    usecase = SearchMovies(mockRepository);
  });

  test('should return Right(MovieSearchResultEntity) from repository', () async {
    final jsonMap = json.decode(jsonReader(movieSearchResultPath)) as Map<String, dynamic>;
    final searchResult = MovieSearchResult.fromJson(jsonMap);
    final entity = MovieSearchResultEntity(
      search: searchResult.search.map((item) => MovieSearchItemEntity(
        title: item.title,
        year: item.year,
        imdbID: item.imdbID,
        type: item.type,
        poster: item.poster,
      )).toList(),
      totalResults: searchResult.totalResults,
      response: searchResult.response,
      error: searchResult.error,
    );
    when(mockRepository.searchMovies(
      'matrix',
      page: 1,
      type: null,
      year: null,
    )).thenAnswer((_) async => Right(entity));
    final result = await usecase('matrix', page: 1);
    expect(result.isRight(), true);
    result.fold(
      (failure) => fail('Should not be failure'),
      (data) => expect(data.search.first.title, 'The Matrix'),
    );
  });

  test('should return Left(ServerFailure) from repository on failure', () async {
    when(mockRepository.searchMovies(
      'matrix',
      page: 1,
      type: null,
      year: null,
    )).thenAnswer((_) async => Left(ServerFailure('error')));
    final result = await usecase('matrix', page: 1);
    expect(result.isLeft(), true);
    result.fold(
      (failure) => expect(failure, isA<ServerFailure>()),
      (_) => fail('Should not be success'),
    );
  });
}