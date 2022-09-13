import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';

part 'timer_group.freezed.dart';
part 'timer_group.g.dart';

@freezed
class TimerGroup with _$TimerGroup {
  const TimerGroup._();

  factory TimerGroup({
    required String title,
    String? description,
    TimerGroupOptions? options,
  }) = _TimerGroup;

  factory TimerGroup.fromJson(Map<String, dynamic> json) =>
      _$TimerGroupFromJson(json);
}