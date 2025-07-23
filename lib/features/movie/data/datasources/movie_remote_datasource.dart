import 'package:dartz/dartz.dart';
import 'package:queerie_test/core/core.dart';
import '../models/movie_search_result.dart';
import '../models/movie_detail.dart';

abstract class MovieRemoteDatasource {
  Future<Either<Failure, MovieSearchResult>> searchMovies(String query, {int page = 1, String? type, String? year});
  Future<Either<Failure, MovieDetail>> getMovieDetail(String imdbID);
}

class MovieRemoteDatasourceImpl implements MovieRemoteDatasource {
  final DioClient dioClient;

  MovieRemoteDatasourceImpl(this.dioClient);

  @override
  Future<Either<Failure, MovieSearchResult>> searchMovies(String query, {int page = 1, String? type, String? year}) {
    final params = {
      's': query,
      'page': page,
      'r': 'json',
      if (type != null && type.isNotEmpty) 'type': type,
      if (year != null && year.isNotEmpty) 'y': year,
    };
    return dioClient.getRequest(
      '/',
      queryParameters: params,
      converter: (json) => MovieSearchResult.fromJson(json),
      isIsolate: false,
    );
  }

  @override
  Future<Either<Failure, MovieDetail>> getMovieDetail(String imdbID) {
    return dioClient.getRequest(
      '/',
      queryParameters: {
        'i': imdbID,
        'plot': 'full',
        'r': 'json',
      },
      converter: (json) => MovieDetail.fromJson(json),
      isIsolate: false,
    );
  }
} 