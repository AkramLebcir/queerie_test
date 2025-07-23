import 'package:get_it/get_it.dart';
import 'package:queerie_test/core/core.dart';
import 'package:queerie_test/features/features.dart';
import 'package:queerie_test/utils/utils.dart';

GetIt sl = GetIt.instance;

Future<void> serviceLocator({
  bool isUnitTest = false,
  bool isHiveEnable = true,
  String prefixBox = '',
}) async {
  /// For unit testing only
  if (isUnitTest) {
    await sl.reset();
  }
  sl.registerSingleton<DioClient>(DioClient(isUnitTest: isUnitTest));
  _dataSources();
  _repositories();
  _useCase();
  _cubit();
  _bloc();
  if (isHiveEnable) {
    await _initHiveBoxes(
      isUnitTest: isUnitTest,
      prefixBox: prefixBox,
    );
  }
}

Future<void> _initHiveBoxes({
  bool isUnitTest = false,
  String prefixBox = '',
}) async {
  await MainBoxMixin.initHive(prefixBox);
  sl.registerSingleton<MainBoxMixin>(MainBoxMixin());
}

/// Register repositories
void _repositories() {
  sl.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(sl<MovieRemoteDatasource>()));
}

/// Register dataSources
void _dataSources() {
  sl.registerLazySingleton<MovieRemoteDatasource>(
        () => MovieRemoteDatasourceImpl(sl<DioClient>()),
  );
}

void _useCase() {
  /// Movie
  sl.registerLazySingleton(() => SearchMovies(sl()));
  sl.registerLazySingleton(() => GetMovieDetail(sl()));
}

void _cubit() {
  /// General
  sl.registerFactory(() => SettingsCubit());
  sl.registerFactory(() => MainCubit());
  /// Movie
  sl.registerFactory(() => DashboardCubit());
}

void _bloc(){
  /// Movie
  sl.registerFactory(() => MovieSearchBloc(sl()));
}
