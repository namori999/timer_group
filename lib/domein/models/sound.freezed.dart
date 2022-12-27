// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sound.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Sound _$SoundFromJson(Map<String, dynamic> json) {
  return _Sound.fromJson(json);
}

/// @nodoc
mixin _$Sound {
  String get name => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SoundCopyWith<Sound> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SoundCopyWith<$Res> {
  factory $SoundCopyWith(Sound value, $Res Function(Sound) then) =
      _$SoundCopyWithImpl<$Res, Sound>;
  @useResult
  $Res call({String name, String url});
}

/// @nodoc
class _$SoundCopyWithImpl<$Res, $Val extends Sound>
    implements $SoundCopyWith<$Res> {
  _$SoundCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? url = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SoundCopyWith<$Res> implements $SoundCopyWith<$Res> {
  factory _$$_SoundCopyWith(_$_Sound value, $Res Function(_$_Sound) then) =
      __$$_SoundCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String url});
}

/// @nodoc
class __$$_SoundCopyWithImpl<$Res> extends _$SoundCopyWithImpl<$Res, _$_Sound>
    implements _$$_SoundCopyWith<$Res> {
  __$$_SoundCopyWithImpl(_$_Sound _value, $Res Function(_$_Sound) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? url = null,
  }) {
    return _then(_$_Sound(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Sound extends _Sound {
  _$_Sound({required this.name, required this.url}) : super._();

  factory _$_Sound.fromJson(Map<String, dynamic> json) =>
      _$$_SoundFromJson(json);

  @override
  final String name;
  @override
  final String url;

  @override
  String toString() {
    return 'Sound(name: $name, url: $url)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Sound &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SoundCopyWith<_$_Sound> get copyWith =>
      __$$_SoundCopyWithImpl<_$_Sound>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SoundToJson(
      this,
    );
  }
}

abstract class _Sound extends Sound {
  factory _Sound({required final String name, required final String url}) =
      _$_Sound;
  _Sound._() : super._();

  factory _Sound.fromJson(Map<String, dynamic> json) = _$_Sound.fromJson;

  @override
  String get name;
  @override
  String get url;
  @override
  @JsonKey(ignore: true)
  _$$_SoundCopyWith<_$_Sound> get copyWith =>
      throw _privateConstructorUsedError;
}
