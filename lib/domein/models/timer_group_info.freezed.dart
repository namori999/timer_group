// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'timer_group_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TimerGroupInfo _$TimerGroupInfoFromJson(Map<String, dynamic> json) {
  return _TimerGroupInfo.fromJson(json);
}

/// @nodoc
mixin _$TimerGroupInfo {
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TimerGroupInfoCopyWith<TimerGroupInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimerGroupInfoCopyWith<$Res> {
  factory $TimerGroupInfoCopyWith(
          TimerGroupInfo value, $Res Function(TimerGroupInfo) then) =
      _$TimerGroupInfoCopyWithImpl<$Res, TimerGroupInfo>;
  @useResult
  $Res call({String title, String? description});
}

/// @nodoc
class _$TimerGroupInfoCopyWithImpl<$Res, $Val extends TimerGroupInfo>
    implements $TimerGroupInfoCopyWith<$Res> {
  _$TimerGroupInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TimerGroupInfoCopyWith<$Res>
    implements $TimerGroupInfoCopyWith<$Res> {
  factory _$$_TimerGroupInfoCopyWith(
          _$_TimerGroupInfo value, $Res Function(_$_TimerGroupInfo) then) =
      __$$_TimerGroupInfoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String? description});
}

/// @nodoc
class __$$_TimerGroupInfoCopyWithImpl<$Res>
    extends _$TimerGroupInfoCopyWithImpl<$Res, _$_TimerGroupInfo>
    implements _$$_TimerGroupInfoCopyWith<$Res> {
  __$$_TimerGroupInfoCopyWithImpl(
      _$_TimerGroupInfo _value, $Res Function(_$_TimerGroupInfo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = freezed,
  }) {
    return _then(_$_TimerGroupInfo(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TimerGroupInfo extends _TimerGroupInfo {
  _$_TimerGroupInfo({required this.title, this.description}) : super._();

  factory _$_TimerGroupInfo.fromJson(Map<String, dynamic> json) =>
      _$$_TimerGroupInfoFromJson(json);

  @override
  final String title;
  @override
  final String? description;

  @override
  String toString() {
    return 'TimerGroupInfo(title: $title, description: $description)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TimerGroupInfo &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TimerGroupInfoCopyWith<_$_TimerGroupInfo> get copyWith =>
      __$$_TimerGroupInfoCopyWithImpl<_$_TimerGroupInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TimerGroupInfoToJson(
      this,
    );
  }
}

abstract class _TimerGroupInfo extends TimerGroupInfo {
  factory _TimerGroupInfo(
      {required final String title,
      final String? description}) = _$_TimerGroupInfo;
  _TimerGroupInfo._() : super._();

  factory _TimerGroupInfo.fromJson(Map<String, dynamic> json) =
      _$_TimerGroupInfo.fromJson;

  @override
  String get title;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$_TimerGroupInfoCopyWith<_$_TimerGroupInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
