import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:queerie_test/features/movie/domain/usecases/get_movie_detail.dart';
import 'package:queerie_test/features/movie/domain/entities/movie_detail.dart';
import 'package:queerie_test/features/movie/data/models/movie_detail.dart';
import '../../../../helpers/json_reader.dart';
import '../../../../helpers/paths.dart';
import '../../../../helpers/mocks.mocks.dart';
import 'package:queerie_test/core/error/failure.dart';

void main() {
  late GetMovieDetail usecase;
  late MockMovieRepository mockRepository;

  setUp(() {
    mockRepository = MockMovieRepository();
    usecase = GetMovieDetail(mockRepository);
  });

  test('should return Right(MovieDetailEntity) from repository', () async {
    final jsonMap = json.decode(jsonReader(movieDetailPath)) as Map<String, dynamic>;
    final detail = MovieDetail.fromJson(jsonMap);
    final entity = MovieDetailEntity(
      title: detail.title,
      year: detail.year,
      rated: detail.rated,
      released: detail.released,
      runtime: detail.runtime,
      genre: detail.genre,
      director: detail.director,
      writer: detail.writer,
      actors: detail.actors,
      plot: detail.plot,
      language: detail.language,
      country: detail.country,
      awards: detail.awards,
      poster: detail.poster,
      metascore: detail.metascore,
      imdbRating: detail.imdbRating,
      imdbVotes: detail.imdbVotes,
      imdbID: detail.imdbID,
      type: detail.type,
      dvd: detail.dvd,
      boxOffice: detail.boxOffice,
      production: detail.production,
      website: detail.website,
      response: detail.response,
      error: detail.error,
    );
    when(mockRepository.getMovieDetail('tt0133093')).thenAnswer((_) async => Right(entity));
    final result = await usecase('tt0133093');
    expect(result.isRight(), true);
    result.fold(
      (failure) => fail('Should not be failure'),
      (data) => expect(data.title, 'The Matrix'),
    );
  });

  test('should return Left(ServerFailure) from repository on failure', () async {
    when(mockRepository.getMovieDetail('tt0133093')).thenAnswer((_) async => Left(ServerFailure('error')));
    final result = await usecase('tt0133093');
    expect(result.isLeft(), true);
    result.fold(
      (failure) => expect(failure, isA<ServerFailure>()),
      (_) => fail('Should not be success'),
    );
  });
} 