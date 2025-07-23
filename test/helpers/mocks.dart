import 'package:flutter/widgets.dart';
import 'package:mockito/annotations.dart';
import 'package:queerie_test/features/movie/data/datasources/movie_remote_datasource.dart';
import 'package:queerie_test/features/movie/domain/repositories/movie_repository.dart';
import 'package:queerie_test/features/movie/domain/usecases/search_movies.dart';

@GenerateMocks([
  MovieRemoteDatasource,
  MovieRepository,
  SearchMovies,
])
@GenerateNiceMocks([MockSpec<BuildContext>()])
void main() {} 