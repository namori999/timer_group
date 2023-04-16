import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:timer_group/domein/models/sound.dart';

part 'timer.freezed.dart';
part 'timer.g.dart';

@freezed
class Timer with _$Timer {
  const Timer._();
  @JsonSerializable(explicitToJson: true)
  factory Timer({
    required int groupId,
    required int number,
    required int time,// timeはぜんぶ 秒 で管理
    required Sound alarm,
    required Sound bgm,
    required String imagePath,
    required int notification,
    int? isOverTime,
  }) = _Timer;

  Map<String, dynamic> toMap() {
    return {
      'groupId': groupId,
      'number' : number,
      'time': time,
      'alarmName' : alarm.name,
      'alarmUrl' : alarm.url,
      'bgmName' : bgm.name,
      'bgmUrl' : bgm.url,
      'imagePath' : imagePath,
      'notification' : notification,
      'isOverTime' : isOverTime,
    };
  }

  factory Timer.fromJson(Map<String, dynamic> json) =>
      _$TimerFromJson(json);
}

enum AlarmSounds {
  sample,sample2,sample3
}

enum Musics {
  sample,sample2,sample3
}

enum BackGroundImages {
  sample,sample2
}