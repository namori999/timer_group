// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'timer_group_options.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TimerGroupOptions _$TimerGroupOptionsFromJson(Map<String, dynamic> json) {
  return _TimerGroupOptions.fromJson(json);
}

/// @nodoc
mixin _$TimerGroupOptions {
  int get timerGroupId => throw _privateConstructorUsedError;
  TimeFormat? get timeFormat => throw _privateConstructorUsedError;
  bool? get overTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TimerGroupOptionsCopyWith<TimerGroupOptions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimerGroupOptionsCopyWith<$Res> {
  factory $TimerGroupOptionsCopyWith(
          TimerGroupOptions value, $Res Function(TimerGroupOptions) then) =
      _$TimerGroupOptionsCopyWithImpl<$Res>;
  $Res call({int timerGroupId, TimeFormat? timeFormat, bool? overTime});
}

/// @nodoc
class _$TimerGroupOptionsCopyWithImpl<$Res>
    implements $TimerGroupOptionsCopyWith<$Res> {
  _$TimerGroupOptionsCopyWithImpl(this._value, this._then);

  final TimerGroupOptions _value;
  // ignore: unused_field
  final $Res Function(TimerGroupOptions) _then;

  @override
  $Res call({
    Object? timerGroupId = freezed,
    Object? timeFormat = freezed,
    Object? overTime = freezed,
  }) {
    return _then(_value.copyWith(
      timerGroupId: timerGroupId == freezed
          ? _value.timerGroupId
          : timerGroupId // ignore: cast_nullable_to_non_nullable
              as int,
      timeFormat: timeFormat == freezed
          ? _value.timeFormat
          : timeFormat // ignore: cast_nullable_to_non_nullable
              as TimeFormat?,
      overTime: overTime == freezed
          ? _value.overTime
          : overTime // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
abstract class _$$_TimerGroupOptionsCopyWith<$Res>
    implements $TimerGroupOptionsCopyWith<$Res> {
  factory _$$_TimerGroupOptionsCopyWith(_$_TimerGroupOptions value,
          $Res Function(_$_TimerGroupOptions) then) =
      __$$_TimerGroupOptionsCopyWithImpl<$Res>;
  @override
  $Res call({int timerGroupId, TimeFormat? timeFormat, bool? overTime});
}

/// @nodoc
class __$$_TimerGroupOptionsCopyWithImpl<$Res>
    extends _$TimerGroupOptionsCopyWithImpl<$Res>
    implements _$$_TimerGroupOptionsCopyWith<$Res> {
  __$$_TimerGroupOptionsCopyWithImpl(
      _$_TimerGroupOptions _value, $Res Function(_$_TimerGroupOptions) _then)
      : super(_value, (v) => _then(v as _$_TimerGroupOptions));

  @override
  _$_TimerGroupOptions get _value => super._value as _$_TimerGroupOptions;

  @override
  $Res call({
    Object? timerGroupId = freezed,
    Object? timeFormat = freezed,
    Object? overTime = freezed,
  }) {
    return _then(_$_TimerGroupOptions(
      timerGroupId: timerGroupId == freezed
          ? _value.timerGroupId
          : timerGroupId // ignore: cast_nullable_to_non_nullable
              as int,
      timeFormat: timeFormat == freezed
          ? _value.timeFormat
          : timeFormat // ignore: cast_nullable_to_non_nullable
              as TimeFormat?,
      overTime: overTime == freezed
          ? _value.overTime
          : overTime // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TimerGroupOptions extends _TimerGroupOptions {
  _$_TimerGroupOptions(
      {required this.timerGroupId, this.timeFormat, this.overTime})
      : super._();

  factory _$_TimerGroupOptions.fromJson(Map<String, dynamic> json) =>
      _$$_TimerGroupOptionsFromJson(json);

  @override
  final int timerGroupId;
  @override
  final TimeFormat? timeFormat;
  @override
  final bool? overTime;

  @override
  String toString() {
    return 'TimerGroupOptions(timerGroupId: $timerGroupId, timeFormat: $timeFormat, overTime: $overTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TimerGroupOptions &&
            const DeepCollectionEquality()
                .equals(other.timerGroupId, timerGroupId) &&
            const DeepCollectionEquality()
                .equals(other.timeFormat, timeFormat) &&
            const DeepCollectionEquality().equals(other.overTime, overTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(timerGroupId),
      const DeepCollectionEquality().hash(timeFormat),
      const DeepCollectionEquality().hash(overTime));

  @JsonKey(ignore: true)
  @override
  _$$_TimerGroupOptionsCopyWith<_$_TimerGroupOptions> get copyWith =>
      __$$_TimerGroupOptionsCopyWithImpl<_$_TimerGroupOptions>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TimerGroupOptionsToJson(
      this,
    );
  }
}

abstract class _TimerGroupOptions extends TimerGroupOptions {
  factory _TimerGroupOptions(
      {required final int timerGroupId,
      final TimeFormat? timeFormat,
      final bool? overTime}) = _$_TimerGroupOptions;
  _TimerGroupOptions._() : super._();

  factory _TimerGroupOptions.fromJson(Map<String, dynamic> json) =
      _$_TimerGroupOptions.fromJson;

  @override
  int get timerGroupId;
  @override
  TimeFormat? get timeFormat;
  @override
  bool? get overTime;
  @override
  @JsonKey(ignore: true)
  _$$_TimerGroupOptionsCopyWith<_$_TimerGroupOptions> get copyWith =>
      throw _privateConstructorUsedError;
}
