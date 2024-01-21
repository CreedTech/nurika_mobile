// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeaderboardUserImpl _$$LeaderboardUserImplFromJson(
        Map<String, dynamic> json) =>
    _$LeaderboardUserImpl(
      profileImage: json['profileImage'] as String? ?? '',
      firstName: json['firstName'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      points: json['points'] as int? ?? 0,
    );

Map<String, dynamic> _$$LeaderboardUserImplToJson(
        _$LeaderboardUserImpl instance) =>
    <String, dynamic>{
      'profileImage': instance.profileImage,
      'firstName': instance.firstName,
      'userId': instance.userId,
      'points': instance.points,
    };
