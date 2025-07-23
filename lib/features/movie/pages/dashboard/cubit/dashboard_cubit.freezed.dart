// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DashboardState {
  String get selectedType => throw _privateConstructorUsedError;
  String get selectedYear => throw _privateConstructorUsedError;
  bool get hasSearched => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  bool get isFetchingMore => throw _privateConstructorUsedError;
  List<MovieSearchItemEntity> get searchResults =>
      throw _privateConstructorUsedError;
  Map<String, List<MovieSearchItemEntity>> get popularResults =>
      throw _privateConstructorUsedError;

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardStateCopyWith<DashboardState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardStateCopyWith<$Res> {
  factory $DashboardStateCopyWith(
          DashboardState value, $Res Function(DashboardState) then) =
      _$DashboardStateCopyWithImpl<$Res, DashboardState>;
  @useResult
  $Res call(
      {String selectedType,
      String selectedYear,
      bool hasSearched,
      int currentPage,
      bool isFetchingMore,
      List<MovieSearchItemEntity> searchResults,
      Map<String, List<MovieSearchItemEntity>> popularResults});
}

/// @nodoc
class _$DashboardStateCopyWithImpl<$Res, $Val extends DashboardState>
    implements $DashboardStateCopyWith<$Res> {
  _$DashboardStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedType = null,
    Object? selectedYear = null,
    Object? hasSearched = null,
    Object? currentPage = null,
    Object? isFetchingMore = null,
    Object? searchResults = null,
    Object? popularResults = null,
  }) {
    return _then(_value.copyWith(
      selectedType: null == selectedType
          ? _value.selectedType
          : selectedType // ignore: cast_nullable_to_non_nullable
              as String,
      selectedYear: null == selectedYear
          ? _value.selectedYear
          : selectedYear // ignore: cast_nullable_to_non_nullable
              as String,
      hasSearched: null == hasSearched
          ? _value.hasSearched
          : hasSearched // ignore: cast_nullable_to_non_nullable
              as bool,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      isFetchingMore: null == isFetchingMore
          ? _value.isFetchingMore
          : isFetchingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      searchResults: null == searchResults
          ? _value.searchResults
          : searchResults // ignore: cast_nullable_to_non_nullable
              as List<MovieSearchItemEntity>,
      popularResults: null == popularResults
          ? _value.popularResults
          : popularResults // ignore: cast_nullable_to_non_nullable
              as Map<String, List<MovieSearchItemEntity>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DashboardStateImplCopyWith<$Res>
    implements $DashboardStateCopyWith<$Res> {
  factory _$$DashboardStateImplCopyWith(_$DashboardStateImpl value,
          $Res Function(_$DashboardStateImpl) then) =
      __$$DashboardStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String selectedType,
      String selectedYear,
      bool hasSearched,
      int currentPage,
      bool isFetchingMore,
      List<MovieSearchItemEntity> searchResults,
      Map<String, List<MovieSearchItemEntity>> popularResults});
}

/// @nodoc
class __$$DashboardStateImplCopyWithImpl<$Res>
    extends _$DashboardStateCopyWithImpl<$Res, _$DashboardStateImpl>
    implements _$$DashboardStateImplCopyWith<$Res> {
  __$$DashboardStateImplCopyWithImpl(
      _$DashboardStateImpl _value, $Res Function(_$DashboardStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedType = null,
    Object? selectedYear = null,
    Object? hasSearched = null,
    Object? currentPage = null,
    Object? isFetchingMore = null,
    Object? searchResults = null,
    Object? popularResults = null,
  }) {
    return _then(_$DashboardStateImpl(
      selectedType: null == selectedType
          ? _value.selectedType
          : selectedType // ignore: cast_nullable_to_non_nullable
              as String,
      selectedYear: null == selectedYear
          ? _value.selectedYear
          : selectedYear // ignore: cast_nullable_to_non_nullable
              as String,
      hasSearched: null == hasSearched
          ? _value.hasSearched
          : hasSearched // ignore: cast_nullable_to_non_nullable
              as bool,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      isFetchingMore: null == isFetchingMore
          ? _value.isFetchingMore
          : isFetchingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      searchResults: null == searchResults
          ? _value._searchResults
          : searchResults // ignore: cast_nullable_to_non_nullable
              as List<MovieSearchItemEntity>,
      popularResults: null == popularResults
          ? _value._popularResults
          : popularResults // ignore: cast_nullable_to_non_nullable
              as Map<String, List<MovieSearchItemEntity>>,
    ));
  }
}

/// @nodoc

class _$DashboardStateImpl implements _DashboardState {
  const _$DashboardStateImpl(
      {this.selectedType = '',
      this.selectedYear = '',
      this.hasSearched = false,
      this.currentPage = 1,
      this.isFetchingMore = false,
      final List<MovieSearchItemEntity> searchResults = const [],
      final Map<String, List<MovieSearchItemEntity>> popularResults = const {
        'Popular Movies': <MovieSearchItemEntity>[],
        'New Releases': <MovieSearchItemEntity>[]
      }})
      : _searchResults = searchResults,
        _popularResults = popularResults;

  @override
  @JsonKey()
  final String selectedType;
  @override
  @JsonKey()
  final String selectedYear;
  @override
  @JsonKey()
  final bool hasSearched;
  @override
  @JsonKey()
  final int currentPage;
  @override
  @JsonKey()
  final bool isFetchingMore;
  final List<MovieSearchItemEntity> _searchResults;
  @override
  @JsonKey()
  List<MovieSearchItemEntity> get searchResults {
    if (_searchResults is EqualUnmodifiableListView) return _searchResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchResults);
  }

  final Map<String, List<MovieSearchItemEntity>> _popularResults;
  @override
  @JsonKey()
  Map<String, List<MovieSearchItemEntity>> get popularResults {
    if (_popularResults is EqualUnmodifiableMapView) return _popularResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_popularResults);
  }

  @override
  String toString() {
    return 'DashboardState(selectedType: $selectedType, selectedYear: $selectedYear, hasSearched: $hasSearched, currentPage: $currentPage, isFetchingMore: $isFetchingMore, searchResults: $searchResults, popularResults: $popularResults)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardStateImpl &&
            (identical(other.selectedType, selectedType) ||
                other.selectedType == selectedType) &&
            (identical(other.selectedYear, selectedYear) ||
                other.selectedYear == selectedYear) &&
            (identical(other.hasSearched, hasSearched) ||
                other.hasSearched == hasSearched) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.isFetchingMore, isFetchingMore) ||
                other.isFetchingMore == isFetchingMore) &&
            const DeepCollectionEquality()
                .equals(other._searchResults, _searchResults) &&
            const DeepCollectionEquality()
                .equals(other._popularResults, _popularResults));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      selectedType,
      selectedYear,
      hasSearched,
      currentPage,
      isFetchingMore,
      const DeepCollectionEquality().hash(_searchResults),
      const DeepCollectionEquality().hash(_popularResults));

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardStateImplCopyWith<_$DashboardStateImpl> get copyWith =>
      __$$DashboardStateImplCopyWithImpl<_$DashboardStateImpl>(
          this, _$identity);
}

abstract class _DashboardState implements DashboardState {
  const factory _DashboardState(
          {final String selectedType,
          final String selectedYear,
          final bool hasSearched,
          final int currentPage,
          final bool isFetchingMore,
          final List<MovieSearchItemEntity> searchResults,
          final Map<String, List<MovieSearchItemEntity>> popularResults}) =
      _$DashboardStateImpl;

  @override
  String get selectedType;
  @override
  String get selectedYear;
  @override
  bool get hasSearched;
  @override
  int get currentPage;
  @override
  bool get isFetchingMore;
  @override
  List<MovieSearchItemEntity> get searchResults;
  @override
  Map<String, List<MovieSearchItemEntity>> get popularResults;

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardStateImplCopyWith<_$DashboardStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
