// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserImpl _$$AppUserImplFromJson(Map<String, dynamic> json) =>
    _$AppUserImpl(
      email: json['email'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      username: json['username'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      firstName: json['firstName'] as String? ?? '',
      referralId: json['referralId'] as String? ?? '',
      dateOfBirth: json['dateOfBirth'] as String? ?? '',
      profileImage: json['profileImage'] as String? ?? '',
      heightUnit: json['heightUnit'] as String? ?? 'cm',
      weightUnit: json['weightUnit'] as String? ?? 'kg',
      pointsRecord: (json['pointsRecord'] as List<dynamic>?)
              ?.map((e) => e as Map<String, dynamic>)
              .toList() ??
          const [],
      stepsRecord: (json['stepsRecord'] as List<dynamic>?)
              ?.map((e) => e as Map<String, dynamic>)
              .toList() ??
          const [],
      referrals: (json['referrals'] as List<dynamic>?)
              ?.map((e) => Map<String, String>.from(e as Map))
              .toList() ??
          const [],
      dailyStepsTarget: json['dailyStepsTarget'] as int? ?? 0,
      stepCountToday: json['stepCountToday'] as int? ?? 0,
      userTypeIndex: json['userTypeIndex'] as int? ?? 0,
      totalPoints: json['totalPoints'] as int? ?? 0,
      bodyHeight: json['bodyHeight'] as int? ?? 0,
      bodyWeight: json['bodyWeight'] as int? ?? 0,
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'userId': instance.userId,
      'gender': instance.gender,
      'username': instance.username,
      'lastName': instance.lastName,
      'firstName': instance.firstName,
      'referralId': instance.referralId,
      'dateOfBirth': instance.dateOfBirth,
      'profileImage': instance.profileImage,
      'heightUnit': instance.heightUnit,
      'weightUnit': instance.weightUnit,
      'pointsRecord': instance.pointsRecord,
      'stepsRecord': instance.stepsRecord,
      'referrals': instance.referrals,
      'dailyStepsTarget': instance.dailyStepsTarget,
      'stepCountToday': instance.stepCountToday,
      'userTypeIndex': instance.userTypeIndex,
      'totalPoints': instance.totalPoints,
      'bodyHeight': instance.bodyHeight,
      'bodyWeight': instance.bodyWeight,
    };
