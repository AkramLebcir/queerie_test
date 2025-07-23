import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:queerie_test/features/movie/data/repositories/movie_repository_impl.dart';
import 'package:queerie_test/features/movie/data/models/movie_search_result.dart';
import 'package:queerie_test/features/movie/data/models/movie_detail.dart';
import 'dart:convert';
import '../../../../helpers/json_reader.dart';
import '../../../../helpers/paths.dart';
import '../../../../helpers/mocks.mocks.dart';
import 'package:queerie_test/core/error/failure.dart';

void main() {
  late MovieRepositoryImpl repository;
  late MockMovieRemoteDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockMovieRemoteDatasource();
    repository = MovieRepositoryImpl(mockDatasource);
  });

  test('should return Right(MovieSearchResultEntity) on searchMovies', () async {
    final jsonMap = json.decode(jsonReader(movieSearchResultPath)) as Map<String, dynamic>;
    final searchResult = MovieSearchResult.fromJson(jsonMap);
    when(mockDatasource.searchMovies(
      'matrix',
      page: 1,
      type: null,
      year: null,
    )).thenAnswer((_) async => Right(searchResult));
    final result = await repository.searchMovies('matrix', page: 1);
    expect(result.isRight(), true);
    result.fold(
      (failure) => fail('Should not be failure'),
      (data) => expect(data.search.first.title, 'The Matrix'),
    );
  });

  test('should return Left(ServerFailure) on searchMovies failure', () async {
    when(mockDatasource.searchMovies(
      'matrix',
      page: 1,
      type: null,
      year: null,
    )).thenAnswer((_) async => Left(ServerFailure('error')));
    final result = await repository.searchMovies('matrix', page: 1);
    expect(result.isLeft(), true);
    result.fold(
      (failure) => expect(failure, isA<ServerFailure>()),
      (_) => fail('Should not be success'),
    );
  });

  test('should return Right(MovieDetailEntity) on getMovieDetail', () async {
    final detailJson = json.decode(jsonReader(movieDetailPath)) as Map<String, dynamic>;
    final detail = MovieDetail.fromJson(detailJson);
    when(mockDatasource.getMovieDetail('tt0133093')).thenAnswer((_) async => Right(detail));
    final result = await repository.getMovieDetail('tt0133093');
    expect(result.isRight(), true);
    result.fold(
      (failure) => fail('Should not be failure'),
      (data) => expect(data.title, 'The Matrix'),
    );
  });

  test('should return Left(ServerFailure) on getMovieDetail failure', () async {
    when(mockDatasource.getMovieDetail('tt0133093')).thenAnswer((_) async => Left(ServerFailure('error')));
    final result = await repository.getMovieDetail('tt0133093');
    expect(result.isLeft(), true);
    result.fold(
      (failure) => expect(failure, isA<ServerFailure>()),
      (_) => fail('Should not be success'),
    );
  });
}