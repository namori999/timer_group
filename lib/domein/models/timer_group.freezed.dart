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
  String? get totalTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TimerGroupCopyWith<TimerGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimerGroupCopyWith<$Res> {
  factory $TimerGroupCopyWith(
          TimerGroup value, $Res Function(TimerGroup) then) =
      _$TimerGroupCopyWithImpl<$Res>;
  $Res call(
      {int? id,
      String title,
      String? description,
      TimerGroupOptions? options,
      List<Timer>? timers,
      String? totalTime});

  $TimerGroupOptionsCopyWith<$Res>? get options;
}

/// @nodoc
class _$TimerGroupCopyWithImpl<$Res> implements $TimerGroupCopyWith<$Res> {
  _$TimerGroupCopyWithImpl(this._value, this._then);

  final TimerGroup _value;
  // ignore: unused_field
  final $Res Function(TimerGroup) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? options = freezed,
    Object? timers = freezed,
    Object? totalTime = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      options: options == freezed
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as TimerGroupOptions?,
      timers: timers == freezed
          ? _value.timers
          : timers // ignore: cast_nullable_to_non_nullable
              as List<Timer>?,
      totalTime: totalTime == freezed
          ? _value.totalTime
          : totalTime // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  @override
  $TimerGroupOptionsCopyWith<$Res>? get options {
    if (_value.options == null) {
      return null;
    }

    return $TimerGroupOptionsCopyWith<$Res>(_value.options!, (value) {
      return _then(_value.copyWith(options: value));
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
  $Res call(
      {int? id,
      String title,
      String? description,
      TimerGroupOptions? options,
      List<Timer>? timers,
      String? totalTime});

  @override
  $TimerGroupOptionsCopyWith<$Res>? get options;
}

/// @nodoc
class __$$_TimerGroupCopyWithImpl<$Res> extends _$TimerGroupCopyWithImpl<$Res>
    implements _$$_TimerGroupCopyWith<$Res> {
  __$$_TimerGroupCopyWithImpl(
      _$_TimerGroup _value, $Res Function(_$_TimerGroup) _then)
      : super(_value, (v) => _then(v as _$_TimerGroup));

  @override
  _$_TimerGroup get _value => super._value as _$_TimerGroup;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? options = freezed,
    Object? timers = freezed,
    Object? totalTime = freezed,
  }) {
    return _then(_$_TimerGroup(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      options: options == freezed
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as TimerGroupOptions?,
      timers: timers == freezed
          ? _value._timers
          : timers // ignore: cast_nullable_to_non_nullable
              as List<Timer>?,
      totalTime: totalTime == freezed
          ? _value.totalTime
          : totalTime // ignore: cast_nullable_to_non_nullable
              as String?,
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
  final String? totalTime;

  @override
  String toString() {
    return 'TimerGroup(id: $id, title: $title, description: $description, options: $options, timers: $timers, totalTime: $totalTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TimerGroup &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.options, options) &&
            const DeepCollectionEquality().equals(other._timers, _timers) &&
            const DeepCollectionEquality().equals(other.totalTime, totalTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(options),
      const DeepCollectionEquality().hash(_timers),
      const DeepCollectionEquality().hash(totalTime));

  @JsonKey(ignore: true)
  @override
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
      final String? totalTime}) = _$_TimerGroup;
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
  String? get totalTime;
  @override
  @JsonKey(ignore: true)
  _$$_TimerGroupCopyWith<_$_TimerGroup> get copyWith =>
      throw _privateConstructorUsedError;
}
