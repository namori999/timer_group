// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Timer _$$_TimerFromJson(Map<String, dynamic> json) => _$_Timer(
      id: json['id'] as int?,
      index: json['index'] as int,
      time: json['time'] as int,
      soundPath: json['soundPath'] as String,
      bgmPath: json['bgmPath'] as String,
      notification: json['notification'] as String,
    );

Map<String, dynamic> _$$_TimerToJson(_$_Timer instance) => <String, dynamic>{
      'id': instance.id,
      'index': instance.index,
      'time': instance.time,
      'soundPath': instance.soundPath,
      'bgmPath': instance.bgmPath,
      'notification': instance.notification,
    };
