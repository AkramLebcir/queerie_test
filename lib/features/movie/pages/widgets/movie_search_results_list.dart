import 'package:flutter/material.dart';
import 'package:queerie_test/features/movie/movie.dart';
import 'movie_card.dart';
import 'package:queerie_test/core/core.dart';

class MovieSearchResultsList extends StatelessWidget {
  final List<MovieSearchItemEntity> results;
  final bool isFetchingMore;
  final bool hasMoreResults;
  final ScrollController scrollController;
  final void Function(MovieSearchItemEntity movie) onCardTap;

  const MovieSearchResultsList({
    super.key,
    required this.results,
    required this.isFetchingMore,
    required this.hasMoreResults,
    required this.scrollController,
    required this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      itemCount: results.length + 1,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        if (index == results.length) {
          if (isFetchingMore) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (!hasMoreResults) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(child: Text(Strings.of(context)!.noMoreResults)),
            );
          } else {
            return const SizedBox.shrink();
          }
        }
        final movie = results[index];
        return MovieCard(
          title: movie.title,
          year: movie.year,
          posterUrl: movie.poster,
          type: movie.type,
          onTap: () => onCardTap(movie),
          heroPosterTag: 'poster_${movie.imdbID}',
          heroTitleTag: 'title_${movie.imdbID}',
        );
      },
    );
  }
} 