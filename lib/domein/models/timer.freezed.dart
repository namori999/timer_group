// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Timer _$TimerFromJson(Map<String, dynamic> json) {
  return _Timer.fromJson(json);
}

/// @nodoc
mixin _$Timer {
  int get groupId => throw _privateConstructorUsedError;
  int get number => throw _privateConstructorUsedError;
  int get time => throw _privateConstructorUsedError; // timeはぜんぶ 秒 で管理
  Sound get alarm => throw _privateConstructorUsedError;
  Sound get bgm => throw _privateConstructorUsedError;
  String get imagePath => throw _privateConstructorUsedError;
  int get notification => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TimerCopyWith<Timer> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimerCopyWith<$Res> {
  factory $TimerCopyWith(Timer value, $Res Function(Timer) then) =
      _$TimerCopyWithImpl<$Res, Timer>;
  @useResult
  $Res call(
      {int groupId,
      int number,
      int time,
      Sound alarm,
      Sound bgm,
      String imagePath,
      int notification});

  $SoundCopyWith<$Res> get alarm;
  $SoundCopyWith<$Res> get bgm;
}

/// @nodoc
class _$TimerCopyWithImpl<$Res, $Val extends Timer>
    implements $TimerCopyWith<$Res> {
  _$TimerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupId = null,
    Object? number = null,
    Object? time = null,
    Object? alarm = null,
    Object? bgm = null,
    Object? imagePath = null,
    Object? notification = null,
  }) {
    return _then(_value.copyWith(
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as int,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
      alarm: null == alarm
          ? _value.alarm
          : alarm // ignore: cast_nullable_to_non_nullable
              as Sound,
      bgm: null == bgm
          ? _value.bgm
          : bgm // ignore: cast_nullable_to_non_nullable
              as Sound,
      imagePath: null == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String,
      notification: null == notification
          ? _value.notification
          : notification // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SoundCopyWith<$Res> get alarm {
    return $SoundCopyWith<$Res>(_value.alarm, (value) {
      return _then(_value.copyWith(alarm: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SoundCopyWith<$Res> get bgm {
    return $SoundCopyWith<$Res>(_value.bgm, (value) {
      return _then(_value.copyWith(bgm: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_TimerCopyWith<$Res> implements $TimerCopyWith<$Res> {
  factory _$$_TimerCopyWith(_$_Timer value, $Res Function(_$_Timer) then) =
      __$$_TimerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int groupId,
      int number,
      int time,
      Sound alarm,
      Sound bgm,
      String imagePath,
      int notification});

  @override
  $SoundCopyWith<$Res> get alarm;
  @override
  $SoundCopyWith<$Res> get bgm;
}

/// @nodoc
class __$$_TimerCopyWithImpl<$Res> extends _$TimerCopyWithImpl<$Res, _$_Timer>
    implements _$$_TimerCopyWith<$Res> {
  __$$_TimerCopyWithImpl(_$_Timer _value, $Res Function(_$_Timer) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupId = null,
    Object? number = null,
    Object? time = null,
    Object? alarm = null,
    Object? bgm = null,
    Object? imagePath = null,
    Object? notification = null,
  }) {
    return _then(_$_Timer(
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as int,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
      alarm: null == alarm
          ? _value.alarm
          : alarm // ignore: cast_nullable_to_non_nullable
              as Sound,
      bgm: null == bgm
          ? _value.bgm
          : bgm // ignore: cast_nullable_to_non_nullable
              as Sound,
      imagePath: null == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String,
      notification: null == notification
          ? _value.notification
          : notification // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Timer extends _Timer {
  _$_Timer(
      {required this.groupId,
      required this.number,
      required this.time,
      required this.alarm,
      required this.bgm,
      required this.imagePath,
      required this.notification})
      : super._();

  factory _$_Timer.fromJson(Map<String, dynamic> json) =>
      _$$_TimerFromJson(json);

  @override
  final int groupId;
  @override
  final int number;
  @override
  final int time;
// timeはぜんぶ 秒 で管理
  @override
  final Sound alarm;
  @override
  final Sound bgm;
  @override
  final String imagePath;
  @override
  final int notification;

  @override
  String toString() {
    return 'Timer(groupId: $groupId, number: $number, time: $time, alarm: $alarm, bgm: $bgm, imagePath: $imagePath, notification: $notification)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Timer &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.alarm, alarm) || other.alarm == alarm) &&
            (identical(other.bgm, bgm) || other.bgm == bgm) &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath) &&
            (identical(other.notification, notification) ||
                other.notification == notification));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, groupId, number, time, alarm, bgm, imagePath, notification);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TimerCopyWith<_$_Timer> get copyWith =>
      __$$_TimerCopyWithImpl<_$_Timer>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TimerToJson(
      this,
    );
  }
}

abstract class _Timer extends Timer {
  factory _Timer(
      {required final int groupId,
      required final int number,
      required final int time,
      required final Sound alarm,
      required final Sound bgm,
      required final String imagePath,
      required final int notification}) = _$_Timer;
  _Timer._() : super._();

  factory _Timer.fromJson(Map<String, dynamic> json) = _$_Timer.fromJson;

  @override
  int get groupId;
  @override
  int get number;
  @override
  int get time;
  @override // timeはぜんぶ 秒 で管理
  Sound get alarm;
  @override
  Sound get bgm;
  @override
  String get imagePath;
  @override
  int get notification;
  @override
  @JsonKey(ignore: true)
  _$$_TimerCopyWith<_$_Timer> get copyWith =>
      throw _privateConstructorUsedError;
}
