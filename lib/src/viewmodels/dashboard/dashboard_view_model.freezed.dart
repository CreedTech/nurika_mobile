// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DashboardState {
  DailyQuiz get dailyQuiz => throw _privateConstructorUsedError;
  bool get hasDoneDailyQuiz => throw _privateConstructorUsedError;
  int get stepCountToday => throw _privateConstructorUsedError;
  int get tabIndex => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
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
      {DailyQuiz dailyQuiz,
      bool hasDoneDailyQuiz,
      int stepCountToday,
      int tabIndex});

  $DailyQuizCopyWith<$Res> get dailyQuiz;
}

/// @nodoc
class _$DashboardStateCopyWithImpl<$Res, $Val extends DashboardState>
    implements $DashboardStateCopyWith<$Res> {
  _$DashboardStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dailyQuiz = null,
    Object? hasDoneDailyQuiz = null,
    Object? stepCountToday = null,
    Object? tabIndex = null,
  }) {
    return _then(_value.copyWith(
      dailyQuiz: null == dailyQuiz
          ? _value.dailyQuiz
          : dailyQuiz // ignore: cast_nullable_to_non_nullable
              as DailyQuiz,
      hasDoneDailyQuiz: null == hasDoneDailyQuiz
          ? _value.hasDoneDailyQuiz
          : hasDoneDailyQuiz // ignore: cast_nullable_to_non_nullable
              as bool,
      stepCountToday: null == stepCountToday
          ? _value.stepCountToday
          : stepCountToday // ignore: cast_nullable_to_non_nullable
              as int,
      tabIndex: null == tabIndex
          ? _value.tabIndex
          : tabIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DailyQuizCopyWith<$Res> get dailyQuiz {
    return $DailyQuizCopyWith<$Res>(_value.dailyQuiz, (value) {
      return _then(_value.copyWith(dailyQuiz: value) as $Val);
    });
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
      {DailyQuiz dailyQuiz,
      bool hasDoneDailyQuiz,
      int stepCountToday,
      int tabIndex});

  @override
  $DailyQuizCopyWith<$Res> get dailyQuiz;
}

/// @nodoc
class __$$DashboardStateImplCopyWithImpl<$Res>
    extends _$DashboardStateCopyWithImpl<$Res, _$DashboardStateImpl>
    implements _$$DashboardStateImplCopyWith<$Res> {
  __$$DashboardStateImplCopyWithImpl(
      _$DashboardStateImpl _value, $Res Function(_$DashboardStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dailyQuiz = null,
    Object? hasDoneDailyQuiz = null,
    Object? stepCountToday = null,
    Object? tabIndex = null,
  }) {
    return _then(_$DashboardStateImpl(
      dailyQuiz: null == dailyQuiz
          ? _value.dailyQuiz
          : dailyQuiz // ignore: cast_nullable_to_non_nullable
              as DailyQuiz,
      hasDoneDailyQuiz: null == hasDoneDailyQuiz
          ? _value.hasDoneDailyQuiz
          : hasDoneDailyQuiz // ignore: cast_nullable_to_non_nullable
              as bool,
      stepCountToday: null == stepCountToday
          ? _value.stepCountToday
          : stepCountToday // ignore: cast_nullable_to_non_nullable
              as int,
      tabIndex: null == tabIndex
          ? _value.tabIndex
          : tabIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$DashboardStateImpl implements _DashboardState {
  const _$DashboardStateImpl(
      {required this.dailyQuiz,
      required this.hasDoneDailyQuiz,
      required this.stepCountToday,
      required this.tabIndex});

  @override
  final DailyQuiz dailyQuiz;
  @override
  final bool hasDoneDailyQuiz;
  @override
  final int stepCountToday;
  @override
  final int tabIndex;

  @override
  String toString() {
    return 'DashboardState(dailyQuiz: $dailyQuiz, hasDoneDailyQuiz: $hasDoneDailyQuiz, stepCountToday: $stepCountToday, tabIndex: $tabIndex)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardStateImpl &&
            (identical(other.dailyQuiz, dailyQuiz) ||
                other.dailyQuiz == dailyQuiz) &&
            (identical(other.hasDoneDailyQuiz, hasDoneDailyQuiz) ||
                other.hasDoneDailyQuiz == hasDoneDailyQuiz) &&
            (identical(other.stepCountToday, stepCountToday) ||
                other.stepCountToday == stepCountToday) &&
            (identical(other.tabIndex, tabIndex) ||
                other.tabIndex == tabIndex));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, dailyQuiz, hasDoneDailyQuiz, stepCountToday, tabIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardStateImplCopyWith<_$DashboardStateImpl> get copyWith =>
      __$$DashboardStateImplCopyWithImpl<_$DashboardStateImpl>(
          this, _$identity);
}

abstract class _DashboardState implements DashboardState {
  const factory _DashboardState(
      {required final DailyQuiz dailyQuiz,
      required final bool hasDoneDailyQuiz,
      required final int stepCountToday,
      required final int tabIndex}) = _$DashboardStateImpl;

  @override
  DailyQuiz get dailyQuiz;
  @override
  bool get hasDoneDailyQuiz;
  @override
  int get stepCountToday;
  @override
  int get tabIndex;
  @override
  @JsonKey(ignore: true)
  _$$DashboardStateImplCopyWith<_$DashboardStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
