import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/movie_search_result.dart';

part 'dashboard_cubit.freezed.dart';

@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState({
    @Default('') String selectedType,
    @Default('') String selectedYear,
    @Default(false) bool hasSearched,
    @Default(1) int currentPage,
    @Default(false) bool isFetchingMore,
    @Default([]) List<MovieSearchItemEntity> searchResults,
    @Default({
      'Popular Movies': <MovieSearchItemEntity>[],
      'New Releases': <MovieSearchItemEntity>[],
    }) Map<String, List<MovieSearchItemEntity>> popularResults,
  }) = _DashboardState;
}

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(const DashboardState());

  void setFilters({String? type, String? year}) {
    emit(state.copyWith(
      selectedType: type ?? state.selectedType,
      selectedYear: year ?? state.selectedYear,
    ));
  }

  void clearFilters() {
    emit(state.copyWith(
      selectedType: '',
      selectedYear: '',
    ));
  }

  void removeTypeFilter() {
    emit(state.copyWith(selectedType: ''));
  }

  void removeYearFilter() {
    emit(state.copyWith(selectedYear: ''));
  }

  void setSearchMode(bool hasSearched) {
    emit(state.copyWith(
      hasSearched: hasSearched,
      currentPage: 1,
      searchResults: hasSearched ? [] : state.searchResults,
    ));
  }

  void setSearchResults(List<MovieSearchItemEntity> results) {
    emit(state.copyWith(
      searchResults: results,
      isFetchingMore: false,
    ));
  }

  void appendSearchResults(List<MovieSearchItemEntity> results) {
    emit(state.copyWith(
      searchResults: [...state.searchResults, ...results],
      isFetchingMore: false,
    ));
  }

  void setFetchingMore(bool isFetchingMore) {
    emit(state.copyWith(isFetchingMore: isFetchingMore));
  }

  void incrementPage() {
    emit(state.copyWith(currentPage: state.currentPage + 1));
  }

  void resetPage() {
    emit(state.copyWith(currentPage: 1));
  }

  void setPopularResults(Map<String, List<MovieSearchItemEntity>> results) {
    emit(state.copyWith(popularResults: results));
  }

  void updatePopularResults(String key, List<MovieSearchItemEntity> results) {
    final updated = Map<String, List<MovieSearchItemEntity>>.from(state.popularResults);
    updated[key] = results;
    emit(state.copyWith(popularResults: updated));
  }

  void resetSearchState() {
    emit(state.copyWith(
      hasSearched: false,
      currentPage: 1,
      searchResults: [],
    ));
  }

  void clearAll() {
    emit(const DashboardState());
  }
} 