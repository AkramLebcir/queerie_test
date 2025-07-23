import 'package:flutter/material.dart';
import '../../domain/entities/movie_search_result.dart';
import 'movie_card.dart';
import 'package:queerie_test/core/localization/generated/strings.dart';

class MoviePopularGrid extends StatelessWidget {
  final Map<String, List<MovieSearchItemEntity>> popularResults;
  final void Function(MovieSearchItemEntity movie) onCardTap;

  const MoviePopularGrid({super.key, required this.popularResults, required this.onCardTap});

  @override
  Widget build(BuildContext context) {
    if (popularResults.isEmpty || popularResults.values.every((list) => list.isEmpty)) {
      return Center(child: Text(Strings.of(context)!.noMoviesForFilters));
    }
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text('${Strings.of(context)!.popularMovies} & ${Strings.of(context)!.newReleases}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 12),
        ...popularResults.entries.map((entry) => _buildPopularSectionResponsive(context, entry.key, entry.value)),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildPopularSectionResponsive(BuildContext context, String title, List<MovieSearchItemEntity> movies) {
    if (movies.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(title == 'Popular Movies' ? Strings.of(context)!.popularMovies : Strings.of(context)!.newReleases, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = 2;
            double width = constraints.maxWidth;
            if (width > 900) {
              crossAxisCount = 5;
            } else if (width > 600) {
              crossAxisCount = 4;
            } else if (width > 400) {
              crossAxisCount = 3;
            }
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.62,
              ),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
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
          },
        ),
      ],
    );
  }
} 