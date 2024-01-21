// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leaderboard_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LeaderboardUser _$LeaderboardUserFromJson(Map<String, dynamic> json) {
  return _LeaderboardUser.fromJson(json);
}

/// @nodoc
mixin _$LeaderboardUser {
  String get profileImage => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LeaderboardUserCopyWith<LeaderboardUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaderboardUserCopyWith<$Res> {
  factory $LeaderboardUserCopyWith(
          LeaderboardUser value, $Res Function(LeaderboardUser) then) =
      _$LeaderboardUserCopyWithImpl<$Res, LeaderboardUser>;
  @useResult
  $Res call({String profileImage, String firstName, String userId, int points});
}

/// @nodoc
class _$LeaderboardUserCopyWithImpl<$Res, $Val extends LeaderboardUser>
    implements $LeaderboardUserCopyWith<$Res> {
  _$LeaderboardUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profileImage = null,
    Object? firstName = null,
    Object? userId = null,
    Object? points = null,
  }) {
    return _then(_value.copyWith(
      profileImage: null == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LeaderboardUserImplCopyWith<$Res>
    implements $LeaderboardUserCopyWith<$Res> {
  factory _$$LeaderboardUserImplCopyWith(_$LeaderboardUserImpl value,
          $Res Function(_$LeaderboardUserImpl) then) =
      __$$LeaderboardUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String profileImage, String firstName, String userId, int points});
}

/// @nodoc
class __$$LeaderboardUserImplCopyWithImpl<$Res>
    extends _$LeaderboardUserCopyWithImpl<$Res, _$LeaderboardUserImpl>
    implements _$$LeaderboardUserImplCopyWith<$Res> {
  __$$LeaderboardUserImplCopyWithImpl(
      _$LeaderboardUserImpl _value, $Res Function(_$LeaderboardUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profileImage = null,
    Object? firstName = null,
    Object? userId = null,
    Object? points = null,
  }) {
    return _then(_$LeaderboardUserImpl(
      profileImage: null == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaderboardUserImpl implements _LeaderboardUser {
  const _$LeaderboardUserImpl(
      {this.profileImage = '',
      this.firstName = '',
      this.userId = '',
      this.points = 0});

  factory _$LeaderboardUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaderboardUserImplFromJson(json);

  @override
  @JsonKey()
  final String profileImage;
  @override
  @JsonKey()
  final String firstName;
  @override
  @JsonKey()
  final String userId;
  @override
  @JsonKey()
  final int points;

  @override
  String toString() {
    return 'LeaderboardUser(profileImage: $profileImage, firstName: $firstName, userId: $userId, points: $points)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaderboardUserImpl &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.points, points) || other.points == points));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, profileImage, firstName, userId, points);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaderboardUserImplCopyWith<_$LeaderboardUserImpl> get copyWith =>
      __$$LeaderboardUserImplCopyWithImpl<_$LeaderboardUserImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaderboardUserImplToJson(
      this,
    );
  }
}

abstract class _LeaderboardUser implements LeaderboardUser {
  const factory _LeaderboardUser(
      {final String profileImage,
      final String firstName,
      final String userId,
      final int points}) = _$LeaderboardUserImpl;

  factory _LeaderboardUser.fromJson(Map<String, dynamic> json) =
      _$LeaderboardUserImpl.fromJson;

  @override
  String get profileImage;
  @override
  String get firstName;
  @override
  String get userId;
  @override
  int get points;
  @override
  @JsonKey(ignore: true)
  _$$LeaderboardUserImplCopyWith<_$LeaderboardUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
