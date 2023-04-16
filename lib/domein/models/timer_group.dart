import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:timer_group/domein/models/timer.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';

part 'timer_group.freezed.dart';

part 'timer_group.g.dart';

@freezed
class TimerGroup with _$TimerGroup {
  const TimerGroup._();
  @JsonSerializable(explicitToJson: true)
  factory TimerGroup({
    int? id,
    required String title,
    String? description,
    TimerGroupOptions? options,
    List<Timer>? timers,
    int? totalTime,
  }) = _TimerGroup;

  factory TimerGroup.fromJson(Map<String, dynamic> json) =>
      _$TimerGroupFromJson(json);
}
