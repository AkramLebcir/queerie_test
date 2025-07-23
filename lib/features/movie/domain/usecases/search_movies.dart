import 'package:dartz/dartz.dart';
import '../repositories/movie_repository.dart';
import '../entities/movie_search_result.dart';
import '../../../../core/error/failure.dart';

class SearchMovies {
  final MovieRepository repository;

  SearchMovies(this.repository);

  Future<Either<Failure, MovieSearchResultEntity>> call(String query, {int page = 1, String? type, String? year}) {
    return repository.searchMovies(query, page: page, type: type, year: year);
  }
} 