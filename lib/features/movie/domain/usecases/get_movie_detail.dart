import 'package:dartz/dartz.dart';
import '../repositories/movie_repository.dart';
import '../entities/movie_detail.dart';
import '../../../../core/error/failure.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetailEntity>> call(String imdbID) {
    return repository.getMovieDetail(imdbID);
  }
} 