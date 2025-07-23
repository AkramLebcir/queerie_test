import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queerie_test/core/core.dart';
import '../../../domain/entities/movie_search_result.dart';
import '../../../domain/usecases/search_movies.dart';
import 'movie_search_event.dart';
import 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies searchMovies;

  MovieSearchBloc(this.searchMovies) : super(MovieSearchInitial()) {
    on<MovieSearchQueryChanged>((event, emit) async {
      if (event.query.trim().isEmpty) {
        emit(MovieSearchInitial());
        return;
      }
      if (!event.append) {
        emit(MovieSearchLoading());
      }
      final result = await searchMovies(
        event.query,
        type: event.type,
        year: event.year,
        page: event.page ?? 1,
      );
      result.fold(
        (failure) => emit(MovieSearchError(failure is ServerFailure ? failure.message ?? 'Error' : 'Error')),
        (data) {
          if (data.response == 'True' && data.search.isNotEmpty) {
            if (event.append && state is MovieSearchLoaded) {
              final prev = (state as MovieSearchLoaded).result;
              emit(MovieSearchLoaded(
                MovieSearchResultEntity(
                  search: [...prev.search, ...data.search],
                  totalResults: data.totalResults,
                  response: data.response,
                  error: data.error,
                ),
              ));
            } else {
              emit(MovieSearchLoaded(data));
            }
          } else if (data.error != null && data.error!.isNotEmpty) {
            emit(MovieSearchError(data.error!));
          } else {
            emit(MovieSearchEmpty());
          }
        },
      );
    });
    on<MovieSearchCleared>((event, emit) => emit(MovieSearchInitial()));
  }
} 