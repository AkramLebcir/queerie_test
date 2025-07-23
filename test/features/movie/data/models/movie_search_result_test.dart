import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:queerie_test/features/movie/data/models/movie_search_result.dart';
import '../../../../helpers/json_reader.dart';
import '../../../../helpers/paths.dart';

void main() {
  test('MovieSearchResult parses from JSON', () {
    final jsonMap = json.decode(jsonReader(movieSearchResultPath)) as Map<String, dynamic>;
    final result = MovieSearchResult.fromJson(jsonMap);
    expect(result.search.length, 2);
    expect(result.search.first.title, 'The Matrix');
    expect(result.response, 'True');
  });
} 