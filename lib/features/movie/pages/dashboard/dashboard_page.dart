import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/movie_search_result.dart';
import '../widgets/widgets.dart';
import 'bloc/bloc.dart';
import 'cubit/cubit.dart';

class MovieDashboardPage extends StatelessWidget {
  const MovieDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardCubit(),
      child: const _MovieDashboardView(),
    );
  }
}

class _MovieDashboardView extends StatefulWidget {
  const _MovieDashboardView();

  @override
  State<_MovieDashboardView> createState() => _MovieDashboardViewState();
}

class _MovieDashboardViewState extends State<_MovieDashboardView> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _fetchPopularMovies();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final cubit = context.read<DashboardCubit>();
    final state = cubit.state;

    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 &&
        !state.isFetchingMore &&
        state.hasSearched) {
      _fetchNextPage();
    }
  }

  Future<void> _fetchNextPage() async {
    final cubit = context.read<DashboardCubit>();
    final state = cubit.state;

    if (state.isFetchingMore) return;

    cubit.setFetchingMore(true);
    cubit.incrementPage();

    context.read<MovieSearchBloc>().add(MovieSearchQueryChanged(
      _searchController.text,
      type: state.selectedType,
      year: state.selectedYear,
      page: state.currentPage,
      append: true,
    ));
  }

  Future<void> _fetchPopularMovies() async {
    final cubit = context.read<DashboardCubit>();
    final state = cubit.state;
    final currentYear = DateTime.now().year.toString();

    // Popular Movies: use selected year if set, otherwise no year filter
    context.read<MovieSearchBloc>().add(MovieSearchQueryChanged(
      'movie',
      type: state.selectedType.isNotEmpty ? state.selectedType : null,
      year: state.selectedYear.isNotEmpty ? state.selectedYear : null,
      page: 1,
    ));

    // New Releases: always use current year
    context.read<MovieSearchBloc>().add(MovieSearchQueryChanged(
      'movie',
      type: state.selectedType.isNotEmpty ? state.selectedType : null,
      year: currentYear,
      page: 1,
    ));
  }

  void _showFilterSheet() {
    final cubit = context.read<DashboardCubit>();
    final state = cubit.state;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (modalContext) => MovieFilterModal(
        initialType: state.selectedType,
        initialYear: state.selectedYear,
        onApply: (type, year) async {
          cubit.setFilters(type: type, year: year);
          if (state.hasSearched) {
            _submitSearch();
          } else {
            await _fetchPopularMovies();
          }
        },
        onReset: () {
          cubit.clearFilters();
          if (state.hasSearched) {
            _submitSearch();
          } else {
            _fetchPopularMovies();
          }
        },
      ),
    );
  }

  void _submitSearch() {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;

    final cubit = context.read<DashboardCubit>();
    final state = cubit.state;

    cubit.setSearchMode(true);
    cubit.resetPage();

    context.read<MovieSearchBloc>().add(MovieSearchQueryChanged(
      query,
      type: state.selectedType,
      year: state.selectedYear,
      page: 1,
    ));
  }

  void _resetSearchState() {
    final cubit = context.read<DashboardCubit>();

    cubit.resetSearchState();
    _searchController.clear();

    context.read<MovieSearchBloc>().add(MovieSearchCleared());
    _fetchPopularMovies();
  }

  void _resetFilters() {
    final cubit = context.read<DashboardCubit>();
    final state = cubit.state;

    cubit.clearFilters();
    if (state.hasSearched) {
      _submitSearch();
    } else {
      _fetchPopularMovies();
    }
  }

  void _removeTypeFilter() {
    final cubit = context.read<DashboardCubit>();
    final state = cubit.state;

    cubit.removeTypeFilter();
    if (state.hasSearched) {
      _submitSearch();
    } else {
      _fetchPopularMovies();
    }
  }

  void _removeYearFilter() {
    final cubit = context.read<DashboardCubit>();
    final state = cubit.state;

    cubit.removeYearFilter();
    if (state.hasSearched) {
      _submitSearch();
    } else {
      _fetchPopularMovies();
    }
  }

  void _navigateToDetail(MovieSearchItemEntity movie) {
    context.push('/movie/${movie.imdbID}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
        child: Column(
          children: [
            MovieSearchBar(
              controller: _searchController,
              hasText: _searchController.text.isNotEmpty,
              onFilter: _showFilterSheet,
              onClear: _resetSearchState,
              onSearch: _submitSearch,
              onSubmitted: (_) => _submitSearch(),
            ),
            const SizedBox(height: 12),
            BlocBuilder<DashboardCubit, DashboardState>(
              builder: (context, state) {
                if (state.selectedType.isNotEmpty || state.selectedYear.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: MovieActiveFilters(
                      type: state.selectedType,
                      year: state.selectedYear,
                      onClearAll: _resetFilters,
                      onRemoveType: state.selectedType.isNotEmpty ? _removeTypeFilter : null,
                      onRemoveYear: state.selectedYear.isNotEmpty ? _removeYearFilter : null,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            Expanded(
              child: BlocListener<MovieSearchBloc, MovieSearchState>(
                listener: (context, searchState) {
                  final cubit = context.read<DashboardCubit>();
                  final dashboardState = cubit.state;

                  if (searchState is MovieSearchLoaded && !dashboardState.hasSearched) {
                    cubit.updatePopularResults('Popular Movies', searchState.result.search);
                    cubit.updatePopularResults('New Releases', searchState.result.search);
                  } else if (searchState is MovieSearchLoaded && dashboardState.hasSearched) {
                    if (searchState.result.search.isNotEmpty) {
                      cubit.setSearchResults(searchState.result.search);
                    }
                  }
                },
                child: BlocBuilder<MovieSearchBloc, MovieSearchState>(
                  builder: (context, searchState) {
                    return BlocBuilder<DashboardCubit, DashboardState>(
                      builder: (context, dashboardState) {
                        if (searchState is MovieSearchLoading && !dashboardState.isFetchingMore) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        if (searchState is MovieSearchError) {
                          return MovieEmptyState(
                            message: searchState.message,
                            onRetry: () {
                              if (dashboardState.hasSearched) {
                                _submitSearch();
                              } else {
                                _fetchPopularMovies();
                              }
                            },
                          );
                        }

                        if (dashboardState.hasSearched) {
                          if (dashboardState.searchResults.isEmpty && searchState is! MovieSearchLoading) {
                            return const MovieEmptyState();
                          }
                          return MovieSearchResultsList(
                            results: dashboardState.searchResults,
                            isFetchingMore: dashboardState.isFetchingMore,
                            hasMoreResults: dashboardState.searchResults.length < (searchState is MovieSearchLoaded ? int.parse(searchState.result.totalResults) : 0),
                            scrollController: _scrollController,
                            onCardTap: _navigateToDetail,
                          );
                        }

                        return MoviePopularGrid(
                          popularResults: dashboardState.popularResults,
                          onCardTap: _navigateToDetail,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 