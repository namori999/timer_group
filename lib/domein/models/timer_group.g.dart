// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TimerGroup _$$_TimerGroupFromJson(Map<String, dynamic> json) =>
    _$_TimerGroup(
      title: json['title'] as String,
      description: json['description'] as String?,
      options: json['options'] == null
          ? null
          : TimerGroupOptions.fromJson(json['options'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_TimerGroupToJson(_$_TimerGroup instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'options': instance.options,
    };
