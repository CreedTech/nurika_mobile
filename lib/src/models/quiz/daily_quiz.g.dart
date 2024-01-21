// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_quiz.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailyQuizImpl _$$DailyQuizImplFromJson(Map<String, dynamic> json) =>
    _$DailyQuizImpl(
      id: json['_id'] as String? ?? '',
      scheduledFor: json['scheduledFor'] as String? ?? '2000-01-01',
      options: (json['options'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      question: json['question'] as String? ?? '',
    );

Map<String, dynamic> _$$DailyQuizImplToJson(_$DailyQuizImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'scheduledFor': instance.scheduledFor,
      'options': instance.options,
      'question': instance.question,
    };
