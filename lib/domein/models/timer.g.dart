// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Timer _$$_TimerFromJson(Map<String, dynamic> json) => _$_Timer(
      id: json['id'] as int?,
      groupId: json['groupId'] as int,
      number: json['number'] as int,
      time: json['time'] as int,
      alarm: Sound(
        name:json['alarmName'] as String,
        url: json['alarmUrl'] as String,
      ),
      bgm: Sound(
            name: json['bgmName'] as String,
            url: json['bgmUrl'] as String,
      ),
      imagePath: json['imagePath'] as String,
      notification: json['notification'] as int,
    );

Map<String, dynamic> _$$_TimerToJson(_$_Timer instance) => <String, dynamic>{
      'id': instance.id,
      'groupId': instance.groupId,
      'number': instance.number,
      'time': instance.time,
      'alarm': instance.alarm,
      'bgm': instance.bgm,
      'imagePath': instance.imagePath,
      'notification': instance.notification,
    };
