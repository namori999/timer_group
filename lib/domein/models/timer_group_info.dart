import 'package:freezed_annotation/freezed_annotation.dart';

part 'timer_group_info.freezed.dart';
part 'timer_group_info.g.dart';

@freezed
class TimerGroupInfo with _$TimerGroupInfo {
  const TimerGroupInfo._();

  factory TimerGroupInfo({
    required String title,
    String? description,
  }) = _TimerGroupInfo;

  factory TimerGroupInfo.fromJson(Map<String, dynamic> json) =>
      _$TimerGroupInfoFromJson(json);
}

