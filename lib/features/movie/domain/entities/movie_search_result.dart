class MovieSearchItemEntity {
  final String title;
  final String year;
  final String imdbID;
  final String type;
  final String poster;

  MovieSearchItemEntity({
    required this.title,
    required this.year,
    required this.imdbID,
    required this.type,
    required this.poster,
  });
}

class MovieSearchResultEntity {
  final List<MovieSearchItemEntity> search;
  final String totalResults;
  final String response;
  final String? error;

  MovieSearchResultEntity({
    required this.search,
    required this.totalResults,
    required this.response,
    this.error,
  });
} 