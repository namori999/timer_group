import 'package:freezed_annotation/freezed_annotation.dart';

part 'timer_group_options.freezed.dart';

part 'timer_group_options.g.dart';

@freezed
class TimerGroupOptions with _$TimerGroupOptions {
  const TimerGroupOptions._();

  factory TimerGroupOptions({
    required int id,
    TimeFormat? timeFormat,
    String? overTime,
  }) = _TimerGroupOptions;

  formatText<String> (TimeFormat timeFormat) =>
      timeFormat.name == TimeFormat.hourMinute ? '時分' : '分秒';

  factory TimerGroupOptions.fromJson(Map<String, dynamic> json) =>
      _$TimerGroupOptionsFromJson(json);
}

enum TimeFormat {
  hourMinute,
  minuteSecond,
}
