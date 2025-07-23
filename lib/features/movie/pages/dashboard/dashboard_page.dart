import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/movie_search_result.dart';
import '../widgets/widgets.dart';
import 'bloc/bloc.dart';

class MovieDashboardPage extends StatefulWidget {
  const MovieDashboardPage({super.key});

  @override
  State<MovieDashboardPage> createState() => _MovieDashboardPageState();
}

class _MovieDashboardPageState extends State<MovieDashboardPage> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  String _selectedType = '';
  String _selectedYear = '';
  bool _hasSearched = false;
  int _currentPage = 1;
  bool _isFetchingMore = false;
  List<MovieSearchItemEntity> _searchResults = [];
  final Map<String, List<MovieSearchItemEntity>> _popularResults = {
    'Popular Movies': [],
    'New Releases': [],
  };

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
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 &&
        !_isFetchingMore &&
        _hasSearched) {
      _fetchNextPage();
    }
  }

  Future<void> _fetchNextPage() async {
    if (_isFetchingMore) return;
    setState(() => _isFetchingMore = true);
    
    context.read<MovieSearchBloc>().add(MovieSearchQueryChanged(
      _searchController.text,
      type: _selectedType,
      year: _selectedYear,
      page: _currentPage + 1,
      append: true,
    ));
    
    setState(() => _currentPage++);
  }

  Future<void> _fetchPopularMovies() async {
    final currentYear = DateTime.now().year.toString();
    // Popular Movies: use selected year if set, otherwise no year filter
    context.read<MovieSearchBloc>().add(MovieSearchQueryChanged(
      'movie',
      type: _selectedType.isNotEmpty ? _selectedType : null,
      year: _selectedYear.isNotEmpty ? _selectedYear : null,
      page: 1,
    ));

    // New Releases: always use current year
    context.read<MovieSearchBloc>().add(MovieSearchQueryChanged(
      'movie',
      type: _selectedType.isNotEmpty ? _selectedType : null,
      year: currentYear,
      page: 1,
    ));
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (modalContext) => MovieFilterModal(
        initialType: _selectedType,
        initialYear: _selectedYear,
        onApply: (type, year) async {
          setState(() {
            _selectedType = type ?? '';
            _selectedYear = year ?? '';
          });
          if (_hasSearched) {
            _submitSearch();
          } else {
            await _fetchPopularMovies();
          }
        },
        onReset: () {
          setState(() {
            _selectedType = '';
            _selectedYear = '';
          });
          if (_hasSearched) {
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

    setState(() {
      _hasSearched = true;
      _currentPage = 1;
      _searchResults = [];
    });

    context.read<MovieSearchBloc>().add(MovieSearchQueryChanged(
      query,
      type: _selectedType,
      year: _selectedYear,
      page: 1,
    ));
  }

  void _resetSearchState() {
    setState(() {
      _hasSearched = false;
      _currentPage = 1;
      _searchResults = [];
      _searchController.clear();
    });
    context.read<MovieSearchBloc>().add(MovieSearchCleared());
    _fetchPopularMovies();
  }

  void _resetFilters() {
    setState(() {
      _selectedType = '';
      _selectedYear = '';
    });
    if (_hasSearched) {
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
            if (_selectedType.isNotEmpty || _selectedYear.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: MovieActiveFilters(
                  type: _selectedType,
                  year: _selectedYear,
                  onClearAll: _resetFilters,
                  onRemoveType: _selectedType.isNotEmpty
                      ? () {
                          setState(() => _selectedType = '');
                          if (_hasSearched) {
                            _submitSearch();
                          } else {
                            _fetchPopularMovies();
                          }
                        }
                      : null,
                  onRemoveYear: _selectedYear.isNotEmpty
                      ? () {
                          setState(() => _selectedYear = '');
                          if (_hasSearched) {
                            _submitSearch();
                          } else {
                            _fetchPopularMovies();
                          }
                        }
                      : null,
                ),
              ),
            Expanded(
              child: BlocConsumer<MovieSearchBloc, MovieSearchState>(
                listener: (context, state) {
                  if (state is MovieSearchLoaded && !_hasSearched) {
                      _popularResults['Popular Movies'] = state.result.search;
                      _popularResults['New Releases'] = state.result.search;
                  } else if (state is MovieSearchLoaded && _hasSearched) {
                    setState(() {
                      if (state.result.search.isNotEmpty) {
                        _searchResults = state.result.search;
                        _isFetchingMore = false;
                      }
                    });
                  }
                },
                builder: (context, state) {
                  if (state is MovieSearchLoading && !_isFetchingMore) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is MovieSearchError) {
                    return MovieEmptyState(
                      message: state.message,
                      onRetry: () {
                        if (_hasSearched) {
                          _submitSearch();
                        } else {
                          _fetchPopularMovies();
                        }
                      },
                    );
                  }

                  if (_hasSearched) {
                    if (_searchResults.isEmpty && state is! MovieSearchLoading) {
                      return const MovieEmptyState();
                    }
                    return MovieSearchResultsList(
                      results: _searchResults,
                      isFetchingMore: _isFetchingMore,
                      hasMoreResults: _searchResults.length < (state is MovieSearchLoaded ? int.parse(state.result.totalResults) : 0),
                      scrollController: _scrollController,
                      onCardTap: _navigateToDetail,
                    );
                  }

                  return MoviePopularGrid(
                    popularResults: _popularResults,
                    onCardTap: _navigateToDetail,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
} 