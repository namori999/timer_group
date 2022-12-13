// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'timer_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TimerGroup _$TimerGroupFromJson(Map<String, dynamic> json) {
  return _TimerGroup.fromJson(json);
}

/// @nodoc
mixin _$TimerGroup {
  int? get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  TimerGroupOptions? get options => throw _privateConstructorUsedError;
  List<Timer>? get timers => throw _privateConstructorUsedError;
  int? get totalTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TimerGroupCopyWith<TimerGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimerGroupCopyWith<$Res> {
  factory $TimerGroupCopyWith(
          TimerGroup value, $Res Function(TimerGroup) then) =
      _$TimerGroupCopyWithImpl<$Res, TimerGroup>;
  @useResult
  $Res call(
      {int? id,
      String title,
      String? description,
      TimerGroupOptions? options,
      List<Timer>? timers,
      int? totalTime});

  $TimerGroupOptionsCopyWith<$Res>? get options;
}

/// @nodoc
class _$TimerGroupCopyWithImpl<$Res, $Val extends TimerGroup>
    implements $TimerGroupCopyWith<$Res> {
  _$TimerGroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? description = freezed,
    Object? options = freezed,
    Object? timers = freezed,
    Object? totalTime = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      options: freezed == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as TimerGroupOptions?,
      timers: freezed == timers
          ? _value.timers
          : timers // ignore: cast_nullable_to_non_nullable
              as List<Timer>?,
      totalTime: freezed == totalTime
          ? _value.totalTime
          : totalTime // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TimerGroupOptionsCopyWith<$Res>? get options {
    if (_value.options == null) {
      return null;
    }

    return $TimerGroupOptionsCopyWith<$Res>(_value.options!, (value) {
      return _then(_value.copyWith(options: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_TimerGroupCopyWith<$Res>
    implements $TimerGroupCopyWith<$Res> {
  factory _$$_TimerGroupCopyWith(
          _$_TimerGroup value, $Res Function(_$_TimerGroup) then) =
      __$$_TimerGroupCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String title,
      String? description,
      TimerGroupOptions? options,
      List<Timer>? timers,
      int? totalTime});

  @override
  $TimerGroupOptionsCopyWith<$Res>? get options;
}

/// @nodoc
class __$$_TimerGroupCopyWithImpl<$Res>
    extends _$TimerGroupCopyWithImpl<$Res, _$_TimerGroup>
    implements _$$_TimerGroupCopyWith<$Res> {
  __$$_TimerGroupCopyWithImpl(
      _$_TimerGroup _value, $Res Function(_$_TimerGroup) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? description = freezed,
    Object? options = freezed,
    Object? timers = freezed,
    Object? totalTime = freezed,
  }) {
    return _then(_$_TimerGroup(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      options: freezed == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as TimerGroupOptions?,
      timers: freezed == timers
          ? _value._timers
          : timers // ignore: cast_nullable_to_non_nullable
              as List<Timer>?,
      totalTime: freezed == totalTime
          ? _value.totalTime
          : totalTime // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TimerGroup extends _TimerGroup {
  _$_TimerGroup(
      {this.id,
      required this.title,
      this.description,
      this.options,
      final List<Timer>? timers,
      this.totalTime})
      : _timers = timers,
        super._();

  factory _$_TimerGroup.fromJson(Map<String, dynamic> json) =>
      _$$_TimerGroupFromJson(json);

  @override
  final int? id;
  @override
  final String title;
  @override
  final String? description;
  @override
  final TimerGroupOptions? options;
  final List<Timer>? _timers;
  @override
  List<Timer>? get timers {
    final value = _timers;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? totalTime;

  @override
  String toString() {
    return 'TimerGroup(id: $id, title: $title, description: $description, options: $options, timers: $timers, totalTime: $totalTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TimerGroup &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.options, options) || other.options == options) &&
            const DeepCollectionEquality().equals(other._timers, _timers) &&
            (identical(other.totalTime, totalTime) ||
                other.totalTime == totalTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description, options,
      const DeepCollectionEquality().hash(_timers), totalTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TimerGroupCopyWith<_$_TimerGroup> get copyWith =>
      __$$_TimerGroupCopyWithImpl<_$_TimerGroup>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TimerGroupToJson(
      this,
    );
  }
}

abstract class _TimerGroup extends TimerGroup {
  factory _TimerGroup(
      {final int? id,
      required final String title,
      final String? description,
      final TimerGroupOptions? options,
      final List<Timer>? timers,
      final int? totalTime}) = _$_TimerGroup;
  _TimerGroup._() : super._();

  factory _TimerGroup.fromJson(Map<String, dynamic> json) =
      _$_TimerGroup.fromJson;

  @override
  int? get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  TimerGroupOptions? get options;
  @override
  List<Timer>? get timers;
  @override
  int? get totalTime;
  @override
  @JsonKey(ignore: true)
  _$$_TimerGroupCopyWith<_$_TimerGroup> get copyWith =>
      throw _privateConstructorUsedError;
}
