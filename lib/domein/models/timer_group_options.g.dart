// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_group_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TimerGroupOptions _$$_TimerGroupOptionsFromJson(Map<String, dynamic> json) =>
    _$_TimerGroupOptions(
      id: json['id'] as int,
      title: json['title'] as String,
      timeFormat: $enumDecodeNullable(_$TimeFormatEnumMap, json['timeFormat']),
      overTime: json['overTime'] as String?,
    );

Map<String, dynamic> _$$_TimerGroupOptionsToJson(
        _$_TimerGroupOptions instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'timeFormat': _$TimeFormatEnumMap[instance.timeFormat],
      'overTime': instance.overTime,
    };

const _$TimeFormatEnumMap = {
  TimeFormat.hourMinute: 'hourMinute',
  TimeFormat.minuteSecond: 'minuteSecond',
};
