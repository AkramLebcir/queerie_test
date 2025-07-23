import 'package:flutter_test/flutter_test.dart';
import 'package:queerie_test/features/movie/domain/entities/movie_search_result.dart';
import 'package:queerie_test/features/movie/pages/dashboard/cubit/dashboard_cubit.dart';

void main() {
  group('DashboardCubit', () {
    late DashboardCubit cubit;

    setUp(() {
      cubit = DashboardCubit();
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is correct', () {
      expect(cubit.state.selectedType, '');
      expect(cubit.state.selectedYear, '');
      expect(cubit.state.hasSearched, false);
      expect(cubit.state.currentPage, 1);
      expect(cubit.state.isFetchingMore, false);
      expect(cubit.state.searchResults, isEmpty);
              expect(cubit.state.popularResults, <String, List<MovieSearchItemEntity>>{
          'Popular Movies': <MovieSearchItemEntity>[],
          'New Releases': <MovieSearchItemEntity>[],
        });
    });

    group('setFilters', () {
      test('sets type filter', () {
        cubit.setFilters(type: 'movie');
        expect(cubit.state.selectedType, 'movie');
        expect(cubit.state.selectedYear, '');
      });

      test('sets year filter', () {
        cubit.setFilters(year: '2023');
        expect(cubit.state.selectedType, '');
        expect(cubit.state.selectedYear, '2023');
      });

      test('sets both filters', () {
        cubit.setFilters(type: 'movie', year: '2023');
        expect(cubit.state.selectedType, 'movie');
        expect(cubit.state.selectedYear, '2023');
      });

      test('preserves existing filters when not provided', () {
        cubit.setFilters(type: 'movie', year: '2023');
        cubit.setFilters(type: 'series');
        expect(cubit.state.selectedType, 'series');
        expect(cubit.state.selectedYear, '2023');
      });
    });

    group('clearFilters', () {
      test('clears all filters', () {
        cubit.setFilters(type: 'movie', year: '2023');
        cubit.clearFilters();
        expect(cubit.state.selectedType, '');
        expect(cubit.state.selectedYear, '');
      });
    });

    group('removeTypeFilter', () {
      test('removes only type filter', () {
        cubit.setFilters(type: 'movie', year: '2023');
        cubit.removeTypeFilter();
        expect(cubit.state.selectedType, '');
        expect(cubit.state.selectedYear, '2023');
      });
    });

    group('removeYearFilter', () {
      test('removes only year filter', () {
        cubit.setFilters(type: 'movie', year: '2023');
        cubit.removeYearFilter();
        expect(cubit.state.selectedType, 'movie');
        expect(cubit.state.selectedYear, '');
      });
    });

    group('setSearchMode', () {
      test('sets search mode to true', () {
        cubit.setSearchMode(true);
        expect(cubit.state.hasSearched, true);
        expect(cubit.state.currentPage, 1);
        expect(cubit.state.searchResults, isEmpty);
      });

      test('sets search mode to false', () {
        cubit.setSearchMode(true);
        cubit.setSearchResults([MovieSearchItemEntity(
          title: 'Test Movie',
          year: '2023',
          imdbID: 'tt123456',
          type: 'movie',
          poster: 'test.jpg',
        )]);
        cubit.setSearchMode(false);
        expect(cubit.state.hasSearched, false);
        expect(cubit.state.currentPage, 1);
        expect(cubit.state.searchResults, isNotEmpty);
      });
    });

    group('setSearchResults', () {
      test('sets search results and resets fetching more', () {
        cubit.setFetchingMore(true);
        final results = [
          MovieSearchItemEntity(
            title: 'Test Movie',
            year: '2023',
            imdbID: 'tt123456',
            type: 'movie',
            poster: 'test.jpg',
          ),
        ];
        cubit.setSearchResults(results);
        expect(cubit.state.searchResults, results);
        expect(cubit.state.isFetchingMore, false);
      });
    });

    group('appendSearchResults', () {
      test('appends search results to existing ones', () {
        final initialResults = [
          MovieSearchItemEntity(
            title: 'Test Movie 1',
            year: '2023',
            imdbID: 'tt123456',
            type: 'movie',
            poster: 'test1.jpg',
          ),
        ];
        cubit.setSearchResults(initialResults);
        
        final additionalResults = [
          MovieSearchItemEntity(
            title: 'Test Movie 2',
            year: '2023',
            imdbID: 'tt789012',
            type: 'movie',
            poster: 'test2.jpg',
          ),
        ];
        cubit.appendSearchResults(additionalResults);
        
        expect(cubit.state.searchResults.length, 2);
        expect(cubit.state.searchResults.first.title, 'Test Movie 1');
        expect(cubit.state.searchResults.last.title, 'Test Movie 2');
        expect(cubit.state.isFetchingMore, false);
      });
    });

    group('setFetchingMore', () {
      test('sets fetching more state', () {
        cubit.setFetchingMore(true);
        expect(cubit.state.isFetchingMore, true);
        
        cubit.setFetchingMore(false);
        expect(cubit.state.isFetchingMore, false);
      });
    });

    group('incrementPage', () {
      test('increments current page', () {
        expect(cubit.state.currentPage, 1);
        cubit.incrementPage();
        expect(cubit.state.currentPage, 2);
        cubit.incrementPage();
        expect(cubit.state.currentPage, 3);
      });
    });

    group('resetPage', () {
      test('resets current page to 1', () {
        cubit.incrementPage();
        cubit.incrementPage();
        expect(cubit.state.currentPage, 3);
        cubit.resetPage();
        expect(cubit.state.currentPage, 1);
      });
    });

    group('setPopularResults', () {
      test('sets all popular results', () {
        final results = <String, List<MovieSearchItemEntity>>{
          'Popular Movies': [
            MovieSearchItemEntity(
              title: 'Popular Movie',
              year: '2023',
              imdbID: 'tt123456',
              type: 'movie',
              poster: 'popular.jpg',
            ),
          ],
          'New Releases': [
            MovieSearchItemEntity(
              title: 'New Movie',
              year: '2023',
              imdbID: 'tt789012',
              type: 'movie',
              poster: 'new.jpg',
            ),
          ],
        };
        cubit.setPopularResults(results);
        expect(cubit.state.popularResults, results);
      });
    });

    group('updatePopularResults', () {
      test('updates specific popular results key', () {
        final initialResults = <String, List<MovieSearchItemEntity>>{
          'Popular Movies': [
            MovieSearchItemEntity(
              title: 'Popular Movie',
              year: '2023',
              imdbID: 'tt123456',
              type: 'movie',
              poster: 'popular.jpg',
            ),
          ],
          'New Releases': <MovieSearchItemEntity>[],
        };
        cubit.setPopularResults(initialResults);
        
        final newReleases = [
          MovieSearchItemEntity(
            title: 'New Movie',
            year: '2023',
            imdbID: 'tt789012',
            type: 'movie',
            poster: 'new.jpg',
          ),
        ];
        cubit.updatePopularResults('New Releases', newReleases);
        
        expect(cubit.state.popularResults['Popular Movies'], initialResults['Popular Movies']);
        expect(cubit.state.popularResults['New Releases'], newReleases);
      });
    });

    group('resetSearchState', () {
      test('resets search state', () {
        cubit.setSearchMode(true);
        cubit.incrementPage();
        cubit.setSearchResults([
          MovieSearchItemEntity(
            title: 'Test Movie',
            year: '2023',
            imdbID: 'tt123456',
            type: 'movie',
            poster: 'test.jpg',
          ),
        ]);
        
        cubit.resetSearchState();
        
        expect(cubit.state.hasSearched, false);
        expect(cubit.state.currentPage, 1);
        expect(cubit.state.searchResults, isEmpty);
      });
    });

    group('clearAll', () {
      test('resets to initial state', () {
        cubit.setFilters(type: 'movie', year: '2023');
        cubit.setSearchMode(true);
        cubit.incrementPage();
        cubit.setSearchResults([
          MovieSearchItemEntity(
            title: 'Test Movie',
            year: '2023',
            imdbID: 'tt123456',
            type: 'movie',
            poster: 'test.jpg',
          ),
        ]);
        
        cubit.clearAll();
        
        expect(cubit.state.selectedType, '');
        expect(cubit.state.selectedYear, '');
        expect(cubit.state.hasSearched, false);
        expect(cubit.state.currentPage, 1);
        expect(cubit.state.isFetchingMore, false);
        expect(cubit.state.searchResults, isEmpty);
        expect(cubit.state.popularResults, <String, List<MovieSearchItemEntity>>{
          'Popular Movies': <MovieSearchItemEntity>[],
          'New Releases': <MovieSearchItemEntity>[],
        });
      });
    });
  });
} 