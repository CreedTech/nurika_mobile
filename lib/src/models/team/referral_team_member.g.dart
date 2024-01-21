// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'referral_team_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReferralTeamMemberImpl _$$ReferralTeamMemberImplFromJson(
        Map<String, dynamic> json) =>
    _$ReferralTeamMemberImpl(
      profileImage: json['profileImage'] as String? ?? '',
      firstName: json['firstName'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
    );

Map<String, dynamic> _$$ReferralTeamMemberImplToJson(
        _$ReferralTeamMemberImpl instance) =>
    <String, dynamic>{
      'profileImage': instance.profileImage,
      'firstName': instance.firstName,
      'createdAt': instance.createdAt,
    };
