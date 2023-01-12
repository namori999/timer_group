// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Timer _$$_TimerFromJson(Map<String, dynamic> json) => _$_Timer(
      groupId: json['groupId'] as int,
      number: json['number'] as int,
      time: json['time'] as int,
      soundPath: json['soundPath'] as String,
      bgmPath: json['bgmPath'] as String,
      imagePath: json['imagePath'] as String,
      notification: json['notification'] as String,
    );

Map<String, dynamic> _$$_TimerToJson(_$_Timer instance) => <String, dynamic>{
      'groupId': instance.groupId,
      'number': instance.number,
      'time': instance.time,
      'soundPath': instance.soundPath,
      'bgmPath': instance.bgmPath,
      'imagePath': instance.imagePath,
      'notification': instance.notification,
    };
