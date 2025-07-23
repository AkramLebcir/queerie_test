class MovieSearchItem {
  final String title;
  final String year;
  final String imdbID;
  final String type;
  final String poster;

  MovieSearchItem({
    required this.title,
    required this.year,
    required this.imdbID,
    required this.type,
    required this.poster,
  });

  factory MovieSearchItem.fromJson(Map<String, dynamic> json) => MovieSearchItem(
        title: json['Title'] ?? '',
        year: json['Year'] ?? '',
        imdbID: json['imdbID'] ?? '',
        type: json['Type'] ?? '',
        poster: json['Poster'] ?? '',
      );
}

class MovieSearchResult {
  final List<MovieSearchItem> search;
  final String totalResults;
  final String response;
  final String? error;

  MovieSearchResult({
    required this.search,
    required this.totalResults,
    required this.response,
    this.error,
  });

  factory MovieSearchResult.fromJson(Map<String, dynamic> json) => MovieSearchResult(
        search: (json['Search'] as List?)?.map((e) => MovieSearchItem.fromJson(e)).toList() ?? [],
        totalResults: json['totalResults']?.toString() ?? '0',
        response: json['Response'] ?? 'False',
        error: json['Error'],
      );
} 