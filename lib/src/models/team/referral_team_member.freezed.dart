// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'referral_team_member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ReferralTeamMember _$ReferralTeamMemberFromJson(Map<String, dynamic> json) {
  return _ReferralTeamMember.fromJson(json);
}

/// @nodoc
mixin _$ReferralTeamMember {
  String get profileImage => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReferralTeamMemberCopyWith<ReferralTeamMember> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReferralTeamMemberCopyWith<$Res> {
  factory $ReferralTeamMemberCopyWith(
          ReferralTeamMember value, $Res Function(ReferralTeamMember) then) =
      _$ReferralTeamMemberCopyWithImpl<$Res, ReferralTeamMember>;
  @useResult
  $Res call({String profileImage, String firstName, String createdAt});
}

/// @nodoc
class _$ReferralTeamMemberCopyWithImpl<$Res, $Val extends ReferralTeamMember>
    implements $ReferralTeamMemberCopyWith<$Res> {
  _$ReferralTeamMemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profileImage = null,
    Object? firstName = null,
    Object? createdAt = null,
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
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReferralTeamMemberImplCopyWith<$Res>
    implements $ReferralTeamMemberCopyWith<$Res> {
  factory _$$ReferralTeamMemberImplCopyWith(_$ReferralTeamMemberImpl value,
          $Res Function(_$ReferralTeamMemberImpl) then) =
      __$$ReferralTeamMemberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String profileImage, String firstName, String createdAt});
}

/// @nodoc
class __$$ReferralTeamMemberImplCopyWithImpl<$Res>
    extends _$ReferralTeamMemberCopyWithImpl<$Res, _$ReferralTeamMemberImpl>
    implements _$$ReferralTeamMemberImplCopyWith<$Res> {
  __$$ReferralTeamMemberImplCopyWithImpl(_$ReferralTeamMemberImpl _value,
      $Res Function(_$ReferralTeamMemberImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profileImage = null,
    Object? firstName = null,
    Object? createdAt = null,
  }) {
    return _then(_$ReferralTeamMemberImpl(
      profileImage: null == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReferralTeamMemberImpl extends _ReferralTeamMember {
  const _$ReferralTeamMemberImpl(
      {this.profileImage = '', this.firstName = '', this.createdAt = ''})
      : super._();

  factory _$ReferralTeamMemberImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReferralTeamMemberImplFromJson(json);

  @override
  @JsonKey()
  final String profileImage;
  @override
  @JsonKey()
  final String firstName;
  @override
  @JsonKey()
  final String createdAt;

  @override
  String toString() {
    return 'ReferralTeamMember(profileImage: $profileImage, firstName: $firstName, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReferralTeamMemberImpl &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, profileImage, firstName, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReferralTeamMemberImplCopyWith<_$ReferralTeamMemberImpl> get copyWith =>
      __$$ReferralTeamMemberImplCopyWithImpl<_$ReferralTeamMemberImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReferralTeamMemberImplToJson(
      this,
    );
  }
}

abstract class _ReferralTeamMember extends ReferralTeamMember {
  const factory _ReferralTeamMember(
      {final String profileImage,
      final String firstName,
      final String createdAt}) = _$ReferralTeamMemberImpl;
  const _ReferralTeamMember._() : super._();

  factory _ReferralTeamMember.fromJson(Map<String, dynamic> json) =
      _$ReferralTeamMemberImpl.fromJson;

  @override
  String get profileImage;
  @override
  String get firstName;
  @override
  String get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$ReferralTeamMemberImplCopyWith<_$ReferralTeamMemberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
