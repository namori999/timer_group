// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TimerGroup _$$_TimerGroupFromJson(Map<String, dynamic> json) =>
    _$_TimerGroup(
      id: json['id'] as int?,
      title: json['title'] as String,
      description: json['description'] as String?,
      options: json['options'] == null
          ? null
          : TimerGroupOptions.fromJson(json['options'] as Map<String, dynamic>),
      timers: (json['timers'] as List<dynamic>?)
          ?.map((e) => Timer.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalTime: json['totalTime'] as String?,
    );

Map<String, dynamic> _$$_TimerGroupToJson(_$_TimerGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'options': instance.options,
      'timers': instance.timers,
      'totalTime': instance.totalTime,
    };
