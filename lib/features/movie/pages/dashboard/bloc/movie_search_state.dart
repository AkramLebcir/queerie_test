import '../../../domain/entities/movie_search_result.dart';

abstract class MovieSearchState {}

class MovieSearchInitial extends MovieSearchState {}
class MovieSearchLoading extends MovieSearchState {}
class MovieSearchLoaded extends MovieSearchState {
  final MovieSearchResultEntity result;
  MovieSearchLoaded(this.result);
}
class MovieSearchEmpty extends MovieSearchState {}
class MovieSearchError extends MovieSearchState {
  final String message;
  MovieSearchError(this.message);
} 