import 'package:freezed_annotation/freezed_annotation.dart';

part 'sound.freezed.dart';

part 'sound.g.dart';

@freezed
class Sound with _$Sound {
  const Sound._();

  factory Sound({
    required String name,
    required String url,
    String? id,
  }) = _Sound;

  factory Sound.fromJson(Map<String, dynamic> json) => _$SoundFromJson(json);
}