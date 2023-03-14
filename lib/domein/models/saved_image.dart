import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_image.freezed.dart';

part 'saved_image.g.dart';

@freezed
class SavedImage with _$SavedImage {
  const SavedImage._();

  factory SavedImage({
    required String url,
    required String name,
    String? id,
  }) = _SavedImage;

  factory SavedImage.fromJson(Map<String, dynamic> json) => _$SavedImageFromJson(json);
}