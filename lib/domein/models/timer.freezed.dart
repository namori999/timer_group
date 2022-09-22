// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
  int? get id => throw _privateConstructorUsedError;
  int get index => throw _privateConstructorUsedError;
  int get time => throw _privateConstructorUsedError; // timeはぜんぶ 秒 で管理
  String get soundPath => throw _privateConstructorUsedError;
  String get bgmPath => throw _privateConstructorUsedError;
  String get imagePath => throw _privateConstructorUsedError;
  String get notification => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TimerCopyWith<Timer> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimerCopyWith<$Res> {
  factory $TimerCopyWith(Timer value, $Res Function(Timer) then) =
      _$TimerCopyWithImpl<$Res>;
  $Res call(
      {int? id,
      int index,
      int time,
      String soundPath,
      String bgmPath,
      String imagePath,
      String notification});
}

/// @nodoc
class _$TimerCopyWithImpl<$Res> implements $TimerCopyWith<$Res> {
  _$TimerCopyWithImpl(this._value, this._then);

  final Timer _value;
  // ignore: unused_field
  final $Res Function(Timer) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? index = freezed,
    Object? time = freezed,
    Object? soundPath = freezed,
    Object? bgmPath = freezed,
    Object? imagePath = freezed,
    Object? notification = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      index: index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      time: time == freezed
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
      soundPath: soundPath == freezed
          ? _value.soundPath
          : soundPath // ignore: cast_nullable_to_non_nullable
              as String,
      bgmPath: bgmPath == freezed
          ? _value.bgmPath
          : bgmPath // ignore: cast_nullable_to_non_nullable
              as String,
      imagePath: imagePath == freezed
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String,
      notification: notification == freezed
          ? _value.notification
          : notification // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_TimerCopyWith<$Res> implements $TimerCopyWith<$Res> {
  factory _$$_TimerCopyWith(_$_Timer value, $Res Function(_$_Timer) then) =
      __$$_TimerCopyWithImpl<$Res>;
  @override
  $Res call(
      {int? id,
      int index,
      int time,
      String soundPath,
      String bgmPath,
      String imagePath,
      String notification});
}

/// @nodoc
class __$$_TimerCopyWithImpl<$Res> extends _$TimerCopyWithImpl<$Res>
    implements _$$_TimerCopyWith<$Res> {
  __$$_TimerCopyWithImpl(_$_Timer _value, $Res Function(_$_Timer) _then)
      : super(_value, (v) => _then(v as _$_Timer));

  @override
  _$_Timer get _value => super._value as _$_Timer;

  @override
  $Res call({
    Object? id = freezed,
    Object? index = freezed,
    Object? time = freezed,
    Object? soundPath = freezed,
    Object? bgmPath = freezed,
    Object? imagePath = freezed,
    Object? notification = freezed,
  }) {
    return _then(_$_Timer(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      index: index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      time: time == freezed
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
      soundPath: soundPath == freezed
          ? _value.soundPath
          : soundPath // ignore: cast_nullable_to_non_nullable
              as String,
      bgmPath: bgmPath == freezed
          ? _value.bgmPath
          : bgmPath // ignore: cast_nullable_to_non_nullable
              as String,
      imagePath: imagePath == freezed
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String,
      notification: notification == freezed
          ? _value.notification
          : notification // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Timer extends _Timer {
  _$_Timer(
      {this.id,
      required this.index,
      required this.time,
      required this.soundPath,
      required this.bgmPath,
      required this.imagePath,
      required this.notification})
      : super._();

  factory _$_Timer.fromJson(Map<String, dynamic> json) =>
      _$$_TimerFromJson(json);

  @override
  final int? id;
  @override
  final int index;
  @override
  final int time;
// timeはぜんぶ 秒 で管理
  @override
  final String soundPath;
  @override
  final String bgmPath;
  @override
  final String imagePath;
  @override
  final String notification;

  @override
  String toString() {
    return 'Timer(id: $id, index: $index, time: $time, soundPath: $soundPath, bgmPath: $bgmPath, imagePath: $imagePath, notification: $notification)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Timer &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.index, index) &&
            const DeepCollectionEquality().equals(other.time, time) &&
            const DeepCollectionEquality().equals(other.soundPath, soundPath) &&
            const DeepCollectionEquality().equals(other.bgmPath, bgmPath) &&
            const DeepCollectionEquality().equals(other.imagePath, imagePath) &&
            const DeepCollectionEquality()
                .equals(other.notification, notification));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(index),
      const DeepCollectionEquality().hash(time),
      const DeepCollectionEquality().hash(soundPath),
      const DeepCollectionEquality().hash(bgmPath),
      const DeepCollectionEquality().hash(imagePath),
      const DeepCollectionEquality().hash(notification));

  @JsonKey(ignore: true)
  @override
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
      {final int? id,
      required final int index,
      required final int time,
      required final String soundPath,
      required final String bgmPath,
      required final String imagePath,
      required final String notification}) = _$_Timer;
  _Timer._() : super._();

  factory _Timer.fromJson(Map<String, dynamic> json) = _$_Timer.fromJson;

  @override
  int? get id;
  @override
  int get index;
  @override
  int get time;
  @override // timeはぜんぶ 秒 で管理
  String get soundPath;
  @override
  String get bgmPath;
  @override
  String get imagePath;
  @override
  String get notification;
  @override
  @JsonKey(ignore: true)
  _$$_TimerCopyWith<_$_Timer> get copyWith =>
      throw _privateConstructorUsedError;
}
