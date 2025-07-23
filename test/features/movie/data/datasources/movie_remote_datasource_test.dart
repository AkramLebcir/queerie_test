import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:queerie_test/features/movie/data/models/movie_search_result.dart';
import 'package:queerie_test/features/movie/data/models/movie_detail.dart';
import '../../../../helpers/json_reader.dart';
import '../../../../helpers/paths.dart';

void main() {
  test('should parse movie search result from stub', () async {
    final jsonMap = json.decode(jsonReader(movieSearchResultPath)) as Map<String, dynamic>;
    final result = MovieSearchResult.fromJson(jsonMap);
    expect(result.search.isNotEmpty, true);
    expect(result.search.first.title, 'The Matrix');
  });

  test('should parse movie detail from stub', () async {
    final jsonMap = json.decode(jsonReader(movieDetailPath)) as Map<String, dynamic>;
    final result = MovieDetail.fromJson(jsonMap);
    expect(result.title, 'The Matrix');
    expect(result.imdbID, 'tt0133093');
  });
} 