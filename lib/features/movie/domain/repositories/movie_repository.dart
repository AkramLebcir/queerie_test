import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/movie_search_result.dart';
import '../entities/movie_detail.dart';

abstract class MovieRepository {
  Future<Either<Failure, MovieSearchResultEntity>> searchMovies(String query, {int page = 1, String? type, String? year});
  Future<Either<Failure, MovieDetailEntity>> getMovieDetail(String imdbID);
} 