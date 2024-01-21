// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_quiz.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DailyQuiz _$DailyQuizFromJson(Map<String, dynamic> json) {
  return _DailyQuiz.fromJson(json);
}

/// @nodoc
mixin _$DailyQuiz {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get scheduledFor => throw _privateConstructorUsedError;
  List<String> get options => throw _privateConstructorUsedError;
  String get question => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DailyQuizCopyWith<DailyQuiz> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyQuizCopyWith<$Res> {
  factory $DailyQuizCopyWith(DailyQuiz value, $Res Function(DailyQuiz) then) =
      _$DailyQuizCopyWithImpl<$Res, DailyQuiz>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String scheduledFor,
      List<String> options,
      String question});
}

/// @nodoc
class _$DailyQuizCopyWithImpl<$Res, $Val extends DailyQuiz>
    implements $DailyQuizCopyWith<$Res> {
  _$DailyQuizCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? scheduledFor = null,
    Object? options = null,
    Object? question = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      scheduledFor: null == scheduledFor
          ? _value.scheduledFor
          : scheduledFor // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<String>,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyQuizImplCopyWith<$Res>
    implements $DailyQuizCopyWith<$Res> {
  factory _$$DailyQuizImplCopyWith(
          _$DailyQuizImpl value, $Res Function(_$DailyQuizImpl) then) =
      __$$DailyQuizImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String scheduledFor,
      List<String> options,
      String question});
}

/// @nodoc
class __$$DailyQuizImplCopyWithImpl<$Res>
    extends _$DailyQuizCopyWithImpl<$Res, _$DailyQuizImpl>
    implements _$$DailyQuizImplCopyWith<$Res> {
  __$$DailyQuizImplCopyWithImpl(
      _$DailyQuizImpl _value, $Res Function(_$DailyQuizImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? scheduledFor = null,
    Object? options = null,
    Object? question = null,
  }) {
    return _then(_$DailyQuizImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      scheduledFor: null == scheduledFor
          ? _value.scheduledFor
          : scheduledFor // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<String>,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyQuizImpl extends _DailyQuiz {
  const _$DailyQuizImpl(
      {@JsonKey(name: '_id') this.id = '',
      this.scheduledFor = '2000-01-01',
      final List<String> options = const [],
      this.question = ''})
      : _options = options,
        super._();

  factory _$DailyQuizImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyQuizImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  @JsonKey()
  final String scheduledFor;
  final List<String> _options;
  @override
  @JsonKey()
  List<String> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  @JsonKey()
  final String question;

  @override
  String toString() {
    return 'DailyQuiz(id: $id, scheduledFor: $scheduledFor, options: $options, question: $question)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyQuizImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.scheduledFor, scheduledFor) ||
                other.scheduledFor == scheduledFor) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.question, question) ||
                other.question == question));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, scheduledFor,
      const DeepCollectionEquality().hash(_options), question);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyQuizImplCopyWith<_$DailyQuizImpl> get copyWith =>
      __$$DailyQuizImplCopyWithImpl<_$DailyQuizImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyQuizImplToJson(
      this,
    );
  }
}

abstract class _DailyQuiz extends DailyQuiz {
  const factory _DailyQuiz(
      {@JsonKey(name: '_id') final String id,
      final String scheduledFor,
      final List<String> options,
      final String question}) = _$DailyQuizImpl;
  const _DailyQuiz._() : super._();

  factory _DailyQuiz.fromJson(Map<String, dynamic> json) =
      _$DailyQuizImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get scheduledFor;
  @override
  List<String> get options;
  @override
  String get question;
  @override
  @JsonKey(ignore: true)
  _$$DailyQuizImplCopyWith<_$DailyQuizImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
