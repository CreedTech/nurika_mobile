// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApiResponseImpl _$$ApiResponseImplFromJson(Map<String, dynamic> json) =>
    _$ApiResponseImpl(
      isNegative: json['error'] as bool? ?? false,
      isPositive: json['status'] as bool? ?? true,
      data: json['data'] ?? const {},
    );

Map<String, dynamic> _$$ApiResponseImplToJson(_$ApiResponseImpl instance) =>
    <String, dynamic>{
      'error': instance.isNegative,
      'status': instance.isPositive,
      'data': instance.data,
    };
