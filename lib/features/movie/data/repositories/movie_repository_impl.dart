import 'package:dartz/dartz.dart';
import '../../domain/entities/movie_search_result.dart';
import '../../domain/entities/movie_detail.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/movie_remote_datasource.dart';
import '../../../../core/error/failure.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDatasource remoteDatasource;

  MovieRepositoryImpl(this.remoteDatasource);

  @override
  Future<Either<Failure, MovieSearchResultEntity>> searchMovies(String query, {int page = 1, String? type, String? year}) async {
    final result = await remoteDatasource.searchMovies(query, page: page, type: type, year: year);
    return result.map((data) => MovieSearchResultEntity(
      search: data.search
          .map((item) => MovieSearchItemEntity(
                title: item.title,
                year: item.year,
                imdbID: item.imdbID,
                type: item.type,
                poster: item.poster,
              ))
          .toList(),
      totalResults: data.totalResults,
      response: data.response,
      error: data.error,
    ));
  }

  @override
  Future<Either<Failure, MovieDetailEntity>> getMovieDetail(String imdbID) async {
    final result = await remoteDatasource.getMovieDetail(imdbID);
    return result.map((detail) => MovieDetailEntity(
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
    ));
  }
} 