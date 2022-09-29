import 'package:freezed_annotation/freezed_annotation.dart';

part 'timer.freezed.dart';
part 'timer.g.dart';

@freezed
class Timer with _$Timer {
  const Timer._();

  factory Timer({
    int? id,
    required int number,
    required int time,// timeはぜんぶ 秒 で管理
    required String soundPath,
    required String bgmPath,
    required String imagePath,
    required String notification,
  }) = _Timer;

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