// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmailEntityImpl _$$EmailEntityImplFromJson(Map<String, dynamic> json) =>
    _$EmailEntityImpl(
      role: json['role'] as String,
      type: json['type'] as String,
      subject: json['subject'] as String,
      text: json['text'] as String,
    );

Map<String, dynamic> _$$EmailEntityImplToJson(_$EmailEntityImpl instance) =>
    <String, dynamic>{
      'role': instance.role,
      'type': instance.type,
      'subject': instance.subject,
      'text': instance.text,
    };
