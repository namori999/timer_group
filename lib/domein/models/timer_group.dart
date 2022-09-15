import 'package:freezed_annotation/freezed_annotation.dart';

part 'timer_group.freezed.dart';
part 'timer_group.g.dart';

@freezed
class TimerGroup with _$TimerGroup {
  const TimerGroup._();

  factory TimerGroup({
    int? id,
    required String title,
    String? description,
  }) = _TimerGroup;

  factory TimerGroup.fromJson(Map<String, dynamic> json) =>
      _$TimerGroupFromJson(json);
}