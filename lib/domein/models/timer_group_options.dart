import 'package:freezed_annotation/freezed_annotation.dart';

part 'timer_group_options.freezed.dart';
part 'timer_group_options.g.dart';

@freezed
class TimerGroupOptions with _$TimerGroupOptions {
  const TimerGroupOptions._();

  factory TimerGroupOptions({
    required int id,
    required String title,
    TimeFormat? timeFormat,
    String? overTime,
  }) = _TimerGroupOptions;

  factory TimerGroupOptions.fromJson(Map<String, dynamic> json) =>
      _$TimerGroupOptionsFromJson(json);
}

enum TimeFormat {
  hourMinute,
  minuteSecond,
}
