import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:queerie_test/features/movie/pages/dashboard/dashboard_page.dart';
import 'package:queerie_test/features/movie/pages/dashboard/bloc/movie_search_bloc.dart';
import 'package:queerie_test/features/movie/domain/entities/movie_search_result.dart';
import '../../../../helpers/root_widget.dart';
import '../../../../helpers/mocks.mocks.dart';

void main() {
  testWidgets('MovieDashboardPage renders', (tester) async {
    final mockSearchMovies = MockSearchMovies();
    when(mockSearchMovies.call(
      any,
      page: anyNamed('page'),
      type: anyNamed('type'),
      year: anyNamed('year'),
    )).thenAnswer((_) async => Right(MovieSearchResultEntity(
      search: [],
      totalResults: '0',
      response: 'True',
      error: null,
    )));
    await tester.pumpWidget(
      rootWidget(
        BlocProvider<MovieSearchBloc>(
          create: (_) => MovieSearchBloc(mockSearchMovies),
          child: const MovieDashboardPage(),
        ),
      ),
    );
    expect(find.byType(MovieDashboardPage), findsOneWidget);
  });
} 