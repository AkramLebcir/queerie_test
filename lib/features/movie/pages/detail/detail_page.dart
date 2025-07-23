import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:queerie_test/core/core.dart';
import 'package:queerie_test/features/movie/movie.dart';
import '../widgets/widgets.dart';

class MovieDetailPage extends StatefulWidget {
  final String imdbID;
  final GetMovieDetail getMovieDetail;

  const MovieDetailPage({
    super.key,
    required this.imdbID,
    required this.getMovieDetail,
  });

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  int _reloadCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Either<Failure, MovieDetailEntity>>(
        key: ValueKey(_reloadCount),
        future: widget.getMovieDetail(widget.imdbID),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          }

          return snapshot.data!.fold(
            (failure) => Center(
              child: MovieEmptyState(
                message: failure is ServerFailure ? failure.message ?? 'Error' : 'Error',
                onRetry: () {
                  setState(() {
                    _reloadCount++;
                  });
                },
              ),
            ),
            (movie) => CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 300,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: MoviePosterHero(
                      posterUrl: movie.poster,
                      heroPosterTag: 'poster_${widget.imdbID}',
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MovieTitleHero(
                          title: movie.title,
                          heroTitleTag: 'title_${widget.imdbID}',
                        ),
                        const SpacerV(value: 16),
                        MovieRatingRow(
                          imdbRating: movie.imdbRating,
                          imdbVotes: movie.imdbVotes,
                        ),
                        const SpacerV(value: 16),
                        MovieInfoChips(
                          rated: movie.rated,
                          runtime: movie.runtime,
                          genre: movie.genre,
                        ),
                        const SpacerV(value: 24),
                        MovieDetailInfo(
                          plot: movie.plot,
                          director: movie.director,
                          writer: movie.writer,
                          actors: movie.actors,
                          released: movie.released,
                          awards: movie.awards,
                          boxOffice: movie.boxOffice,
                          production: movie.production,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
} 