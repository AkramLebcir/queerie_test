abstract class MovieSearchEvent {}

class MovieSearchQueryChanged extends MovieSearchEvent {
  final String query;
  final String? type;
  final String? year;
  final String? plot;
  final bool? tomatoes;
  final int? page;
  final bool append;
  MovieSearchQueryChanged(this.query, {this.type, this.year, this.plot, this.tomatoes, this.page, this.append = false});
}

class MovieSearchCleared extends MovieSearchEvent {} 