// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_image.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SavedImage _$SavedImageFromJson(Map<String, dynamic> json) {
  return _SavedImage.fromJson(json);
}

/// @nodoc
mixin _$SavedImage {
  String get url => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SavedImageCopyWith<SavedImage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SavedImageCopyWith<$Res> {
  factory $SavedImageCopyWith(
          SavedImage value, $Res Function(SavedImage) then) =
      _$SavedImageCopyWithImpl<$Res, SavedImage>;
  @useResult
  $Res call({String url, String name, String? id});
}

/// @nodoc
class _$SavedImageCopyWithImpl<$Res, $Val extends SavedImage>
    implements $SavedImageCopyWith<$Res> {
  _$SavedImageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? name = null,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SavedImageCopyWith<$Res>
    implements $SavedImageCopyWith<$Res> {
  factory _$$_SavedImageCopyWith(
          _$_SavedImage value, $Res Function(_$_SavedImage) then) =
      __$$_SavedImageCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url, String name, String? id});
}

/// @nodoc
class __$$_SavedImageCopyWithImpl<$Res>
    extends _$SavedImageCopyWithImpl<$Res, _$_SavedImage>
    implements _$$_SavedImageCopyWith<$Res> {
  __$$_SavedImageCopyWithImpl(
      _$_SavedImage _value, $Res Function(_$_SavedImage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? name = null,
    Object? id = freezed,
  }) {
    return _then(_$_SavedImage(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SavedImage extends _SavedImage {
  _$_SavedImage({required this.url, required this.name, this.id}) : super._();

  factory _$_SavedImage.fromJson(Map<String, dynamic> json) =>
      _$$_SavedImageFromJson(json);

  @override
  final String url;
  @override
  final String name;
  @override
  final String? id;

  @override
  String toString() {
    return 'SavedImage(url: $url, name: $name, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SavedImage &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, url, name, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SavedImageCopyWith<_$_SavedImage> get copyWith =>
      __$$_SavedImageCopyWithImpl<_$_SavedImage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SavedImageToJson(
      this,
    );
  }
}

abstract class _SavedImage extends SavedImage {
  factory _SavedImage(
      {required final String url,
      required final String name,
      final String? id}) = _$_SavedImage;
  _SavedImage._() : super._();

  factory _SavedImage.fromJson(Map<String, dynamic> json) =
      _$_SavedImage.fromJson;

  @override
  String get url;
  @override
  String get name;
  @override
  String? get id;
  @override
  @JsonKey(ignore: true)
  _$$_SavedImageCopyWith<_$_SavedImage> get copyWith =>
      throw _privateConstructorUsedError;
}
