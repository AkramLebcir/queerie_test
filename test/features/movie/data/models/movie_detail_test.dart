import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:queerie_test/features/movie/data/models/movie_detail.dart';
import '../../../../helpers/json_reader.dart';
import '../../../../helpers/paths.dart';

void main() {
  test('MovieDetail parses from JSON', () {
    final jsonMap = json.decode(jsonReader(movieDetailPath)) as Map<String, dynamic>;
    final result = MovieDetail.fromJson(jsonMap);
    expect(result.title, 'The Matrix');
    expect(result.imdbID, 'tt0133093');
    expect(result.response, 'True');
  });
} 