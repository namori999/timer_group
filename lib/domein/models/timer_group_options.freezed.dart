// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
  int get id => throw _privateConstructorUsedError;
  TimeFormat? get timeFormat => throw _privateConstructorUsedError;
  String? get overTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TimerGroupOptionsCopyWith<TimerGroupOptions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimerGroupOptionsCopyWith<$Res> {
  factory $TimerGroupOptionsCopyWith(
          TimerGroupOptions value, $Res Function(TimerGroupOptions) then) =
      _$TimerGroupOptionsCopyWithImpl<$Res, TimerGroupOptions>;
  @useResult
  $Res call({int id, TimeFormat? timeFormat, String? overTime});
}

/// @nodoc
class _$TimerGroupOptionsCopyWithImpl<$Res, $Val extends TimerGroupOptions>
    implements $TimerGroupOptionsCopyWith<$Res> {
  _$TimerGroupOptionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timeFormat = freezed,
    Object? overTime = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      timeFormat: freezed == timeFormat
          ? _value.timeFormat
          : timeFormat // ignore: cast_nullable_to_non_nullable
              as TimeFormat?,
      overTime: freezed == overTime
          ? _value.overTime
          : overTime // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TimerGroupOptionsCopyWith<$Res>
    implements $TimerGroupOptionsCopyWith<$Res> {
  factory _$$_TimerGroupOptionsCopyWith(_$_TimerGroupOptions value,
          $Res Function(_$_TimerGroupOptions) then) =
      __$$_TimerGroupOptionsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, TimeFormat? timeFormat, String? overTime});
}

/// @nodoc
class __$$_TimerGroupOptionsCopyWithImpl<$Res>
    extends _$TimerGroupOptionsCopyWithImpl<$Res, _$_TimerGroupOptions>
    implements _$$_TimerGroupOptionsCopyWith<$Res> {
  __$$_TimerGroupOptionsCopyWithImpl(
      _$_TimerGroupOptions _value, $Res Function(_$_TimerGroupOptions) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timeFormat = freezed,
    Object? overTime = freezed,
  }) {
    return _then(_$_TimerGroupOptions(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      timeFormat: freezed == timeFormat
          ? _value.timeFormat
          : timeFormat // ignore: cast_nullable_to_non_nullable
              as TimeFormat?,
      overTime: freezed == overTime
          ? _value.overTime
          : overTime // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TimerGroupOptions extends _TimerGroupOptions {
  _$_TimerGroupOptions({required this.id, this.timeFormat, this.overTime})
      : super._();

  factory _$_TimerGroupOptions.fromJson(Map<String, dynamic> json) =>
      _$$_TimerGroupOptionsFromJson(json);

  @override
  final int id;
  @override
  final TimeFormat? timeFormat;
  @override
  final String? overTime;

  @override
  String toString() {
    return 'TimerGroupOptions(id: $id, timeFormat: $timeFormat, overTime: $overTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TimerGroupOptions &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.timeFormat, timeFormat) ||
                other.timeFormat == timeFormat) &&
            (identical(other.overTime, overTime) ||
                other.overTime == overTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, timeFormat, overTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
      {required final int id,
      final TimeFormat? timeFormat,
      final String? overTime}) = _$_TimerGroupOptions;
  _TimerGroupOptions._() : super._();

  factory _TimerGroupOptions.fromJson(Map<String, dynamic> json) =
      _$_TimerGroupOptions.fromJson;

  @override
  int get id;
  @override
  TimeFormat? get timeFormat;
  @override
  String? get overTime;
  @override
  @JsonKey(ignore: true)
  _$$_TimerGroupOptionsCopyWith<_$_TimerGroupOptions> get copyWith =>
      throw _privateConstructorUsedError;
}
