import 'package:freezed_annotation/freezed_annotation.dart';

part 'timer.freezed.dart';
part 'timer.g.dart';

@freezed
class Timer with _$Timer {
  const Timer._();

  factory Timer({
    int? id,
    required int index,
    required int time,
    required String soundPath,
    required String bgmPath,
    required String notification,
  }) = _Timer;

  factory Timer.fromJson(Map<String, dynamic> json) =>
      _$TimerFromJson(json);
}