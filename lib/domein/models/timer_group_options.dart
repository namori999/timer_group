import 'package:freezed_annotation/freezed_annotation.dart';

part 'timer_group_options.freezed.dart';

@freezed
class TimerGroupOptions with _$TimerGroupOptions {
  const TimerGroupOptions._();

  factory TimerGroupOptions({
    required String timerGroupId,
    TimeFormat? timeFormat,
    bool? overTime,
  }) = _TimerGroupOptions;
}

enum TimeFormat {
  hourMinute,
  minuteSecond,
}
